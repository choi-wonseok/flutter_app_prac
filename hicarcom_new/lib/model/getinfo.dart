


import 'dart:convert';

List<GetInfo> getinfoFromJson(String str) => List<GetInfo>.from(json.decode(str).map((x) => GetInfo.fromJson(x))).toList();

String getinfoToJson(List<GetInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Checkinfo checkinfoFromJson(String str) => Checkinfo.fromJson(json.decode(str));

String checkinfoToJson(Checkinfo data) => json.encode(data.toJson());

class Checkinfo {
  bool success;
  List<GetInfo> infoData;

  Checkinfo({
    required this.success,
    required this.infoData,
  });


  factory Checkinfo.fromJson(Map<String, dynamic> json) => Checkinfo(
    success: json["success"],
    infoData: List<GetInfo>.from(json['infoData'].map((x) => GetInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "infoData": List<dynamic>.from(infoData.map((x) => x.toJson())),
  };
}


class GetInfo {
  int regiId;
  String regiName;
  String regiCompany;
  String regiCompanyBranch;
  String regiCompanyType;
  String? regiContact;
  String regiCarType;
  String regiCarNum;
  String regiType;
  String regiDate;
  String regiReserveDt;
  String regiReserveAt;
  String regiDAddress;
  String? regiDContact;
  String regiAAddress;
  String? regiAContact;
  String regiDepartTime;
  String regiDepartKm;
  String regiArriveTime;
  String regiArriveKm;
  String? regiDetail;
  String regiPay;
  String regiPayType;
  String regiLevel;
  String regiPostDate;
  String regiDLat;
  String regiDLong;
  String regiALat;
  String regiALong;
  String regiDistance;
  int? userId;

  GetInfo({
    required this.regiId,
    required this.regiName,
    required this.regiCompany,
    required this.regiCompanyBranch,
    required this.regiCompanyType,
    required this.regiContact,
    required this.regiCarType,
    required this.regiCarNum,
    required this.regiType,
    required this.regiDate,
    required this.regiReserveDt,
    required this.regiReserveAt,
    required this.regiDAddress,
    required this.regiDContact,
    required this.regiAAddress,
    required this.regiAContact,
    required this.regiDepartTime,
    required this.regiDepartKm,
    required this.regiArriveTime,
    required this.regiArriveKm,
    required this.regiDetail,
    required this.regiPay,
    required this.regiPayType,
    required this.regiLevel,
    required this.regiPostDate,
    required this.regiDLat,
    required this.regiDLong,
    required this.regiALat,
    required this.regiALong,
    required this.regiDistance,
    required this.userId
  });



  factory GetInfo.fromJson(Map<String, dynamic> json) => GetInfo(
    regiId: int.parse(json["regi_id"]),
    regiName: json["regi_name"],
    regiCompany: json["regi_company"],
    regiCompanyBranch: json["regi_company_branch"],
    regiCompanyType: json["regi_company_type"],
    regiContact: json["regi_contact"],
    regiCarType: json["regi_car_type"],
    regiCarNum: json["regi_car_num"],
    regiType: json["regi_type"],
    regiDate: json["regi_date"],
    regiReserveDt: json["regi_reserve_dt"],
    regiReserveAt: json["regi_reserve_at"],
    regiDAddress: json["regi_d_address"],
    regiDContact: json["regi_d_contact"],
    regiAAddress: json["regi_a_address"],
    regiAContact: json["regi_a_contact"],
    regiDepartTime: json["regi_depart_time"],
    regiDepartKm: json["regi_depart_km"],
    regiArriveTime: json["regi_arrive_time"],
    regiArriveKm: json["regi_arrive_km"],
    regiDetail: json["regi_detail"],
    regiPay: json["regi_pay"],
    regiPayType: json["regi_pay_type"],
    regiLevel: json["regi_level"],
    regiPostDate: json["regi_post_date"],
    regiDLat : json["regi_d_lat"],
    regiDLong : json["regi_d_long"],
    regiALat : json["regi_a_lat"],
    regiALong : json["regi_a_long"],
    regiDistance : json["distance"],
    userId : json["user_id"] != null ? int.parse(json["user_id"]) : null,

  );

  Map<String, dynamic> toJson() => {
    "regi_id": regiId.toString(),
    "regi_name": regiName == null ? null : regiName,
    "regi_company": regiCompany == null ? null : regiCompany,
    "regi_company_branch": regiCompanyBranch == null ? null : regiCompanyBranch,
    "regi_company_type": regiCompanyType == null ? null : regiCompanyType,
    "regi_contact": regiContact == null ? null : regiContact,
    "regi_car_type": regiCarType == null ? null : regiCarType,
    "regi_car_num": regiCarNum == null ? null : regiCarNum,
    "regi_type": regiType == null ? null : regiType,
    "regi_date": regiDate == null ? null : regiDate,
    "regi_reserve_dt": regiReserveDt == null ? null : regiReserveDt,
    "regi_reserve_at": regiReserveAt == null ? null : regiReserveAt,
    "regi_d_address": regiDAddress == null ? null : regiDAddress,
    "regi_d_contact": regiDContact == null ? null : regiDContact,
    "regi_a_address": regiAAddress == null ? null : regiAAddress,
    "regi_a_contact": regiAContact == null ? null : regiAContact,
    "regi_depart_time": regiDepartTime == null ? null : regiDepartTime,
    "regi_depart_km": regiDepartKm == null ? null : regiDepartKm,
    "regi_arrive_time": regiArriveTime == null ? null : regiArriveTime,
    "regi_arrive_km": regiArriveKm == null ? null : regiArriveKm,
    "regi_detail": regiDetail == null ? null : regiDetail,
    "regi_pay": regiPay == null ? null : regiPay,
    "regi_pay_type": regiPayType == null ? null : regiPayType,
    "regi_level": regiLevel == null ? null : regiLevel,
    "regi_post_date": regiPostDate == null ? null : regiPostDate,
    "regi_d_lat": regiDLat == null ? null : regiDLat,
    "regi_d_long": regiDLong == null ? null : regiDLong,
    "regi_a_lat": regiALat == null ? null : regiALat,
    "regi_a_long": regiALong == null ? null : regiALong,
    "distance": regiDistance == null ? null : regiDistance,
    "user_id": userId.toString(),

  };
}
