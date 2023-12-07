import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/dropdownController.dart';
import 'package:hicarcom/controller/notifiController.dart';
import 'package:hicarcom/controller/userprofileController.dart';
import 'package:hicarcom/map.dart';

import '../controller/numberController.dart';
import '../controller/userinfoController.dart';

class Page4 extends StatelessWidget {
  Page4({Key? key}) : super(key: key);
  final mobileNumberController = Get.find<MobileNumberController>();
  final notifiController = Get.put(NotificationController());

  final userprofileController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    final userinfoController = Get.find<UserInfoController>();

    var userinfolist = mobileNumberController.userinfolist;
    // userprofileController.updateUserId(userinfolist[0].userId.toString());


    return Column(
      children: [
        Container(
          height: 70,
          padding: const EdgeInsets.only(
              left: 16, right: 16, top: 4, bottom: 2),
          margin: const EdgeInsets.all(
              15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 0,
                  blurRadius: 10.0,
                )
              ]
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Obx(() {
                  // userprofileController의 image를 수신하여 CircleAvatar에 표시
                  return CircleAvatar(
                    radius: 30,
                    backgroundImage: userprofileController.userProfile.value != ''
                        ? NetworkImage(userprofileController.profile.value) as ImageProvider
                        : const AssetImage('assets/images/unknown.png'),
                  );
                }),
              ),
              SizedBox(width: 20,),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userinfolist[0].userName),
                    Text(userinfolist[0].userPhoneNumber)
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: OverflowBox(
                  maxWidth: double.infinity,
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                      onPressed: () {
                        print(userprofileController.profile.value);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Obx(  // StatefulBuilder를 Obx로 변경
                                  () {

                                return AlertDialog(
                                  content: Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      // Profile Image
                                      CircleAvatar(
                                        radius: 100,
                                        backgroundImage: userprofileController.userProfile.value != ''
                                            ? NetworkImage(userprofileController.profile.value) as ImageProvider
                                            : const AssetImage('assets/images/unknown.png'),
                                      ),
                                      // Close Button
                                      Positioned(
                                        right: -10,
                                        top: -10,
                                        child: IconButton(
                                            icon: Icon(Icons.close_outlined),
                                            onPressed: (){
                                              Get.back();
                                            }
                                        ),
                                      ),
                                      // Camera Button
                                      Positioned(
                                        right: -10,
                                        bottom: -10,
                                        child: IconButton(
                                          icon: Icon(Icons.camera_enhance_rounded),
                                          onPressed: () => showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Wrap(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                      } ,
                                                      child: Icon(Icons.close_rounded),
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.photo_camera),
                                                  title: Text('직접 촬영하기'),
                                                  onTap: (){
                                                    userprofileController.addImage(
                                                        chooseNum: 1, userId: userinfolist[0].userId.toString());
                                                    Get.back();
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.photo_library),
                                                  title: Text('사진첩에서 선택하기'),
                                                  onTap: () {
                                                    userprofileController.addImage(
                                                        chooseNum: 2, userId: userinfolist[0].userId.toString());
                                                    Get.back();
                                                  },
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.delete_forever_outlined),
                                                  title: Text('사진 삭제하기'),
                                                  onTap: () {
                                                    userprofileController.addImage(
                                                        chooseNum: 3, userId: userinfolist[0].userId.toString());
                                                    Get.back();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );

                      },
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit),
                          Text('사진변경')
                        ],
                      ),
                      label: const Text('')
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.only(
              left: 16, right: 16, top: 4, bottom: 2),
          margin: const EdgeInsets.all(
              15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 0,
                  blurRadius: 10.0,
                )
              ]
          ),
          child: Row(
            children: [
              const Icon(Icons.settings),
              SizedBox(width: 20,),
              const Flexible(
                  fit: FlexFit.tight,
                  child: Text('접수알림')
              ),
              SizedBox(
                  child: Obx(() =>
                      Switch(
                        value: userinfoController.isAlarm.value,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          userinfoController.updateAlarmData(mobileNumberController.userinfolist[0].userId!,value);
                        },
                      )
                  ),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.only(
              left: 16, right: 16, top: 4, bottom: 2),
          margin: const EdgeInsets.all(
              15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 0,
                  blurRadius: 10.0,
                )
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.person),
              SizedBox(width: 20,),
              Text('출발지 GPS 거리설정'),
              SizedBox(width: 10),
              // Adds a small space between the text and the dropdown
              SizedBox(
                width: 90,
                child:
                Obx(() {
                  return DropdownButton<double>(
                    value: userinfoController.alarmKm.value,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onSurface,
                    ),
                    underline: Container(
                      height: 2,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    ),
                    onChanged: (double? newValue) {
                      if (newValue != null) {
                        userinfoController.alarmKm.value = newValue;
                        userinfoController.updateAlarmKm(mobileNumberController.userinfolist[0].userId!,newValue); // 서버에 변경된 거리값을 업데이트하는 메서드를 호출
                      }
                    },
                    items: <Map<String, double>>[
                      {'전체보기': 0.0},
                      {'10km': 10.0},
                      {'30km': 30.0},
                      {'50km': 50.0},
                      {'100km': 100.0},
                      {'200km': 200.0},
                    ].map<DropdownMenuItem<double>>((Map<String,
                        double> value) {
                      String displayText = value.keys.first;
                      double distanceValue = value.values.first;
                      return DropdownMenuItem<double>(
                        value: distanceValue,
                        child: Text(displayText),
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
        ElevatedButton(onPressed: () {
          Get.to(NaverMap());
        }, child: Text("눌러"),),
      ],
    );
  }
}
