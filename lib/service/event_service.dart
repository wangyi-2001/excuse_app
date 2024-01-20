import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:excuse_demo/http/options.dart';
import 'package:excuse_demo/models/event.dart';
import 'package:excuse_demo/routes/event_route.dart';

createEventService(int userId, String location, String details, int urgency,
    int pattern, double commission) async {
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
