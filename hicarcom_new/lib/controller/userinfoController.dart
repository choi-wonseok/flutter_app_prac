import 'package:get/get.dart';

import '../data/service.dart';
import 'numberController.dart';

class UserInfoController extends GetxController {
   RxBool isAlarm = false.obs;
   RxDouble alarmKm = 0.0.obs;
   RxString userProfile = ''.obs;
   final service = ServiceUserInfo();

   @override
   void onInit() {
      fetchData();
      super.onInit();
   }

   void fetchData() async {
      var mobilenumbercontroller = Get.find<MobileNumberController>();
      await mobilenumbercontroller.initialization; //
      var userId = mobilenumbercontroller.userinfolist[0].userId;
      var data = await service.userInfoSome(userId);
      print(data);
      if (data['success']) {
         isAlarm.value = data['user_alarm'];
         alarmKm.value = data['user_alarm_km'];

      }else{
         print("데이터를 가져오지 못하였습니다.");
      }
   }

   void updateAlarmData(int userId,bool value) async {
      bool success = await service.updateUserAlarm(userId, value);
      if (success) {
         isAlarm.value = value;
      }
   }
   void updateAlarmKm(int userId, double newValue) async {
      bool success = await service.updateUserAlarmKm(userId, newValue);
      if (success) {
         alarmKm.value = newValue;
      }
   }
}
