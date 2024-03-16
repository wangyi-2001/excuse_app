import 'dart:convert';

import 'package:excuse_demo/models/user.dart';

EventsData eventsFromJson(String str) => EventsData.fromJson(json.decode(str));

EventData eventFromJson(String str) => EventData.fromJson(json.decode(str));

String eventToJson(EventsData data) => json.encode(data.toJson());

class EventsData {
  int code;
  List<Event> events;
  String message;

  EventsData({
    required this.code,
    required this.events,
    required this.message,
  });

  factory EventsData.fromJson(Map<String, dynamic> json) => EventsData(
        code: json["code"],
        events: List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(events.map((x) => x.toJson())),
        "message": message,
      };
}

class EventData {
  int code;
  Event event;
  String message;

  EventData({
    required this.code,
    required this.event,
    required this.message,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
        code: json["code"],
        event: Event.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": event.toJson(),
        "message": message,
      };
}

class Event {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int creatorId;
  User creator;
  String location;
  String details;
  int urgency;
  int pattern;
  String commission;
  int recipientId;
  User recipient;
  int status;
  int score;
  String evaluate;
  int reportedTimes;

  Event({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.creatorId,
    required this.creator,
    required this.location,
    required this.details,
    required this.urgency,
    required this.pattern,
    required this.commission,
    required this.recipientId,
    required this.recipient,
    required this.status,
    required this.score,
    required this.evaluate,
    required this.reportedTimes,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
      id: json["ID"],
      createdAt: DateTime.parse(json["CreatedAt"]),
      updatedAt: DateTime.parse(json["UpdatedAt"]),
      deletedAt: json["DeletedAt"],
      creatorId: json["CreatorID"],
      creator: User.fromJson(json["Creator"]),
      location: json["Location"],
      details: json["Details"],
      urgency: json["Urgency"],
      pattern: json["Pattern"],
      commission: json["Commission"],
      recipientId: json["RecipientID"],
      recipient: User.fromJson(json["Recipient"]),
      status: json["Status"],
      score: json["Score"],
      evaluate: json["Evaluate"],
      reportedTimes: json["ReportedTimes"]);

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "DeletedAt": deletedAt,
        "CreatorId": creatorId,
        "Creator": creator,
        "Location": location,
        "Details": details,
        "Urgency": urgency,
        "Pattern": pattern,
        "Commission": commission,
        "RecipientId": recipientId,
        "Recipient": recipient,
        "Status": status,
        "Score": score,
        "Evaluate": evaluate,
        "ReportedTimes": reportedTimes
      };
}

class Creator {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String avatar;
  String name;
  String initials;
  String password;
  String phone;
  String email;
  String clientIp;
  String identity;
  String salt;
  bool isLogout;
  String deviceInfo;
  int remainingTimes;
  String balance;
  int violationsNum;
  int favorableComment;
  int accountStatus;

  Creator(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.avatar,
      required this.name,
      required this.initials,
      required this.password,
      required this.phone,
      required this.email,
      required this.clientIp,
      required this.identity,
      required this.salt,
      required this.isLogout,
      required this.deviceInfo,
      required this.remainingTimes,
      required this.balance,
      required this.violationsNum,
      required this.favorableComment,
      required this.accountStatus});

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
      id: json["ID"],
      createdAt: DateTime.parse(json["CreatedAt"]),
      updatedAt: DateTime.parse(json["UpdatedAt"]),
      deletedAt: json["DeletedAt"],
      avatar: json["Avatar"],
      name: json["Name"],
      initials: json["Initials"],
      password: json["Password"],
      phone: json["Phone"],
      email: json["Email"],
      clientIp: json["ClientIp"],
      identity: json["Identity"],
      salt: json["Salt"],
      isLogout: json["IsLogout"],
      deviceInfo: json["DeviceInfo"],
      remainingTimes: json["RemainingTimes"],
      balance: json['Balance'],
      violationsNum: json["ViolationsNum"],
      favorableComment: json["FavorableComment"],
      accountStatus: json["AccountStatus"]);

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "DeletedAt": deletedAt,
        "Avatar": avatar,
        "Name": name,
        "Initials": initials,
        "Password": password,
        "Phone": phone,
        "Email": email,
        "ClientIp": clientIp,
        "Identity": identity,
        "Salt": salt,
        "IsLogout": isLogout,
        "DeviceInfo": deviceInfo,
        "RemainingTimes": remainingTimes,
        "Balance": balance,
        "ViolationsNum": violationsNum,
        "FavorableComment": favorableComment,
        "AccountStatus": accountStatus
      };
}

class Recipient {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String avatar;
  String name;
  String initials;
  String password;
  String phone;
  String email;
  String clientIp;
  String identity;
  String salt;
  bool isLogout;
  String deviceInfo;
  int remainingTimes;
  String balance;
  int violationsNum;
  int favorableComment;
  int accountStatus;

  Recipient(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.avatar,
      required this.name,
      required this.initials,
      required this.password,
      required this.phone,
      required this.email,
      required this.clientIp,
      required this.identity,
      required this.salt,
      required this.isLogout,
      required this.deviceInfo,
      required this.remainingTimes,
      required this.balance,
      required this.violationsNum,
      required this.favorableComment,
      required this.accountStatus});

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
      id: json["ID"],
      createdAt: DateTime.parse(json["CreatedAt"]),
      updatedAt: DateTime.parse(json["UpdatedAt"]),
      deletedAt: json["DeletedAt"],
      avatar: json["Avatar"],
      name: json["Name"],
      initials: json["Initials"],
      password: json["Password"],
      phone: json["Phone"],
      email: json["Email"],
      clientIp: json["ClientIp"],
      identity: json["Identity"],
      salt: json["Salt"],
      isLogout: json["IsLogout"],
      deviceInfo: json["DeviceInfo"],
      remainingTimes: json["RemainingTimes"],
      balance: json["Balance"],
      violationsNum: json["ViolationsNum"],
      favorableComment: json["FavorableComment"],
      accountStatus: json["AccountStatus"]);

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "DeletedAt": deletedAt,
        "Avatar": avatar,
        "Name": name,
        "Initials": initials,
        "Password": password,
        "Phone": phone,
        "Email": email,
        "ClientIp": clientIp,
        "Identity": identity,
        "Salt": salt,
        "IsLogout": isLogout,
        "DeviceInfo": deviceInfo,
        "RemainingTimes": remainingTimes,
        "Balance": balance,
        "ViolationsNum": violationsNum,
        "FavorableComment": favorableComment,
        "AccountStatus": accountStatus
      };
}
