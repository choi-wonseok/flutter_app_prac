import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/dropdownController.dart';
import 'package:hicarcom/controller/locationController.dart';
import 'package:hicarcom/controller/navigationController.dart';
import 'package:hicarcom/controller/userinfoController.dart';
import 'package:hicarcom/data/service.dart';
import 'package:hicarcom/model/getinfo.dart';


class GetInfoController extends GetxController {
  Timer? refreshTimer;
  var getinfoList = <GetInfo>[].obs;
  var getinfoSearch = <GetInfo>[].obs;
  var getDistanceList = <GetInfo>[].obs;
  var selectedDate1 = DateTime.now().obs;
  var selectedDate2 = DateTime.now().obs;
  var selectedDate3 = DateTime.now().obs;
  var selectedDate4 = DateTime.now().obs;
  var totalRegiPay = 0.obs;
  var totalOutstandingBalance = 0.obs;
  var totalValueAddedTax = 0.obs;
  var totalCash = 0.obs;
  var totalCard = 0.obs;

  final LocationController locationController = Get.put(LocationController());


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  Future<void> fetchData(String type1, String type2, int num, int? userId) async {
    final userinfoController = Get.find<UserInfoController>();
    if (num == 1) {
      var products = await ServiceList.fetchList(type1, type2, selectedDate1.value, selectedDate2.value,userId);
      getinfoList.assignAll(products);
      if (userinfoController.alarmKm.value == 0.0){
        getinfoSearch.assignAll(getinfoList);
      }else{
        var filteredList = getinfoList.where((item) {
          var distance = locationController.calculateDistance(item.regiDLat, item.regiDLong);
          return distance <= userinfoController.alarmKm.value;
        }).toList();
        getinfoSearch.assignAll(filteredList);
      }
    }
    else if( num == 2){
      var products = await ServiceList.fetchList(type1, type2, selectedDate3.value, selectedDate4.value,userId);
      getinfoList.assignAll(products);
      getinfoSearch.assignAll(getinfoList);
      calculateTotalRegiPay();
    }
  }










  void calculateTotalRegiPay() {
    int total = 0;
    int outstanding_balance = 0;
    int value_added_tax = 0;
    int cash = 0;
    int card = 0;

    for (var item in getinfoSearch) {
      if(item.regiLevel == "4"){
        total += int.parse(item.regiPay) ; // 가정: 각 항목에 regiPay 속성이 있다고 가정
        if (item.regiPayType == "현금"){
          cash += int.parse(item.regiPay);
        } else if (item.regiPayType == "외상"){
          outstanding_balance += int.parse(item.regiPay);
        } else if (item.regiPayType == "카드"){
          card += int.parse(item.regiPay);
        } else if (item.regiPayType == "부가세"){
          value_added_tax += int.parse(item.regiPay);
        }

      }
    }
    totalRegiPay.value = total;
    totalOutstandingBalance.value = outstanding_balance;
    totalValueAddedTax.value = value_added_tax;
    totalCash.value = cash;
    totalCard.value = card;
  }

  Future<void> chooseDate(Rx<DateTime> selectedDate, String type1, String type2, int fetchType,int? userId) async {
    await Get.dialog(
      AlertDialog(
        title: Text('날짜 선택', style: Get.textTheme.titleMedium),
        content: Container(
          height: 400,
          width: 300,
          child: Column(
            children: [
              Expanded(
                child: CalendarDatePicker(
                  initialDate: selectedDate.value,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2040),
                  onDateChanged: (DateTime newDate) {
                    selectedDate.value = newDate;
                    Get.back(); // Close the dialog using GetX
                    fetchData(type1, type2, fetchType,userId);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  selectedDate.value = DateTime.now(); // Select 'today' using GetX
                  Get.back(); // Close the dialog using GetX
                  fetchData(type1, type2, fetchType,userId);
                },
                child: Text('오늘', style: Get.textTheme.labelLarge),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchGetInfo(String query, String type1, String type2, int num,int? userId) {
    if (query.isEmpty) {
      fetchData(type1, type2, num,userId);

    } else {
      getinfoSearch.assignAll(
        getinfoList.where((item) {
          final itemString = '${item.regiAAddress} ${item.regiDAddress} ${item.regiName} ${item.regiCompany} ${item.regiCarNum}';
          return itemString.contains(query.toLowerCase());
        }).toList(),
      );
    }
    getinfoSearch.refresh();
    calculateTotalRegiPay();
  }
}


