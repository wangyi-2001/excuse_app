import 'dart:convert';
import 'package:excuse_demo/components/cells/event/event_cell.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
with AutomaticKeepAliveClientMixin{
  List<Event> _events = [];

  Future<List<Event>> _getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var eventsStr = prefs.getString("events");
    var eventsJson = jsonDecode(eventsStr.toString());
    _events = EventsData.fromJson(eventsJson).events;
    print("==========${jsonEncode(_events)}==========");
    return _events;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _getEvents().then((List<Event> eventsData) {
      setState(() {
        _events = eventsData;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        getEventsList();
        setState(() {
          _getEvents().then((List<Event> eventsData) {
            setState(() {
              _events = eventsData;
            });
          });
        });
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                itemCount: _events.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return EventCell(
                    event: _events[index],
                    createUser: _events[index].creator,
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
