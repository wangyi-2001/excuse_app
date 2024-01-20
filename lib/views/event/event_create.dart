import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  var _value_u = null;
  var _value_p = null;
  var isOpen = false;

  late TextEditingController _locationController;
  late TextEditingController _detailsController;

  // late MenuController _urgencyController;
  // late MenuController _patternController;
  late TextEditingController _commissionController;

  @override
  void initState() {
    super.initState();

    _locationController = TextEditingController();
    _detailsController = TextEditingController();
    // _urgencyController = MenuController();
    // _patternController = MenuController();
    _commissionController = TextEditingController();
  }

  Future<User> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userStr = prefs.get("user");
    var userJson = jsonDecode(userStr.toString());
    User user = UserData.fromJson(userJson).user;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("发起求助"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 1,
        actions: [
          buildSubmitButton(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              // buildSubmitButton(),
              // const SizedBox(height: 30),
              buildDetailsField(context),
              const SizedBox(height: 30),
              buildUrgencyAndPatternField(context),
              const SizedBox(height: 30),
              buildLocationField(context),
              // const SizedBox(height: 30),
              buildCommissionField(context),
            ],
          ),
        ),
      ),
    );
  }

  buildSubmitButton() {
    return InkWell(
      child: GestureDetector(
        onTap: () async {
          BotToast.showLoading();
          User user = await _getUser().then((User user) => user);
          Future.delayed(Duration(milliseconds: 100), () {
            print("=========${user.id}");
            BotToast.closeAllLoading();
          });
          // createEventService(
          //     user.id, location, details, urgency, pattern, commission);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 16, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue[50],
                ),
                child: const Row(
                  children: <Widget>[
                    Icon(
                      Icons.post_add,
                      color: Colors.blue,
                      size: 20,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      '发布',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildLocationField(BuildContext context) {
    return _value_p == 1
        ? Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Column(
              children: [
                TextField(
                  controller: _locationController,
                  onChanged: (v) => _locationController.text = v,
                  maxLines: null,
                  minLines: 1,
                  decoration: const InputDecoration(
                    labelText: '位置',
                    hintText: '请输入或选择位置',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                      BorderSide(color: Color.fromARGB(255, 187, 222, 251)),
                    ),
                    suffixIcon: Icon(Icons.location_on),
                    // isCollapsed: true,
                  ),
                ),
                SizedBox(height: 30)
              ],
            )
          )
        : SizedBox(height: 0);
  }

  buildDetailsField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: TextField(
        controller: _detailsController,
        onChanged: (v) => _detailsController.text = v,
        maxLines: null,
        minLines: 1,
        decoration: const InputDecoration(
          labelText: '详情',
          hintText: '请描述事件详情',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color.fromARGB(255, 187, 222, 251)),
          ),
          // suffixIcon: Icon(Icons.location_on),
          // isCollapsed: true,
        ),
      ),
    );
  }

  buildUrgencyAndPatternField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                DropdownButton(
                    underline: Container(
                      height: 0.5,
                      color: Colors.black,
                    ),
                    value: _value_u,
                    hint: Text("请选择紧急程度"),
                    items: const [
                      DropdownMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Text("一般", style: TextStyle(color: Colors.black)),
                              Text(
                                " ●",
                                style: TextStyle(color: Colors.greenAccent),
                              )
                            ],
                          )),
                      DropdownMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Text(
                                "紧急",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                " ●",
                                style: TextStyle(color: Colors.orange),
                              )
                            ],
                          )),
                      DropdownMenuItem(
                          value: 2,
                          child: Row(
                            children: [
                              Text(
                                "非常急",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                " ●",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          )),
                    ],
                    onChanged: (value) => setState(() => _value_u = value!)),
                const SizedBox(width: 10),
                DropdownButton(
                    underline: Container(
                      height: 0.5,
                      color: Colors.black,
                    ),
                    value: _value_p,
                    hint: Text("请选择需求方式"),
                    items: const [
                      DropdownMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Text("电话📞",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          )),
                      DropdownMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Text(
                                "现场🏃‍",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )),
                    ],
                    onChanged: (value) => setState(() => _value_p = value!)),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildCommissionField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Text("佣金",style: TextStyle(fontSize: 20),),
                // SwitchListTile(
                //     title: Text('佣金'),
                //     value: isOpen,
                //     onChanged: (value) => setState(() => isOpen = value)),
                SizedBox(width:200),
                Switch(
                    value: isOpen,
                    onChanged: (value) => setState(() => isOpen = value)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
