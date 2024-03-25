import 'dart:async';
import 'dart:convert';
import 'package:excuse_demo/components/cells/event/event_cell.dart';
import 'package:excuse_demo/main.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLatestEventsList{
  List<Event> events;
  GetLatestEventsList(this.events);
}

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage>
    with AutomaticKeepAliveClientMixin {
  late StreamSubscription sub;

  List<Event> _events = [];
  late User _user;

  Future<User> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userStr = prefs.getString("user");
    var userJson = jsonDecode(userStr.toString());
    _user = UserData.fromJson(userJson).user;
    return _user;
  }

  Future<List<Event>> _getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var eventsStr = prefs.getString("events");
    var eventsJson = jsonDecode(eventsStr.toString());
    _events = EventsData.fromJson(eventsJson).events;
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

    _getUser().then((User user) {
      setState(() {
        _user = user;
      });
    });

    sub=eventBus.on<GetLatestEventsList>().listen((event) {
      setState(() {
        _events=event.events;
      });
    });
  }

  @override
  void dispose(){
    super.dispose();

    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await getEventsList();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                    user: _user,
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
