
import 'package:flutter/material.dart';
import 'package:get/get.dart';
  import 'package:hicarcom/customer/view/customerPage1.dart';
  import 'package:hicarcom/customer/view/customerPage2.dart';

  class CustomerNavigationController extends GetxController with GetSingleTickerProviderStateMixin{
    late TabController controller;

    final List<Tab> myTabs = <Tab>[
      const Tab(
        text: '운행접수'
      ),
      const Tab(
        text: '접수내역',
      )
    ];

    @override
    void onInit() {
      controller = TabController(length: 2, vsync: this);
      super.onInit();
  }
    @override
    void onClose() {
      controller.dispose();
      super.onClose();
    }

    var isExpanded = false.obs;
    var isReadOnly = true.obs;



    void toggleExpand() {
      isExpanded.value = !isExpanded.value;
      isReadOnly.value = true;// 플래그 값 반전
    }

    final screens = [
      CustomerPage1(),
      CustomerPage2(),
    ];

    var departureLatLng = "".obs; // 출발지 좌표를 문자열로 저장

    void setDepartureLatLng(String latLng) {
      departureLatLng.value = latLng;
    }



  }