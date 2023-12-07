// To parse this JSON data, do
//
//     final address1 = address1FromJson(jsonString);

import 'dart:convert';

Address1 address1FromJson(String str) => Address1.fromJson(json.decode(str));

String address1ToJson(Address1 data) => json.encode(data.toJson());

class Address1 {
  Results1 results;

  Address1({
    required this.results,
  });

  factory Address1.fromJson(Map<String, dynamic> json) => Address1(
    results: Results1.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
  };
}

class Results1 {
  Common1 common;
  List<Juso1> juso;

  Results1({
    required this.common,
    required this.juso,
  });

  factory Results1.fromJson(Map<String, dynamic> json) => Results1(
    common: Common1.fromJson(json["common"]),
    juso: List<Juso1>.from(json["juso"].map((x) => Juso1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "common": common.toJson(),
    "juso": List<dynamic>.from(juso.map((x) => x.toJson())),
  };
}

class Common1 {
  String errorMessage;
  String countPerPage;
  String totalCount;
  String errorCode;
  String currentPage;

  Common1({
    required this.errorMessage,
    required this.countPerPage,
    required this.totalCount,
    required this.errorCode,
    required this.currentPage,
  });

  factory Common1.fromJson(Map<String, dynamic> json) => Common1(
    errorMessage: json["errorMessage"],
    countPerPage: json["countPerPage"],
    totalCount: json["totalCount"],
    errorCode: json["errorCode"],
    currentPage: json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "errorMessage": errorMessage,
    "countPerPage": countPerPage,
    "totalCount": totalCount,
    "errorCode": errorCode,
    "currentPage": currentPage,
  };
}

class Juso1 {
  String detBdNmList;
  String engAddr;
  String rn;
  String emdNm;
  String zipNo;
  String roadAddrPart2;
  String emdNo;
  String sggNm;
  String jibunAddr;
  String siNm;
  String roadAddrPart1;
  String bdNm;
  String admCd;
  String udrtYn;
  String lnbrMnnm;
  String roadAddr;
  String lnbrSlno;
  String buldMnnm;
  String bdKdcd;
  String liNm;
  String rnMgtSn;
  String mtYn;
  String bdMgtSn;
  String buldSlno;

  Juso1({
    required this.detBdNmList,
    required this.engAddr,
    required this.rn,
    required this.emdNm,
    required this.zipNo,
    required this.roadAddrPart2,
    required this.emdNo,
    required this.sggNm,
    required this.jibunAddr,
    required this.siNm,
    required this.roadAddrPart1,
    required this.bdNm,
    required this.admCd,
    required this.udrtYn,
    required this.lnbrMnnm,
    required this.roadAddr,
    required this.lnbrSlno,
    required this.buldMnnm,
    required this.bdKdcd,
    required this.liNm,
    required this.rnMgtSn,
    required this.mtYn,
    required this.bdMgtSn,
    required this.buldSlno,
  });

  factory Juso1.fromJson(Map<String, dynamic> json) => Juso1(
    detBdNmList: json["detBdNmList"],
    engAddr: json["engAddr"],
    rn: json["rn"],
    emdNm: json["emdNm"],
    zipNo: json["zipNo"],
    roadAddrPart2: json["roadAddrPart2"],
    emdNo: json["emdNo"],
    sggNm: json["sggNm"],
    jibunAddr: json["jibunAddr"],
    siNm: json["siNm"],
    roadAddrPart1: json["roadAddrPart1"],
    bdNm: json["bdNm"],
    admCd: json["admCd"],
    udrtYn: json["udrtYn"],
    lnbrMnnm: json["lnbrMnnm"],
    roadAddr: json["roadAddr"],
    lnbrSlno: json["lnbrSlno"],
    buldMnnm: json["buldMnnm"],
    bdKdcd: json["bdKdcd"],
    liNm: json["liNm"],
    rnMgtSn: json["rnMgtSn"],
    mtYn: json["mtYn"],
    bdMgtSn: json["bdMgtSn"],
    buldSlno: json["buldSlno"],
  );

  Map<String, dynamic> toJson() => {
    "detBdNmList": detBdNmList,
    "engAddr": engAddr,
    "rn": rn,
    "emdNm": emdNm,
    "zipNo": zipNo,
    "roadAddrPart2": roadAddrPart2,
    "emdNo": emdNo,
    "sggNm": sggNm,
    "jibunAddr": jibunAddr,
    "siNm": siNm,
    "roadAddrPart1": roadAddrPart1,
    "bdNm": bdNm,
    "admCd": admCd,
    "udrtYn": udrtYn,
    "lnbrMnnm": lnbrMnnm,
    "roadAddr": roadAddr,
    "lnbrSlno": lnbrSlno,
    "buldMnnm": buldMnnm,
    "bdKdcd": bdKdcd,
    "liNm": liNm,
    "rnMgtSn": rnMgtSn,
    "mtYn": mtYn,
    "bdMgtSn": bdMgtSn,
    "buldSlno": buldSlno,
  };
}
