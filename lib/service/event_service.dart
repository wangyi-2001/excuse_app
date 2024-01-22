import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:excuse_demo/http/options.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/routes/event_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

getEventsList() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.remove("events");
  Response response =
      await Dio().get(HttpOptions.BASE_URL + EventRoute.eventListPath);
  sharedPreferences.setString("events", jsonEncode(response.data));
}

createEventService(int userId, String location, String details, int urgency,
    int pattern, String commission) async {
  Map<String, dynamic> queryParameters = {
    "userid": userId,
    "location": location,
    "details": details,
    "urgency": urgency,
    "pattern": pattern,
    "commission": commission,
  };
  Response response = await Dio().get(
      HttpOptions.BASE_URL + EventRoute.eventCreatePath,
      queryParameters: queryParameters);
  BotToast.showText(text: EventData.fromJson(response.data).message);
}
