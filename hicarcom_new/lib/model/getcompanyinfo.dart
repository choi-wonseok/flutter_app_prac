// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

List<InfoDatum> getcompanyinfoFromJson(String str) => List<InfoDatum>.from(json.decode(str).map((x) => InfoDatum.fromJson(x))).toList();

String getcompanyinfoToJson(List<InfoDatum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CheckCompanyInfo checkCompanyInfoFromJson(String str) => CheckCompanyInfo.fromJson(json.decode(str));

String checkcompanyinfoToJson(CheckCompanyInfo data) => json.encode(data.toJson());

class CheckCompanyInfo {
  bool success;
  List<InfoDatum> infoData;

  CheckCompanyInfo({
    required this.success,
    required this.infoData,
  });

  factory CheckCompanyInfo.fromJson(Map<String, dynamic> json) => CheckCompanyInfo(
    success: json["success"],
    infoData: List<InfoDatum>.from(json["infoData"].map((x) => InfoDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "infoData": List<dynamic>.from(infoData.map((x) => x.toJson())),
  };
}

class InfoDatum {
  String companyName;
  String companyType;
  String branchName;
  String userName;
  String phoneNumber;

  InfoDatum({
    required this.companyName,
    required this.companyType,
    required this.branchName,
    required this.userName,
    required this.phoneNumber,
  });

  factory InfoDatum.fromJson(Map<String, dynamic> json) => InfoDatum(
    companyName: json["CompanyName"],
    companyType: json["CompanyType"],
    branchName: json["BranchName"],
    userName: json["user_name"],
    phoneNumber: json["user_phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "CompanyName": companyName,
    "CompanyType": companyType,
    "BranchName": branchName,
    "user_name": userName,
    "user_phone_number": phoneNumber,
  };
}
