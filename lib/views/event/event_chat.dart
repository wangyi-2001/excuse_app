import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/models/message.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:web_socket_channel/io.dart';

class EventChatPage extends StatefulWidget {
  final User user;
  final Event event;
  const EventChatPage({super.key, required this.user, required this.event});

  @override
  State<EventChatPage> createState() => _EventChatPageState();
}

class _EventChatPageState extends State<EventChatPage> {

  final TextEditingController _textController = TextEditingController();
  late IOWebSocketChannel _channel;
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _initWebSocket();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'chat_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE messages(id INTEGER PRIMARY KEY AUTOINCREMENT, sender TEXT, recipient TEXT, text TEXT, timestamp TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> _insertMessage(Message message) async {
    await _database.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void _initWebSocket() {
    _channel = IOWebSocketChannel.connect('ws://localhost:8081/ws?user_id=${widget.user.id}');

    // StreamBuilder 用于处理接收到的消息
    _channel.stream.listen((data) {
      if (data != null) {
        final receivedMessage = Message(
          id: 0,
          sender: data['sender'],
          recipient: data['recipient'],
          text: data['text'],
          timestamp: DateTime.now(),
        );

        // 将接收到的消息存储到SQLite
        _insertMessage(receivedMessage);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("和${widget.event.creator.name}的私聊"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Message>>(
              future: _getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final messages = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(messages[index].text),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // 将消息发送到后端
                    final sentMessage = Message(
                      id: 0,
                      sender: 'YOUR_USER_ID',
                      recipient: 'RECIPIENT_USER_ID',
                      text: _textController.text,
                      timestamp: DateTime.now(),
                    );

                    // 将发送的消息存储到SQLite
                    _insertMessage(sentMessage);

                    _channel.sink.add('{"recipient": "${sentMessage.recipient}", "text": "${sentMessage.text}"}');
                    _textController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Message>> _getMessages() async {
    final List<Map<String, dynamic>> maps = await _database.query('messages');
    return List.generate(maps.length, (i) {
      return Message(
        id: maps[i]['id'],
        sender: maps[i]['sender'],
        recipient: maps[i]['recipient'],
        text: maps[i]['text'],
        timestamp: DateTime.parse(maps[i]['timestamp']),
      );
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

