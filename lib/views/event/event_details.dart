import 'package:date_format/date_format.dart';
import 'package:excuse_demo/common/page_jump_animation.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:excuse_demo/views/event/event_edit.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;
  final User user;

  const EventDetailsPage(
      {super.key,
      required this.event,
      required this.user});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  getPatternWidget(int pattern, int recipientID) {
    if (pattern == 0) {
      if (recipientID == widget.user.id) {
        return Container(
          width: 200,
          height: 65,
          padding: const EdgeInsets.only(top: 20),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.phone_android_outlined),
                const Text("电话："),
                Text(widget.event.creator.phone),
              ],
            ),
          ),
        );
      } else {
        return Container(
          width: 250,
          height: 65,
          padding: const EdgeInsets.only(top: 20),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.phone_android_outlined),
                const Text("电话："),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    child: const Text(
                      "只有接单者可以看嗷",
                      // overflow: TextOverflow.visible,
                      // softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } else {
      if (recipientID == widget.user.id) {
        return Container(
          width: 300,
          // height: 65,
          padding: const EdgeInsets.only(top: 20),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.location_on_outlined),
                const Text("位置："),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      widget.event.location,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Container(
          width: 240,
          // height: 65,
          padding: const EdgeInsets.only(top: 20),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.location_on_outlined),
                const Text("位置："),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    child: const Text(
                      "只有接单者可以看嗷",
                      // overflow: TextOverflow.visible,
                      // softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  getUrgencyWidget(int urgency) {
    if (widget.event.urgency == 0) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "●",
            style: TextStyle(color: Colors.green),
          ),
          Text("不太急"),
        ],
      );
    } else if (widget.event.urgency == 1) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "●",
            style: TextStyle(color: Colors.amber),
          ),
          Text("有点急"),
        ],
      );
    } else {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "●",
            style: TextStyle(color: Colors.red),
          ),
          Text("很急！"),
        ],
      );
    }
  }

  getAppBarButton() {
    if (widget.event.creator.id == widget.user.id) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: IconButton(
          icon: const Icon(Icons.delete_outline_rounded),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("删除此事件？"),
                content: const Text("此操作不可恢复"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("取消"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text("确定"),
                    onPressed: () {
                      deleteEvent(widget.event.id);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.sms_failed_rounded),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("事件详情"),
        centerTitle: true,
        elevation: 1,
        actions: [
          getAppBarButton(),
          // Container(
          //   padding: EdgeInsets.all(10),
          //   child: Icon(Icons.sms_failed_rounded),
          // )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 110,
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.event.creator.name}：",
                  style: const TextStyle(fontSize: 24),
                ),
                Text(widget.event.creator.isLogout ? "离线" : "在线"),
                Text("最后更新于${formatDate(widget.event.updatedAt, [
                      yyyy,
                      '年',
                      mm,
                      '月',
                      dd,
                      '日',
                      HH,
                      ':',
                      mm
                    ])}")
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.grey,
            height: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.event.details),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 65,
                      padding: const EdgeInsets.only(top: 20),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("方式："),
                            Text(widget.event.pattern == 0 ? "电话 📱" : "现场 🏃"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 65,
                      padding: const EdgeInsets.only(top: 20),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("佣金："),
                            Text(widget.event.commission.isEmpty ||
                                    double.parse(widget.event.commission) == 0.0
                                ? "无"
                                : "￥${widget.event.commission}元"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 65,
                      padding: const EdgeInsets.only(top: 20),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        child: getUrgencyWidget(widget.event.urgency),
                      ),
                    ),
                  ],
                ),
                getPatternWidget(
                    widget.event.pattern, widget.event.recipientId),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  buildBottomBar() {
    if (widget.event.creator.id != widget.user.id) {
      return BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 180,
              padding:
                  const EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[100],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.chat_outlined), Text("和TA聊聊")],
                ),
              ),
            ),
            Container(
              height: 50,
              width: 180,
              padding:
                  const EdgeInsets.only(left: 10, right: 20, top: 3, bottom: 3),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("接下此事件？"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            "否",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text(
                            "是",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            acceptEvent(widget.event.id, widget.user.id);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[100],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline_rounded),
                    Text("接下这单")
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 180,
              padding:
                  const EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[100],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.attach_money_rounded), Text("增加佣金")],
                ),
              ),
            ),
            Container(
              height: 50,
              width: 180,
              padding:
                  const EdgeInsets.only(left: 10, right: 20, top: 3, bottom: 3),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomRouteSlideLeft(
                      EventEditPage(
                        event: widget.event,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[100],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.edit_note_rounded), Text("编辑")],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
