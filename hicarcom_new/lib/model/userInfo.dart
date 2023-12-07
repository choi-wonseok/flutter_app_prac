// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo1 userInfoFromJson(String str) => UserInfo1.fromJson(json.decode(str));

String userInfoToJson(UserInfo1 data) => json.encode(data.toJson());

class UserInfo1 {
  int userId;
  String userPwd;
  int companyId;
  int branchId;
  String userPosition;
  String userPhoneNumber;
  String userName;
  int userLevel;
  String userIdNumber;
  String userAddress;
  String userMemo;
  DateTime userRegidate;
  String? userDriveLicense;
  String? userProfile;

  UserInfo1({
    required this.userId,
    required this.userPwd,
    required this.companyId,
    required this.branchId,
    required this.userPosition,
    required this.userPhoneNumber,
    required this.userName,
    required this.userLevel,
    required this.userIdNumber,
    required this.userAddress,
    required this.userMemo,
    required this.userRegidate,
    required this.userDriveLicense,
    required this.userProfile,
  });

  factory UserInfo1.fromJson(Map<String, dynamic> json) => UserInfo1(
    userId: json["user_id"],
    userPwd: json["user_pwd"],
    companyId: json["company_id"],
    branchId: json["branch_id"],
    userPosition: json["user_position"],
    userPhoneNumber: json["user_phone_number"],
    userName: json["user_name"],
    userLevel: json["user_level"],
    userIdNumber: json["user_id_number"],
    userAddress: json["user_address"],
    userMemo: json["user_memo"],
    userRegidate: DateTime.parse(json["user_regidate"]),
    userDriveLicense: json["user_drive_license"],
    userProfile: json["user_profile"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_pwd": userPwd,
    "company_id": companyId,
    "branch_id": branchId,
    "user_position": userPosition,
    "user_phone_number": userPhoneNumber,
    "user_name": userName,
    "user_level": userLevel,
    "user_id_number": userIdNumber,
    "user_address": userAddress,
    "user_memo": userMemo,
    "user_regidate": userRegidate.toIso8601String(),
    "user_drive_license": userDriveLicense,
    "user_profile": userProfile,
  };
}
