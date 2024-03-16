import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:date_format/date_format.dart';
import 'package:excuse_demo/common/page_jump_animation.dart';
import 'package:excuse_demo/main.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:excuse_demo/views/event/event_chat.dart';
import 'package:excuse_demo/views/event/event_edit.dart';
import 'package:flutter/material.dart';

class UpdateBottomButton {
  String text;

  UpdateBottomButton(this.text);
}

class EventDetailsPage extends StatefulWidget {
  final Event event;
  final User user;

  const EventDetailsPage({Key? key, required this.event, required this.user})
      : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late StreamSubscription sub;
  late IconData _icon = Icons.check_circle_outline_rounded;
  late String _text = "接下这单";
  late dynamic _action = acceptEvent(widget.event.id, widget.user.id);

  Widget getPatternWidget(int pattern, int recipientID, int creatorId) {
    final isRecipientOrCreator =
        recipientID == widget.user.id || creatorId == widget.user.id;

    return Container(
      width: isRecipientOrCreator ? 200 : 250,
      height: 65,
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            const Icon(Icons.phone_android_outlined),
            const Text("电话："),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                child: Text(
                  isRecipientOrCreator
                      ? widget.event.creator.phone
                      : "只有接单者可以看嗷",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getUrgencyWidget(int urgency) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "●",
          style: TextStyle(
            color: urgency == 0
                ? Colors.green
                : urgency == 1
                    ? Colors.amber
                    : Colors.red,
          ),
        ),
        Text(
          urgency == 0
              ? "不太急"
              : urgency == 1
                  ? "有点急"
                  : "很急！",
        ),
      ],
    );
  }

  Widget getAppBarButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: widget.event.creator.id == widget.user.id
          ? IconButton(
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
            )
          : IconButton(
        icon: const Icon(Icons.sms_failed_rounded),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("举报事件违规"),
              content: const Text("举报次数达到5次后事件将被删除"),
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
                    reportEvent(widget.event.id);
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
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    sub = eventBus.on<UpdateBottomButton>().listen((event) {
      setState(() {
        _icon = Icons.cancel_outlined;
        _text = event.text;
        _action = null;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("事件详情"),
        centerTitle: true,
        elevation: 1,
        actions: [getAppBarButton()],
      ),
      body: Column(
        children: [
          Container(
            height: 110,
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.event.creator.name}：",
                  style: const TextStyle(fontSize: 24),
                ),
                Text(widget.event.creator.isLogout ? "在线" : "离线"),
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
                getPatternWidget(widget.event.pattern, widget.event.recipientId,
                    widget.event.creatorId),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildBottomBar() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.event.creator.id != widget.user.id
            ? buildRecipientBottomBar()
            : buildCreatorBottomBar(),
      ),
    );
  }

  List<Widget> buildRecipientBottomBar() {
    return [
      buildElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            CustomRouteSlideRight(
                EventChatPage(event: widget.event, user: widget.user)),
          );
        },
        icon: Icons.chat_outlined,
        label: "和TA聊聊",
      ),
      buildElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("$_text？"),
              actions: <Widget>[
                TextButton(
                  child: const Text("否", style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text("是", style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    _action;
                    // acceptEvent(widget.event.id, widget.user.id);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
        icon: _icon,
        label: _text,
      ),
    ];
  }

  List<Widget> buildCreatorBottomBar() {
    return [
      buildElevatedButton(
        onPressed: () {},
        icon: Icons.attach_money_rounded,
        label: "增加佣金",
      ),
      buildElevatedButton(
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
        icon: Icons.edit_note_rounded,
        label: "编辑",
      ),
    ];
  }

  Widget buildElevatedButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return Container(
      height: 50,
      width: 180,
      padding: const EdgeInsets.only(left: 20, right: 10, top: 3, bottom: 3),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon), Text(label)],
        ),
      ),
    );
  }
}
