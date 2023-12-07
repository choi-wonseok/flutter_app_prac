


import 'dart:convert';

class Info {
  int regiId;
  String regiName;
  String regiCompany;
  String regiContact;
  String regiCarType;
  String regiCarNum;
  String regiType;
  String regiDate;
  String regiReserveDt;
  String regiReserveAt;
  String regiDAddress;
  String regiDContact;
  String regiAAddress;
  String regiAContact;
  String regiDepartTime;
  String regiDepartKm;
  String regiArriveTime;
  String regiArriveKm;
  String regiDetail;
  String regiPay;
  String regiPayType;
  String regiLevel;
  String regiDLat;
  String regiDLong;
  String regiALat;
  String regiALong;
  String regiDistance;


  Info(
      this.regiId,
      this.regiName,
      this.regiCompany,
      this.regiContact,
      this.regiCarType,
      this.regiCarNum,
      this.regiType,
      this.regiDate,
      this.regiReserveDt,
      this.regiReserveAt,
      this.regiDAddress,
      this.regiDContact,
      this.regiAAddress,
      this.regiAContact,
      this.regiDepartTime,
      this.regiDepartKm,
      this.regiArriveTime,
      this.regiArriveKm,
      this.regiDetail,
      this.regiPay,
      this.regiPayType,
      this.regiLevel,
      this.regiDLat,
      this.regiDLong,
      this.regiALat,
      this.regiALong,
      this.regiDistance,
      );

  factory Info.fromJson(Map<String, dynamic> json) =>Info(
    json["regi_id"],
    json["regi_name"],
    json["regi_company"],
    json["regi_contact"],
    json["regi_car_type"],
    json["regi_car_num"],
    json["regi_type"],
    json["regi_date"],
    json["regi_reserve_dt"],
    json["regi_reserve_at"],
    json["regi_d_address"],
    json["regi_d_contact"],
    json["regi_a_address"],
    json["regi_a_contact"],
    json["regi_depart_time"],
    json["regi_depart_km"],
    json["regi_arrive_time"],
    json["regi_arrive_km"],
    json["regi_detail"],
    json["regi_pay"],
    json["regi_pay_type"],
    json["regi_level"],
    json["regi_d_lat"],
    json["regi_d_long"],
    json["regi_a_lat"],
    json["regi_a_lat"],
    json["regi_distance"],

  );

  Map<String, dynamic> toJson() => {
    'regi_id': regiId.toString(),
    'regi_name': regiName == null ? null : regiName,
    'regi_company': regiCompany == null ? null : regiCompany,
    'regi_contact': regiContact == null ? null : regiContact,
    'regi_car_type':regiCarType == null ? null : regiCarType,
    'regi_car_num': regiCarNum == null ? null : regiCarNum,
    'regi_type': regiType == null ? null : regiType,
    'regi_date': regiDate == null ? null : regiDate,
    'regi_reserve_dt': regiReserveDt == null ? null : regiReserveDt,
    'regi_reserve_at': regiReserveAt == null ? null : regiReserveAt,
    'regi_d_address': regiDAddress == null ? null : regiDAddress,
    'regi_d_contact': regiDContact == null ? null : regiDContact,
    'regi_a_address': regiAAddress == null ? null : regiAAddress,
    'regi_a_contact': regiAContact == null ? null : regiAContact,
    'regi_depart_time': regiDepartTime == null ? null : regiDepartTime,
    'regi_depart_km': regiDepartKm == null ? null : regiDepartKm,
    'regi_arrive_time': regiArriveTime == null ? null : regiArriveTime,
    'regi_arrive_km': regiArriveKm == null ? null : regiArriveKm,
    'regi_detail': regiDetail == null ? null : regiDetail,
    'regi_pay' : regiPay == null ? null : regiPay,
    'regi_pay_type': regiPayType == null ? null : regiPayType,
    'regi_level' : regiLevel == null ? null : regiLevel,
    'regi_d_lat' : regiDLat == null ? null : regiDLat,
    'regi_d_long' : regiDLong == null ? null : regiDLong,
    'regi_a_lat' : regiALat == null ? null : regiALat,
    'regi_a_long' : regiALong == null ? null : regiALong,
    'regi_distance' : regiDistance == null ? null : regiDistance,

  };
}
