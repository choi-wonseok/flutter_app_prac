// To parse this JSON data, do
//
//     final logininfo = logininfoFromJson(jsonString);

import 'dart:convert';

Logininfo logininfoFromJson(String str) => Logininfo.fromJson(json.decode(str));

String logininfoToJson(Logininfo data) => json.encode(data.toJson());

class Logininfo {
  bool success;
  List<UserInfo> infoData;

  Logininfo({
    required this.success,
    required this.infoData,
  });

  factory Logininfo.fromJson(Map<String, dynamic> json) => Logininfo(
    success: json["success"],
    infoData: List<UserInfo>.from(json["infoData"].map((x) => UserInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "infoData": List<dynamic>.from(infoData.map((x) => x.toJson())),
  };
}
class UserInfo {
  String userPhoneNumber;
  String userName;
  String userLevel;
  String companyLevel;
  int? userId;

  UserInfo({
    required this.userPhoneNumber,
    required this.userName,
    required this.userLevel,
    required this.companyLevel,
    required this.userId
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    userPhoneNumber: json["user_phone_number"],
    userName: json["user_name"],
    userLevel: json["user_level"],
    companyLevel: json["CompanyLevel"],
    userId:  int.parse(json["user_id"]),
  );

  Map<String, dynamic> toJson() => {
    "user_phone_number": userPhoneNumber,
    "user_name": userName,
    "user_level": userLevel,
    "CompanyLevel": companyLevel,
    "user_id": userId
  };
}