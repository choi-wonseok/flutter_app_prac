import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/view/page1.dart';
import 'package:hicarcom/view/page2.dart';
import 'package:hicarcom/view/page3.dart';
import 'package:hicarcom/view/page4.dart';

import '../view/update.dart';
import 'getinfoController.dart';

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  Timer? _timer;


  final screens = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
  ];


  void changePage(int newIndex) {
    selectedIndex.value = newIndex;

    if (newIndex == 0) {
      // Start or reset the timer when navigating to page 1
      _timer?.cancel();
      _timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
        // Implement your update logic here, e.g.:
        Get.find<GetInfoController>().fetchData("1", "1", 1,null);
      });
    } else {
      // Cancel the timer when navigating away from page 1
      _timer?.cancel();
    }
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is being disposed
    _timer?.cancel();
    super.onClose();
  }
}