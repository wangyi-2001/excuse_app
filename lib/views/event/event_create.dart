import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  var _valueU;
  var _valueP;
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
              const SizedBox(height: 30,)
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
          Future.delayed(const Duration(milliseconds: 100), () {
            print("=========${user.id}");
            BotToast.closeAllLoading();
          });
          createEvent(
              user.id,
              _locationController.text,
              _detailsController.text,
              _valueU,
              _valueP,
              _commissionController.text);
          Navigator.pop(context);
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
    return _valueP == 1
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
                const SizedBox(height: 30)
              ],
            ))
        : const SizedBox(height: 0);
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
                    value: _valueU,
                    hint: const Text("请选择紧急程度"),
                    items: const [
                      DropdownMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Text("不太急", style: TextStyle(color: Colors.black)),
                              Text(
                                "       ●",
                                style: TextStyle(color: Colors.greenAccent),
                              )
                            ],
                          )),
                      DropdownMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Text(
                                "有点急",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                "       ●",
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
                                "   ●",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          )),
                    ],
                    onChanged: (value) => setState(() => _valueU = value!)),
                const SizedBox(width: 10),
                DropdownButton(
                    underline: Container(
                      height: 0.5,
                      color: Colors.black,
                    ),
                    value: _valueP,
                    hint: const Text("请选择需求方式"),
                    items: const [
                      DropdownMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Text("电话 📱",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          )),
                      DropdownMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Text(
                                "现场 🏃‍",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )),
                    ],
                    onChanged: (value) => setState(() => _valueP = value!)),
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
                const Text(
                  "佣金",
                  style: TextStyle(fontSize: 20),
                ),
                // SwitchListTile(
                //     title: Text('佣金'),
                //     value: isOpen,
                //     onChanged: (value) => setState(() => isOpen = value)),
                // SizedBox(width: 200),
                getSizedBox(context),
                Switch(
                    value: isOpen,
                    onChanged: (value) => setState(() => isOpen = value)),

                getCommission(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getSizedBox(BuildContext context) {
    return isOpen == true
        ? const SizedBox(width: 15)
        : const SizedBox(width: 170);
  }

  getCommission(BuildContext context) {
    return isOpen == true
        ? SizedBox(
            // height: MediaQuery.of(context).size.height * 0.5,
            // width: MediaQuery.of(context).size.width * 0.5,
            // padding: EdgeInsets.only(right: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 20),
                const Text(
                  "￥",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 115,
                  child: TextField(
                    controller: _commissionController,
                    onChanged: (v) => _commissionController.text = v,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter(RegExp("[0-9.]"),
                          allow: true),
                      MyNumberTextInputFormatter(digit: 2),
                    ],
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const Text(
                  "元",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
        : const SizedBox(width: 20);
  }
}

class MyNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  ///允许的小数位数，-1代表不限制位数
  int digit;

  MyNumberTextInputFormatter({this.digit = -1});

  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  ///获取目前的小数位数
  static int getValueDigit(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return -1;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value == "-") {
      value = "-";
      selectionIndex++;
    } else if (value != "" &&
            value != defaultDouble.toString() &&
            strToFloat(value, defaultDouble) == defaultDouble ||
        getValueDigit(value) > digit) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
