import 'dart:convert';
import 'package:excuse_demo/components/cells/event/event_cell.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceptedEventsPage extends StatefulWidget {
  const AcceptedEventsPage({super.key});

  @override
  State<AcceptedEventsPage> createState() => _EventPageState();
}

class _EventPageState extends State<AcceptedEventsPage> {
  List<Event> _acceptedEvents = [];
  late User _user;

  Future<User> _getUser() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var userStr=prefs.getString("user");
    var userJson=jsonDecode(userStr.toString());
    _user=UserData.fromJson(userJson).user;
    print("=====${jsonEncode(_user)}=====");
    return _user;
  }

  Future<List<Event>> _getEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var eventsStr = prefs.getString("acceptedEvents");
    var eventsJson = jsonDecode(eventsStr.toString());
    _acceptedEvents = EventsData.fromJson(eventsJson).events;
    print("==========${jsonEncode(_acceptedEvents)}==========");
    return _acceptedEvents;
  }

  @override
  void initState() {
    super.initState();
    getAcceptedEventsList();

    _getEvents().then((List<Event> eventsData) {
      setState(() {
        _acceptedEvents = eventsData;
      });
    });

    _getUser().then((User user) {
      setState(() {
        _user = user;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getEventsList();
        setState(() {
          _getEvents().then((List<Event> eventsData) {
            setState(() {
              _acceptedEvents = eventsData;
            });
          });
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("我接受的事件"),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    createUser: _acceptedEvents[index].creator,
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
