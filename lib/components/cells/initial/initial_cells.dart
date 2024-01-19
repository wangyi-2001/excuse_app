import 'package:excuse_demo/common/page_jump_animation.dart';
import 'package:excuse_demo/views/initial/login.dart';
import 'package:excuse_demo/views/initial/register.dart';
import 'package:flutter/material.dart';

/// 初始页面组件
/// 上方标识文字
buildTitle(int pageId) {
  String? text;
  switch(pageId){
    case 0:
      text='注册';
      break;
    case 1:
      text='登录';
      break;
    case 2:
      text='忘记密码';
      break;
  }
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      text!,
      style: const TextStyle(fontSize: 42),
    ),
  );
}

/// 标识文字下划线
buildTitleLine() {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, top: 4.0),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        color: Colors.black,
        width: 40,
        height: 2,
      ),
    ),
  );
}

/// 按钮下方跳转文字
buildText(BuildContext context,int pageId) {
  String? textClickable,textNonclickable;
  Widget? widget;
  switch(pageId){
    case 0:
      textClickable='点击登录';
      textNonclickable='已有账号？';
      widget=const LoginPage();
      break;
    case 1:
      textClickable='点击注册';
      textNonclickable='没有账号？';
      widget=const RegisterPage();
      break;
    case 2:
      textClickable='点击登录';
      textNonclickable='';
      widget=const LoginPage();
      break;
  }
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(textNonclickable!),
          GestureDetector(
            child: Text(textClickable!, style: const TextStyle(color: Colors.green)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  CustomRouteSlideLeft(widget!),
                      (Route route)=>false);
            },
          )
        ],
      ),
    ),
  );
}
