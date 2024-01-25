import 'dart:convert';
import 'package:excuse_demo/components/cells/event/event_cell.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublishedEventsPage extends StatefulWidget {
  final User user;

  const PublishedEventsPage({super.key, required this.user});

  @override
  State<PublishedEventsPage> createState() => _EventPageState();
}

class _EventPageState extends State<PublishedEventsPage> {
  List<Event> _publishedEvents = [];

  Future<List<Event>> _getPublishedEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var eventsStr = prefs.getString("publishedEvents");
    var eventsJson = jsonDecode(eventsStr.toString());
    _publishedEvents = EventsData.fromJson(eventsJson).events;
    // print("==========${jsonEncode(_acceptedEvents)}==========");
    return _publishedEvents;
  }

  @override
  void initState() {
    super.initState();

    _getPublishedEvents().then((List<Event> eventsData) {
      setState(() {
        _publishedEvents = eventsData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我发布的事件"),
        centerTitle: true,
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getPublishedEventsList(widget.user.id);
          _getPublishedEvents().then((List<Event> eventsData) {
            setState(() {
              _publishedEvents = eventsData;
            });
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                itemCount: _publishedEvents.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return EventCell(
                    event: _publishedEvents[index],
                    user: widget.user,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "没有更多了",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
