import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/addController.dart';
import 'package:hicarcom/customer/controller/customerNavigationController.dart';
import 'package:hicarcom/customer/controller/customerSearchController.dart';
import 'package:hicarcom/customer/controller/nMapController.dart';

import 'customerPage2.dart';

class CustomerAddDialog extends StatelessWidget {
  final TextEditingController finalStartingAddressController;
  final TextEditingController finalEndingAddressController;
  CustomerAddDialog({Key? key, required this.finalStartingAddressController, required this.finalEndingAddressController}) : super(key: key);

  final nmapController = Get.find<NMapController>();
  final customerSearchController = Get.find<CustomerSearchController>();
  final customerNavigationcontroller = Get.find<CustomerNavigationController>();
  @override
  Widget build(BuildContext context) {
    final addController = Get.put(AddController());
    addController.regiDAddressController.text = finalStartingAddressController.text;
    addController.regiAAddressController.text = finalEndingAddressController.text;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: addController.regiDateController,
                  decoration: InputDecoration(
                    hintText: '날짜 입력',
                  ),
                ),
                Text('운행구분'),
                Obx(() => ToggleButtons(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.local_shipping,size: 12),
                        SizedBox(width: 5),
                        Text('차량탁송',style: TextStyle(fontSize: 13),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.person,size: 12),
                        SizedBox(width: 5),
                        Text('대리운전',style: TextStyle(fontSize: 13),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.directions_car,size: 12),
                        SizedBox(width: 5),
                        Text('일일기사',
                        style: TextStyle(fontSize: 13),)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.car_rental,size: 12,),
                        SizedBox(width: 5),
                        Text('셀프카',style: TextStyle(fontSize: 13),)
                      ],
                    ),

                  ],
                  onPressed: (int index) {
                    addController.selectedServiceIndex.value = index;
                  },
                  isSelected: List.generate(4, (index) => addController.selectedServiceIndex.value == index),
                )),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: addController.regiReserveDtController,
                        decoration: InputDecoration(
                          hintText: '예약 출발시간 입력',
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: TextField(
                        controller: addController.regiReserveAtController,
                        decoration: InputDecoration(
                          hintText: '예약 도착시간 입력',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: addController.regiCarTypeController,
                        decoration: InputDecoration(
                          hintText: '차량 유형 입력',
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextField(
                        controller: addController.regiCarNumController,
                        decoration: InputDecoration(
                          hintText: '차량 번호 입력',
                        ),
                      ),
                    ),
                  ],
                ),
                Text(addController.regiDAddressController.text),
                TextField(
                  controller: addController.regiDContactController,
                  decoration: InputDecoration(
                    hintText: '출발지 연락처 입력',
                  ),
                ),
                Text(addController.regiAAddressController.text),
                TextField(
                  controller: addController.regiAContactController,
                  decoration: InputDecoration(
                    hintText: '도착지 연락처 입력',
                  ),
                ),
                TextField(
                  controller: addController.regiDetailController,
                  decoration: InputDecoration(
                    hintText: '세부사항 입력',
                  ),
                ),
                TextField(
                  controller: addController.regiPayTypeController,
                  decoration: InputDecoration(
                    hintText: '결제 유형 입력',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('취소'),
                    ),

                    ElevatedButton(
                      onPressed: (){
                        nmapController.appReset();
                        customerSearchController.appReset();
                        Get.toNamed('/');
                        customerNavigationcontroller.controller.index = 1;
                      },
                      child: Text('저장'),
                    ),
                  ],
                ),
              ],
          ),
        ),
      ),
    );
  }
}
