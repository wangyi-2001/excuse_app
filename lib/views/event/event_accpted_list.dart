import 'dart:convert';
import 'package:excuse_demo/components/cells/event/event_cell.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptedEventsPage extends StatefulWidget {
  final User user;

  const AcceptedEventsPage({super.key, required this.user});

  @override
  State<AcceptedEventsPage> createState() => _EventPageState();
}

class _EventPageState extends State<AcceptedEventsPage> {
  List<Event> _acceptedEvents = [];

  Future<List<Event>> _getAcceptedEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var eventsStr = prefs.getString("acceptedEvents");
    var eventsJson = jsonDecode(eventsStr.toString());
    _acceptedEvents = EventsData.fromJson(eventsJson).events;
    // print("==========${jsonEncode(_acceptedEvents)}==========");
    return _acceptedEvents;
  }

  @override
  void initState() {
    super.initState();

    _getAcceptedEvents().then((List<Event> eventsData) {
      setState(() {
        _acceptedEvents = eventsData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我接受的事件"),
        centerTitle: true,
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getAcceptedEventsList(widget.user.id);
          _getAcceptedEvents().then((List<Event> eventsData) {
            setState(() {
              _acceptedEvents = eventsData;
            });
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                itemCount: _acceptedEvents.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return EventCell(
                    event: _acceptedEvents[index],
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
