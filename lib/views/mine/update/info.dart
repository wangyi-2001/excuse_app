import 'dart:convert';

import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/views/mine/update/update.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoUpdatePageState();
}

class _InfoUpdatePageState extends State<InfoPage> {
  late User _user;

  Future<User> _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userStr = prefs.getString("user");
    var userJson = jsonDecode(userStr.toString());
    _user = UserData.fromJson(userJson).user;
    return _user;
  }

  @override
  void initState() {
    super.initState();

    _getUserInfo().then((User user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人信息'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          buildAvatarField(),
          Container(
            color: Colors.grey,
            height: 1.0,
          ),
          buildNameField(),
          Container(
            color: Colors.grey,
            height: 1.0,
          ),
          buildPhoneField(),
          Container(
            color: Colors.grey,
            height: 1.0,
          ),
          buildEmailField(),
          Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ],
      ),
    );
  }

  buildAvatarField() {
    return InkWell(
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("头像"),
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.ac_unit,
                size: 50,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print("123");
      },
    );
  }

  buildNameField() {
    return InkWell(
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("用户名"),
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.only(right: 20),
              child: Text(_user.name),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    InfoUpdatePage(title: "修改用户名", user: _user, flag: 0)));
      },
    );
  }

  buildPhoneField() {
    return InkWell(
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("手机号码"),
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.only(right: 20),
              child: Text(_user.phone),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    InfoUpdatePage(title: "修改手机号", user: _user, flag: 1)));
      },
    );
  }

  buildEmailField() {
    return InkWell(
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("邮箱"),
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.only(right: 20),
              child: Text(_user.email),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    InfoUpdatePage(title: "修改邮箱", user: _user, flag: 2)));
      },
    );
  }
}
