import 'dart:convert';

EventData eventFromJson(String str) => EventData.fromJson(json.decode(str));

String eventToJson(EventData data) => json.encode(data.toJson());

class EventData {
  int code;
  List<Event> event;
  String message;

  EventData({
    required this.code,
    required this.event,
    required this.message,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
    code: json["Code"],
    event: List<Event>.from(json["Data"].map((x) => Event.fromJson(x))),
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Data": List<dynamic>.from(event.map((x) => x.toJson())),
    "Message": message,
  };
}

class Event {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int creator;
  String location;
  String details;
  int urgency;
  int pattern;
  int commission;
  int recipient;
  int status;
  int score;
  String evaluate;

  Event({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.creator,
    required this.location,
    required this.details,
    required this.urgency,
    required this.pattern,
    required this.commission,
    required this.recipient,
    required this.status,
    required this.score,
    required this.evaluate,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["ID"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    creator: json['Creator'],
    location: json["Location"],
    details: json["Details"],
    urgency: json["Urgency"],
    pattern: json["Pattern"],
    commission: json["Commission"],
    recipient: json["Recipient"],
    status: json["Status"],
    score: json["Score"],
    evaluate: json["Evaluate"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt.toIso8601String(),
    "UpdatedAt": updatedAt.toIso8601String(),
    "DeletedAt": deletedAt,
    "Creator": creator,
    "Location": location,
    "Details": details,
    "Urgency": urgency,
    "Pattern": pattern,
    "Commission": commission,
    "Recipient": recipient,
    "Status": status,
    "Score": score,
    "Evaluate": evaluate,
  };
}
