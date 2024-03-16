import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:excuse_demo/http/options.dart';
import 'package:excuse_demo/main.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/routes/event_route.dart';
import 'package:excuse_demo/views/event/event_details.dart';
import 'package:excuse_demo/views/event/event_list.dart';
import 'package:excuse_demo/views/mine/mine.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

getEventsList() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.remove("events");
  Response response =
      await Dio().get(HttpOptions.BASE_URL + EventRoute.eventListPath);
  eventBus.fire(GetLatestEventsList(EventsData.fromJson(response.data).events));
  sharedPreferences.setString("events", jsonEncode(response.data));
}

createEvent(int userId, String location, String details, int urgency,
    int pattern, String commission) async {
  Map<String, dynamic> queryParameters = {
    "userId": userId,
    "location": location,
    "details": details,
    "urgency": urgency,
    "pattern": pattern,
    "commission": commission,
  };
  Response response = await Dio().post(
      HttpOptions.BASE_URL + EventRoute.eventCreatePath,
      queryParameters: queryParameters);
  eventBus
      .fire(GetLatestUserInfo(EventData.fromJson(response.data).event.creator));
  getEventsList();
  BotToast.showText(text: EventData.fromJson(response.data).message);
}

deleteEvent(int eventId) async {
  Map<String, dynamic> queryParameters = {
    "eventId": eventId,
  };
  Response response = await Dio().post(
      HttpOptions.BASE_URL + EventRoute.eventDeletePath,
      queryParameters: queryParameters);
  getEventsList();
  BotToast.showText(text: EventData.fromJson(response.data).message);
}

acceptEvent(int eventId, int userId) async {
  Map<String, dynamic> queryParameters = {
    "eventId": eventId,
    "recipientId": userId,
  };
  Response response = await Dio().post(
      HttpOptions.BASE_URL + EventRoute.eventAcceptPath,
      queryParameters: queryParameters);
  eventBus.fire(
      GetLatestUserInfo(EventData.fromJson(response.data).event.recipient));
  eventBus.fire(UpdateBottomButton("退单"));
  getEventsList();
  BotToast.showText(text: EventData.fromJson(response.data).message);
}

getAcceptedEventsList(int userId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Map<String, dynamic> queryParameters = {
    "recipientId": userId,
  };
  // sharedPreferences.remove("acceptedEvents");
  Response response = await Dio().get(
      HttpOptions.BASE_URL + EventRoute.eventAcceptedPath,
      queryParameters: queryParameters);
  sharedPreferences.setString("acceptedEvents", jsonEncode(response.data));
}

getPublishedEventsList(int userId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Map<String, dynamic> queryParameters = {
    "creatorId": userId,
  };
  Response response = await Dio().get(
      HttpOptions.BASE_URL + EventRoute.eventPublishedPath,
      queryParameters: queryParameters);
  sharedPreferences.setString("publishedEvents", jsonEncode(response.data));
}

reportEvent(int eventId) async{
  Map<String, dynamic> queryParameters = {
    "eventId": eventId,
  };
  Response response=await Dio().post(
    HttpOptions.BASE_URL+EventRoute.eventReportPath,
    queryParameters: queryParameters
  );
  if(EventData.fromJson(response.data).event.reportedTimes==5){
    await Dio().post(
        HttpOptions.BASE_URL + EventRoute.eventDeletePath,
        queryParameters: queryParameters);
    getEventsList();
    BotToast.showText(text: "举报成功，已删除此事件");
  }else{
    BotToast.showText(text: "举报成功");
  }
}