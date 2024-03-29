import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:excuse_demo/http/options.dart';
import 'package:excuse_demo/main.dart';
import 'package:excuse_demo/models/user.dart';
import 'package:excuse_demo/routes/user_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

loginService(String phone, String password) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Map<String, dynamic> queryParameters = {"phone": phone, "password": password};

  Response response = await Dio().post(
      HttpOptions.BASE_URL + UserRoute.userLoginPath,
      queryParameters: queryParameters);

  if (UserData.fromJson(response.data).code == 0) {
    sharedPreferences.setString("user", jsonEncode(response.data));
    NavigatorKey.navigatorKey.currentState!
        .pushNamedAndRemoveUntil("/home", (route) => false);
  }

  BotToast.showText(text: UserData.fromJson(response.data).message);
}

registerService(
    String name, String phone, String password, String repassword) async {
  Map<String, dynamic> queryParameters = {
    "name": name,
    "phone": phone,
    "password": password,
    "repassword": repassword
  };
  Response response = await Dio().get(
      HttpOptions.BASE_URL + UserRoute.userCreatePath,
      queryParameters: queryParameters);

  BotToast.showText(text: UserData.fromJson(response.data).message);
}

changePwdService(String phone, String password) async {
  Map<String, dynamic> queryParameters = {
    "phoneWithoutId": phone,
    "password": password,
  };
  Response response = await Dio().post(
      HttpOptions.BASE_URL + UserRoute.userUpdatePath,
      queryParameters: queryParameters);
  BotToast.showText(text: UserData.fromJson(response.data).message);
}

logoutService(int userId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Map<String, dynamic> queryParameters = {"userId": userId};
  await Dio().post(HttpOptions.BASE_URL + UserRoute.userLogoutPath,
      queryParameters: queryParameters);
  BotToast.showText(text: "已退出");
  sharedPreferences.remove("user");
  sharedPreferences.remove("acceptedEvents");
}

findUserById(int userId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Map<String, dynamic> queryParameters = {"userId": userId};
  Response response = await Dio().post(
      HttpOptions.BASE_URL + UserRoute.userInfoByIdPath,
      queryParameters: queryParameters);
  sharedPreferences.setString("user", jsonEncode(response.data));
}

updateUserInfo(int userId, int flag, String info) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  late Map<String, dynamic> queryParameters;
  switch (flag) {
    case 0:
      queryParameters = {
        "userId": userId,
        "name": info,
      };
      break;
    case 1:
      queryParameters = {
        "userId": userId,
        "phone": info,
      };
      break;
    case 2:
      queryParameters = {
        "userId": userId,
        "email": info,
      };
      break;
  }
  Response response = await Dio().post(
      HttpOptions.BASE_URL + UserRoute.userUpdatePath,
      queryParameters: queryParameters);
  sharedPreferences.setString("user", jsonEncode(response.data));
}
