import 'dart:async';
import 'dart:convert';

import 'package:excuse_demo/common/page_jump_animation.dart';
import 'package:excuse_demo/main.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:excuse_demo/service/user_service.dart';
import 'package:excuse_demo/views/event/event_accepted_list.dart';
import 'package:excuse_demo/views/event/event_published_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class GetLatestUserInfo {
  User user;

  GetLatestUserInfo(this.user);
}

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  late StreamSubscription sub;
  late User _user;

  Future<User> _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userStr = prefs.getString("user");
    var userJson = jsonDecode(userStr.toString());
    _user = UserData.fromJson(userJson).user;
    // print("+++++${jsonEncode(_user)}+++++");
    return _user;
  }

  getUserBalance() {
    if (_user.balance.isEmpty) {
      return const Text("￥0.00");
    } else {
      return Text("￥${double.parse(_user.balance).toStringAsFixed(2)}");
    }
  }

  @override
  void initState() {
    super.initState();

    _getUserInfo().then((User user) {
      setState(() {
        _user = user;
      });
    });

    sub = eventBus.on<GetLatestUserInfo>().listen((event) {
      setState(() {
        _user=event.user;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await findUserById(_user.id);
          _getUserInfo().then((User user) {
            setState(() {
              _user = user;
            });
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.12,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 0),
                child: Card(
                  color: const Color(0x00000000),
                  elevation: 0,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _user.name,
                            style: const TextStyle(fontSize: 28),
                          ),
                          Text(
                            _user.phone,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const Text(
                            "_user.email",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 15),
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: GestureDetector(
                          onTap: () async {
                            await getPublishedEventsList(_user.id);
                            Navigator.push(
                              context,
                              CustomRouteSlideRight(
                                  PublishedEventsPage(user: _user)),
                            ).then((value) async {
                              await findUserById(_user.id);
                              _getUserInfo().then((User user) {
                                setState(() {
                                  _user = user;
                                });
                              });
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("我发布的"),
                              Text(_user.publicationsNum.toString()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                        height: 30,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: GestureDetector(
                          onTap: () async {
                            await getAcceptedEventsList(_user.id);
                            Navigator.push(
                              context,
                              CustomRouteSlideRight(
                                  AcceptedEventsPage(user: _user)),
                            ).then((value) async {
                              await findUserById(_user.id);
                              _getUserInfo().then((User user) {
                                setState(() {
                                  _user = user;
                                });
                              });
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("正在进行"),
                              Text(_user.ongoingNum.toString()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                        height: 30,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("剩余发布数"),
                            Text("${_user.remainingTimes}"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                        height: 30,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("钱包余额"),
                            Container(
                              child: getUserBalance(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 15),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                        child: Text("1"),
                      ),
                      Container(
                        color: Colors.black,
                        height: 1.0,
                      ),
                      const SizedBox(
                        height: 60,
                        child: Text("2"),
                      ),
                      Container(
                        color: Colors.black,
                        height: 1.0,
                      ),
                      const SizedBox(
                        height: 60,
                        child: Text("3"),
                      ),
                      Container(
                        color: Colors.black,
                        height: 1.0,
                      ),
                      const SizedBox(
                        height: 60,
                        child: Text("4"),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 80,
                    padding: const EdgeInsets.only(
                        left: 30, right: 10, top: 20, bottom: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/updateInfo");
                      },
                      child: const Text(
                        "更新信息",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 80,
                    padding: const EdgeInsets.only(
                        left: 10, right: 30, top: 20, bottom: 5),
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        logoutService(_user.id);
                        prefs.remove("user");
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (route) => false);
                      },
                      child: const Text(
                        "退出登录",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
