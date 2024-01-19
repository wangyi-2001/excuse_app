import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:excuse_demo/http/options.dart';
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
    // sharedPreferences.setString("user", jsonEncode(response.data));
  }

  BotToast.showText(text: UserData.fromJson(response.data).message);

  // sharedPreferences.remove("user");
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

changePwdService(String phone, String password, String repassword) async {
  Map<String, dynamic> queryParameters = {
    "phone": phone,
    "password": password,
    "repassword": repassword
  };
  Response response = await Dio().get(
      HttpOptions.BASE_URL + UserRoute.userUpdatePath,
      queryParameters: queryParameters);
}

logoutService(int userId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Map<String, dynamic> queryParameters = {"id": userId};
  Response response = await Dio().post(
      HttpOptions.BASE_URL + UserRoute.userLogoutPath,
      queryParameters: queryParameters);
  // showToast("已退出");
  BotToast.showText(text: "已退出");
  sharedPreferences.remove("user");
}
