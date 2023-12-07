// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() async {
//   String url = 'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=127.1054221,37.3591614&orders=legalcode,admcode,addr,roadaddr&&output=json';
//   String clientId = "YOUR_CLIENT_ID"; // 네이버 API 클라이언트 ID
//   String clientSecret = "YOUR_CLIENT_SECRET"; // 네이버 API 클라이언트 Secret
//
//   http.Response response = await http.get(Uri.parse(url),
//     headers: {"X-NCP-APIGW-API-KEY-ID": clientId, "X-NCP-APIGW-API-KEY": clientSecret},);
//
//   if (response.statusCode == 200) {
//     var jsonResponse = json.decode(response.body);
//     var address = jsonResponse['results'][0]['region']['area1']['name'] + ' ' +
//         jsonResponse['results'][0]['region']['area2']['name'] + ' ' +
//         jsonResponse['results'][0]['region']['area3']['name'];
//     print('Address: $address');
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }
