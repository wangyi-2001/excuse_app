import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/service/user_service.dart';
import 'package:flutter/material.dart';

class InfoUpdatePage extends StatefulWidget {
  final String title;
  final User user;
  final int flag;

  const InfoUpdatePage(
      {super.key, required this.title, required this.user, required this.flag});

  @override
  State<InfoUpdatePage> createState() => _InfoUpdatePageState();
}

class _InfoUpdatePageState extends State<InfoUpdatePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          buildSubmitButton(),
        ],
      ),
      body: buildInputField(),
    );
  }

  buildInputField() {
    switch (widget.flag) {
      case 0:
        // 修改用户名
        return Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: _nameController,
            onSaved: (v) => _nameController.text = v!,
            decoration: InputDecoration(labelText: '请输入用户名'),
            validator: (v) {
              if (v!.isEmpty) {
                return "请输入用户名";
              }
              return null;
            },
          ),
        );
      case 1:
        // 修改手机号
        return Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: _phoneController,
            onSaved: (v) => _phoneController.text = v!,
            decoration: InputDecoration(
                labelText: '请输入手机号',
                helperText: '·仅支持中国大陆13位手机号码\n·修改手机号码后需重新登录'),
            validator: (v) {
              var phoneReg = RegExp(
                  r"^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$");
              if (!phoneReg.hasMatch(v!) || v.isEmpty) {
                return '请输入正确手机号';
              }
              return null;
            },
          ),
        );
      case 2:
        // 修改邮箱
        return Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: _emailController,
            onSaved: (v) => _emailController.text = v!,
            decoration: InputDecoration(labelText: '请输入邮箱'),
            validator: (v) {
              var emailReg =
                  RegExp(r"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+$");
              if (!emailReg.hasMatch(v!) || v.isEmpty) {
                return '请输入正确邮箱地址';
              }
              return null;
            },
          ),
        );
    }
  }

  buildSubmitButton() {
    return InkWell(
      child: GestureDetector(
        onTap: () {
          switch (widget.flag) {
            case 0:
              updateUserInfo(widget.user.id, 0, _nameController.text);
              break;
            case 1:
              updateUserInfo(widget.user.id, 1, _phoneController.text);
              break;
            case 2:
              updateUserInfo(widget.user.id, 2, _emailController.text);
              break;
          }
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 30, top: 10, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 10, bottom: 8),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue[50],
                ),
                child: Text(
                  '提 交',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
