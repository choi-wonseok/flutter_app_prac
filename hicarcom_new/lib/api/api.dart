import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  static String get hostConnect => dotenv.env['API_HOST'] ?? "";
  static String get hostConnectInfo => "$hostConnect/info";
  static String get addinfo => "$hostConnect/info/addinfo.php";
  static String get getinfo => "$hostConnect/info/getinfo.php";
  static String get getimage => "$hostConnect/info/getimage.php";
  static String get updateinfo => "$hostConnect/info/updateinfo.php";
  static String get takejob => "$hostConnect/info/takejob.php";
  static String get imageupload => "$hostConnect/info/imageupload.php";
  static String get deleteimage => "$hostConnect/info/deleteimage.php";
  static String get getcompanyinfo => "$hostConnect/info/getcompanyinfo.php";
  static String get loginInfo => "$hostConnect/info/logininfo.php";
  static String get notification => "$hostConnect/info/notification.php";
  static String get addtoken => "$hostConnect/info/addtoken.php";
  static String get userinfo => "$hostConnect/info/userinfo.php";
  static String get updatealarm => "$hostConnect/info/updatealarm.php";
  static String get updatealarmkm => "$hostConnect/info/updatealarmkm.php";
  static String get getuserprofile => "$hostConnect/info/getuserprofile.php";
  static String get updateprofile => "$hostConnect/info/updateprofile.php";
  static String get deleteprofile => "$hostConnect/info/deleteprofile.php";
  static String get userlocation => "$hostConnect/info/userlocation.php";
}
