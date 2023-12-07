import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:hicarcom/api/api.dart';
import 'package:hicarcom/model/address.dart';
import 'package:hicarcom/model/getcompanyinfo.dart';
import 'package:hicarcom/model/loginInfo.dart';
import 'package:http/http.dart' as http;
import 'package:hicarcom/model/getinfo.dart';
import 'package:intl/intl.dart';

import '../model/address1.dart';

class ServiceList {
  static Future<List<GetInfo>> fetchList(String level1,String level2,DateTime date1, DateTime date2, int? userId) async{
    try {
      String formattedDate1 = DateFormat('yyyy-MM-dd').format(date1);
      String formattedDate2 = DateFormat('yyyy-MM-dd').format(date2);
      final response = await http.post(Uri.parse(API.getinfo), body: {
        'regi_level_start': level1,
        'regi_level_end': level2,
        'regi_start_range': formattedDate1,
        'regi_end_range': formattedDate2,
        'user_id' : userId.toString(),
      });

      debugPrint(response.statusCode.toString());
      print(response.body);
      if (response.statusCode == 200) {
        var checkinfo = jsonDecode(response.body);

        if (checkinfo['success'] == true) {
          Checkinfo checkdata = checkinfoFromJson(response.body);
          // print(checkdata.infoData);
          List<GetInfo> getinfo = checkdata.infoData;
          return getinfo;
        } else {
          return <GetInfo>[];
        }
      } else {
        return <GetInfo>[];
        // If the server did not return a 200 OK response,
        // then throw an exception.
      }
    } catch (e) {
      debugPrint(e.toString());
      return <GetInfo>[];
    }
  }
}

