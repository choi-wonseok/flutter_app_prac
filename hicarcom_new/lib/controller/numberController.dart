import 'package:get/get.dart';
import 'package:hicarcom/controller/notifiController.dart';
import 'package:hicarcom/controller/userprofileController.dart';
import 'package:hicarcom/data/service.dart';
import 'package:hicarcom/model/loginInfo.dart';
import 'package:mobile_number/mobile_number.dart';

class MobileNumberController extends GetxController {
  var mobileNumber = ''.obs;
  var userinfolist = <UserInfo>[];
  var companyLevel = ''.obs;
  late Future<bool> initialization;

  @override
  void onInit() {
    super.onInit();
    initialization = getMobileNumber();
  }
  Future<bool> getMobileNumber() async {

    try {
      String? number = await MobileNumber.mobileNumber;
      number = number?.replaceAll("82+82","0");
      mobileNumber.value = number!;
      var userinfo = await LoginInfoService().fetchLoginInfo(number);
      Get.find<UserProfileController>().updateUserId(userinfo[0].userId.toString());
      userinfolist.assignAll(userinfo);
      if (userinfo.isNotEmpty ){
        companyLevel.value = userinfo[0].companyLevel;
        return true;
      } else {
        return false;
      }

    } catch (e) {
      print("Failed to get mobile number because of '${e}'");
      return false;
    }
  }
}