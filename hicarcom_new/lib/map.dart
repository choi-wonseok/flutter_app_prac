import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/locationController.dart'; // 가정한 위치
import 'package:hicarcom/customer/controller/customerNavigationController.dart';
import 'package:hicarcom/customer/view/customerPage1.dart';

import 'customer/view/customerPage2.dart';

class NaverMapApp extends StatelessWidget {
  NaverMapApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.find<LocationController>(); // LocationController 인스턴스 가져오기
    final customerNavigationcontroller = Get.find<CustomerNavigationController>();
    return FutureBuilder(
      // LocationController의 초기화를 기다립니다
      future: locationController.getStarted(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 로딩 상태 표시
          return MaterialApp(home: Scaffold(body: Center(child: CircularProgressIndicator())));
        } else if (snapshot.hasError) {
          // 오류가 발생한 경우 오류 메시지 표시
          return MaterialApp(home: Scaffold(body: Center(child: Text('오류 발생: ${snapshot.error}'))));
        }

        // Future가 완료되면 원래의 UI를 반환합니다
        return Obx(() =>GetMaterialApp(
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: customerNavigationcontroller.isExpanded.value ? null : AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Image.asset('assets/images/logo.png', width: 130),
              bottom: TabBar(
                controller: customerNavigationcontroller.controller,
                labelColor: Colors.black,
                tabs: customerNavigationcontroller.myTabs,
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: customerNavigationcontroller.controller,
              children: [
                CustomerPage1(),
                CustomerPage2(),
              ],
            )
            ),
          ),
        );
      },
    );
  }
}
