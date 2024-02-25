import 'package:excuse_demo/common/page_jump_animation.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/views/event/event_details.dart';
import 'package:flutter/material.dart';

class EventCell extends StatelessWidget {
  final Event event;
  final User user;

  const EventCell({
    super.key,
    required this.event,
    required this.user,
  });

  getUrgency(int urgency) {
    if(event.status==0) {
      switch (urgency) {
        case 0:
          return const Text(
            "●",
            style: TextStyle(color: Colors.green, fontSize: 16),
          );
        case 1:
          return const Text(
            "●",
            style: TextStyle(color: Colors.amber, fontSize: 17),
          );
        case 2:
          return const Text(
            "●",
            style: TextStyle(color: Colors.red, fontSize: 18),
          );
      }
    }else if(event.status==1){
      return const Text("进行中");
    }else if(event.status==2){
      return const Text("已结束");
    }else{
      return const Text("等待对方结果");
    }
  }

  getPattern(int pattern) {
    if (pattern == 0) {
      return const Text("电话 📱");
    } else {
      return const Text("现场 🏃‍");
    }
  }

  getCommission(String commission) {
    if (commission.isEmpty) {
      return const Text("无佣金");
    } else {
      return Text("佣金￥${double.parse(commission).toStringAsFixed(2)}元");
    }
  }

  getEventStatus(){
    if(event.status==0){
      return const SizedBox();
    }else{
      return Row(
        children: [
          const Text(" -> "),
        Text(event.recipient.name),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Colors.blue[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 310,
                padding: const EdgeInsets.only(left: 35, top: 8, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      event.creator.name,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    getEventStatus(),
                  ],
                ),
              ),
              Container(
                  height: 40,
                  padding: const EdgeInsets.only(top: 8, bottom: 5),
                  child: getUrgency(event.urgency)),
            ],
          ),
          Container(
            color: const Color.fromARGB(255, 240, 240, 240),
            height: 1.0,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: const Text(
                  "详\n情",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                width: 1,
                height: 30,
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 240, 240, 240)),
                ),
              ),
              Container(
                width: 300,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Text(
                  event.details,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Container(
            color: const Color.fromARGB(255, 240, 240, 240),
            height: 1.0,
          ),
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 5),
                child: getPattern(event.pattern),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 150,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 5),
                  child: getCommission(event.commission),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CustomRouteSlideRight(
                        EventDetailsPage(
                          event: event,
                          user: user,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                  ),
                  child: const SizedBox(
                    width: 60,
                    child: Text(
                      "查看事件",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
