import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  int code;
  User user;
  String message;

  UserData({
    required this.code,
    required this.user,
    required this.message,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    code: json["code"],
    user: User.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": user.toJson(),
    "message": message,
  };
}

class User {
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
  int violationsNum;
  int favorableComment;
  int accountStatus;

  User({
    required this.id,
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
    required this.violationsNum,
    required this.favorableComment,
    required this.accountStatus
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
      violationsNum: json["ViolationsNum"],
      favorableComment: json["FavorableComment"],
      accountStatus: json["AccountStatus"]
  );

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
    "RemainingTimes":remainingTimes,
    "ViolationsNum":violationsNum,
    "FavorableComment":favorableComment,
    "AccountStatus":accountStatus
  };
}
