class Message {
  final int id;
  final String sender;
  final String recipient;
  final String text;
  final DateTime timestamp;

  Message({required this.id, required this.sender, required this.recipient, required this.text, required this.timestamp});

  // 将 Message 对象转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'recipient': recipient,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}