class ServiceUpdate {
  Future<bool> updateList(GetInfo getInfo) async {
    try {
      final response = await http.post(
          Uri.parse(API.updateinfo),
          body: getInfo.toJson()
      );
      debugPrint(getInfo.toJson().toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        var resUpdateinfo = jsonDecode(response.body);
        return resUpdateinfo['success'];
      } else {
        debugPrint("statusCode를 확인하세요: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Update Error: $e");
      return false;
    }
  }
}

class ServiceJobUpdate {
  Future<bool> updateJob(String regiId, int? userId) async{
    try {
      final response = await http.post(
          Uri.parse(API.takejob),
          body: {
            "regi_id": regiId,
            "regi_level": "2",
            "user_id": userId.toString(),
          }
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        var resUpdateJobinfo = jsonDecode(response.body);
        // print(checkinfo);
        if (resUpdateJobinfo['success'] == true) {
          print("수정완료");
          return resUpdateJobinfo['success'];
        } else {
          print("수정실패");
          return false;
        }
      }else{
        print("statusCode를 확인하세요");
        debugPrint(response.statusCode.toString());
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("에러");
      return false;
    }
  }
}

class ServiceAdd {
  Future<bool> addList(GetInfo getInfo) async {
    try {
      final response = await http.post(
          Uri.parse(API.addinfo),
          body: getInfo.toJson()
      );
      print("----------------------------------------------------------");
      debugPrint(getInfo.toJson().toString());
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

        var resaddinfo = jsonDecode(response.body);
        return resaddinfo['success'];
      } else {
        debugPrint("statusCode를 확인하세요: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("AddError: $e");
      return false;
    }
  }
}

Future<List<Map<String, dynamic>>> convertAddressToLatLng(String address) async {
  final String apiUrl = 'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode';
  final response = await http.get(
    Uri.parse('$apiUrl?query=$address'),
    headers: {
      'X-NCP-APIGW-API-KEY-ID': dotenv.env['NAVER_MAP_CLIENT_ID']!,
      'X-NCP-APIGW-API-KEY': dotenv.env['NAVER_MAP_CLIENT_SECRET']!,
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> addresses = jsonResponse['addresses'];

    print(addresses.toString()); // Print the response body as a string
    final List<Map<String, dynamic>> results = addresses.map((address) {
      final String roadAddress = address['roadAddress'];
      final String jibunAddress = address['jibunAddress'];
      final double lat = double.parse(address['y']);
      final double lng = double.parse(address['x']);
      print(roadAddress);
      return {
        'roadAddress': roadAddress,
        'jibunAddress': jibunAddress,
        'latitude': lat,
        'longitude': lng,
      };

    }).toList();

    return results;
  } else {
    throw Exception('Failed to convert address to coordinates.');
  }
}



class NaAddress{
  Future<List<Item>> naSearchAddress(String query) async{
    final String url = "https://openapi.naver.com/v1/search/local.json";
    final response = await http.get(
        Uri.parse('$url?query=$query&display=10'),
        headers: {
          'X-Naver-Client-Id': dotenv.env['X_NAVER_CLIENT_ID']!,
          'X-Naver-Client-Secret': dotenv.env['X_NAVER_CLIENT_SECRET']!,
        },
    );
    if (response.statusCode == 200) {
      final responseBody = response.body;
      print(response.body);
      if (responseBody.isNotEmpty) {
        try {
          final decodedJson = jsonDecode(responseBody);
            Channel channelInfo = Channel.fromJson(decodedJson);
            List<Item> itemList = channelInfo.items;
            List<Item> items = channelInfo.items.map((item) {
              String longitude = (double.parse(item.mapx) / 10000000).toString(); // 경도 변환
              String latitude = (double.parse(item.mapy) / 10000000).toString();  // 위도 변환

              return Item(
                title: removeHtmlTags(item.title),
                link: item.link,
                category: item.category,
                description: item.description,
                telephone: item.telephone,
                address: item.address,
                roadAddress: item.roadAddress,
                mapx: longitude, //long,
                mapy: latitude, // lat,
              );
          }).toList();
          return items;
        } catch (e) {
          debugPrint('Exception during JSON parsing: $e');
          return <Item>[];
        }
      } else {
        debugPrint('The response body is empty');
        return <Item>[];
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
      return <Item>[];
    }

  }



  Future<dynamic> reverGeocoding(NLatLng latLng) async {
    try {
      print(latLng.toString());
      String coords = '${latLng.longitude},${latLng.latitude}';
      String order = "roadaddr,addr";
      String output = "json";

      final response = await http.get(
        Uri.parse('https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$coords&orders=$order&output=$output'),
        headers: {
          'X-NCP-APIGW-API-KEY-ID': dotenv.env['NAVER_MAP_CLIENT_ID']!,
          'X-NCP-APIGW-API-KEY': dotenv.env['NAVER_MAP_CLIENT_SECRET']!,
        },

      );
      print('--------!--------');

      if (response.statusCode == 200) {
        var reverseAdd = jsonDecode(response.body);
        print("****************************");
        print(reverseAdd['results'].length);
        print("****************************");
        if (reverseAdd['results'].length > 1){
          customPrint(response.body);
          var result = reverseAdd['results'][0];
          String area1Name = result['region']['area1']['name'] ?? "";
          String area2Name = result['region']['area2']['name'] ?? "";
          String area3Name = result['region']['area3']['name'] ?? "";
          String area4Name = result['region']['area4']['name'] ?? "";
          String number1 = result['land']['number1'] ?? "";
          String number2 = result['land']['number2'];

          String fullAddress1 = '$area1Name $area2Name${area3Name.isNotEmpty ? ' $area3Name' : ''}${area4Name.isNotEmpty ? ' $area4Name' : ''} $number1${number2.isNotEmpty ? '-$number2' : ''}';


          var result1= reverseAdd['results'][1];
          String area1Name1 = result1['region']['area1']['name'] ?? "";
          String area2Name1 = result1['region']['area2']['name'] ?? "";
          String area3Name1 = result1['region']['area3']['name'] ?? "";
          String area4Name1 = result1['region']['area4']['name'] ?? "";
          String number11 = result1['land']['number1'] ?? "";
          String number21 = result1['land']['number2'];

          String fullAddress2 = '$area1Name1 $area2Name1${area3Name1.isNotEmpty ? ' $area3Name1' : ''}${area4Name1.isNotEmpty ? ' $area4Name1' : ''} $number11${number21.isNotEmpty ? '-$number21' : ''}';

          String buildingName = reverseAdd['results'][0]['land']['addition0'] != null ?
          reverseAdd['results'][0]['land']['addition0']['value'] : "";
          print(fullAddress1);
          print(fullAddress2);
          print(buildingName);

          return [fullAddress1, fullAddress2, buildingName];

        } else {
          // customPrint(response.body);
          var result = reverseAdd['results'][0];

          String area1Name = result['region']['area1']['name'] ?? "";
          String area2Name = result['region']['area2']['name'] ?? "";
          String area3Name = result['region']['area3']['name'] ?? "";
          String area4Name = result['region']['area4']['name'] ?? "";
          String number1 = result['land']['number1'] ?? "";
          String number2 = result['land']['number2'];

          String fullAddress1 = '$area1Name $area2Name${area3Name.isNotEmpty ? ' $area3Name' : ''}${area4Name.isNotEmpty ? ' $area4Name' : ''} $number1${number2.isNotEmpty ? '-$number2' : ''}';
          print(fullAddress1);
          return [fullAddress1];
        }
      } else {
        throw Exception('Failed to load address, status code: ${response.statusCode}');
      }
    } catch(e) {
      print('Error occurred: $e');
      rethrow; // 이렇게 변경
    }
  }

  Future<Map<String, dynamic>> wayPath(NLatLng start, NLatLng goal) async {
    String startCoords = '${start.longitude},${start.latitude}';
    String goalCoords = '${goal.longitude},${goal.latitude}';
    String options = 'trafast:tracomfort:traoptimal';

    final response = await http.get(
      Uri.parse('https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving?start=$startCoords&goal=$goalCoords&option=$options'),
      headers: {
        'X-NCP-APIGW-API-KEY-ID': dotenv.env['NAVER_MAP_CLIENT_ID']!,
        'X-NCP-APIGW-API-KEY': dotenv.env['NAVER_MAP_CLIENT_SECRET']!,
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Map<String, dynamic> routeInfo = {};

      for (var option in options.split(':')) {
        var summary = jsonResponse['route'][option][0]['summary'];
        var paths = jsonResponse['route'][option][0]['path'];

        List<NLatLng> path = [];
        for (var p in paths) {
          path.add(NLatLng(p[1], p[0]));
        }

        routeInfo[option] = {
          'start': NLatLng(summary['start']['location'][1], summary['start']['location'][0]),
          'goal': NLatLng(summary['goal']['location'][1], summary['goal']['location'][0]),
          'distance': summary['distance'],
          'duration': summary['duration'],
          'path': path,
        };
        // print("11111111111111111");
        // customPrint(routeInfo[option].toString());
      }


      return routeInfo;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return {};
    }
  }
}

String removeHtmlTags(String htmlString) {
  final RegExp regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(regExp, '');
}

class GetCompanyInfoService {
  static Future<List<InfoDatum>> fetchGetCompanyInfo() async {
    final response = await http.post(Uri.parse(API.getcompanyinfo));
    debugPrint(response.body);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      debugPrint(response.body);
      if (jsonData['success'] == true) {
        CheckCompanyInfo checkCompanyInfo = CheckCompanyInfo.fromJson(jsonData);
        return checkCompanyInfo.infoData;
      } else {
        return <InfoDatum>[];
      }
    } else {
      throw Exception('Failed to load company info');
    }
  }
}

class LoginInfoService{
  Future<List<UserInfo>> fetchLoginInfo(String phoneNumber) async {
    final response = await http.post(Uri.parse(API.loginInfo),
      body: {
        "user_phone_number": '01023432314'
      }
    );
    debugPrint("모바일넘버 : ${response.statusCode.toString()}");
    if (response.statusCode == 200) {
      debugPrint(response.body);
      var jsonData = jsonDecode(response.body);
      if (jsonData['success'] == true) {
        Logininfo logininfo = Logininfo.fromJson(jsonData);
        return logininfo.infoData;
      } else {
        return <UserInfo>[];
      }
    } else {
      throw Exception('Failed to load company info');
    }
  }
}

class NotificationService {
  Future<bool> sendNotificationRequest(String dLat, String dLong) async {
      var response = await http.post(Uri.parse(API.notification),
          body:{
            "regi_d_lat": dLat,
            "regi_d_long": dLong,
          });
      print('Response body: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }

  }
}

class ServiceToken {
  Future<bool> addToken(int userId, String token ) async {
    try {
      final response = await http.post(
          Uri.parse(API.addtoken),
          body: {
            'user_id': userId.toString(),
            'user_token': token,
          }
      );
      print("----------------------------------------------------------");
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {

        var resaddtoken = jsonDecode(response.body);
        return resaddtoken['success'];
      } else {
        debugPrint("statusCode를 확인하세요: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("AddError: $e");
      return false;
    }
  }
}


class ServiceUserInfo {
  Future<Map<String, dynamic>> userInfoSome(int? userId) async {
    final response = await http.post(
      Uri.parse(API.userinfo),
      body: {"user_id": userId.toString()},
    );

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);

      return {
        'success': data['success'],
        'user_alarm': data['user_alarm'] == '1' ? true : false,
        'user_alarm_km': double.parse(data['user_alarm_km']),
      };
    } else {
      print("statusCode를 확인하세요");
      return {'success': false};
    }
  }


  Future<bool> updateUserAlarm(int? userId, bool userAlarm) async {
    final response = await http.post(
      Uri.parse(API.updatealarm),
      body: {
        "user_id": userId.toString(),
        "user_alarm": userAlarm ? '1' : '0',
      },
    );

    if (response.statusCode == 200) {
      var resUpdateJobinfo = jsonDecode(response.body);
      return resUpdateJobinfo['success'];
    } else {
      print("statusCode를 확인하세요");
      return false;
    }
  }
  Future<bool> updateUserAlarmKm(int? userId, double userAlarmKm) async {
    final response = await http.post(
      Uri.parse(API.updatealarmkm),
      body: {
        "user_id": userId.toString(),
        "user_alarm_km": userAlarmKm.toString(),
      },
    );

    if (response.statusCode == 200) {
      var resUpdateJobinfo = jsonDecode(response.body);
      return resUpdateJobinfo['success'];
    } else {
      print("statusCode를 확인하세요");
      return false;
    }
  }
}

class ServiceLocation{
  Future<void> updateUserLocation(int? userId, String lat, String long) async {
    print("이거 안되는거야??");
    final response = await http.post(
      Uri.parse(API.userlocation),
      body: {
        "user_id": userId.toString(),
        "user_lat": lat,
        "user_long": long,
      },
    );

    if (response.statusCode == 200) {
      var resUpdateLocation = jsonDecode(response.body);
      print("---------------------여기----------------------");
      print(resUpdateLocation);
    } else {
      print("statusCode를 확인하세요");
    }
  }
}

void customPrint(String message) {
  final pattern = RegExp('.{1,800}'); // 800자 단위로 잘라서 출력
  pattern.allMatches(message).forEach((match) => print(match.group(0)));
}