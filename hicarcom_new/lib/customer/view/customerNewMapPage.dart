import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:hicarcom/customer/controller/customerNavigationController.dart';
import 'package:hicarcom/customer/controller/customerSearchController.dart';
import 'package:hicarcom/customer/controller/nMapController.dart';
import 'package:hicarcom/customer/view/pathMap.dart';

import 'customerAddDialog.dart';

class CustomerNewMapPage extends StatelessWidget {
  final customerSearchController = Get.find<CustomerSearchController>();
  final nmapController = Get.put(NMapController());
  final customerNavigationController = Get.find<CustomerNavigationController>();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
          Obx(() => NaverMap(
            options: NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: customerSearchController.selectedPosition.value,
                zoom: 16.0,
              ),
              mapType: NMapType.navi,
              zoomGesturesEnable: true,
              indoorEnable: false,
              // 실내 맵 사용 가능 여부 설정
              locationButtonEnable: true,
              // 위치 버튼 표시 여부 설정
              consumeSymbolTapEvents: false,
            ),
            onMapReady: (controller) async {
              nmapController.onMapCreated(controller);

            },
           onCameraIdle: () {
             if (!customerSearchController.isDestinationSet.value) {
               nmapController.onCameraIdle();
             }
           },
          ),),
          Positioned(
            top: 30, // 버튼의 상단 위치 조절
            left: 10, // 버튼의 좌측 위치 조절
            child: FloatingActionButton(
              child: Icon(Icons.arrow_back,size: 20,),
              backgroundColor: Colors.blue,
              mini: true,
              onPressed: () {
                Get.toNamed('/');
                customerNavigationController.toggleExpand();

              },
            ),
          ),
          Obx(() {
            if(!customerSearchController.isDestinationSet.value) {
              return Positioned(
                top: MediaQuery.of(context).size.height / 2 - 50, // 마커 이미지의 절반 높이만큼 오프셋 조정
                left: MediaQuery.of(context).size.width / 2 - 50, // 마커 이미지의 절반 너비만큼 오프셋 조정
                child:  Image.asset(
                  customerSearchController.isDeparture.value ? 'assets/images/depart.png' : 'assets/images/arrival.png',
                  width: 100, height: 100,
                ),
              );
            }
            else {
              return Container();// 빈 컨테이너를 반환하여 마커 이미지를 보이지 않게 합니다.
            }
          }),
          Positioned(
            bottom: 0,
            child: Obx(() => Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if(!customerSearchController.isDestinationSet.value)...[
                    Text(
                      customerSearchController.selectedItemTitle.value,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      customerSearchController.selectedItemAddress.value,
                      style: TextStyle(fontSize: 14,color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                  ]else...[
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            height: 50,
                            color: Colors.red,
                            onPressed: () {
                              nmapController.showPath('trafast');
                            },
                            child: Text('Fastest', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            height: 50,
                            color: Colors.green,
                            onPressed: () {
                              nmapController.showPath('tracomfort');
                            },
                            child: Text('comfortable path', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            height: 50,
                            color: Colors.blue,
                            onPressed: () {
                              nmapController.showPath('traoptimal');
                            },
                            child: Text('Optimal path', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 20),
                          readOnly: true,
                          showCursor: true,
                          controller: customerSearchController.startingAddressController,
                          decoration: InputDecoration(
                            label: Text("출발지"),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.keyboard_double_arrow_down_sharp ,size: 15),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 20),
                          readOnly: true,
                          showCursor: true,
                          controller: customerSearchController.endingAddressController,
                          decoration: InputDecoration(
                            label: Text("도착지"),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.place_outlined, size: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                  MaterialButton(
                    height: 50,
                    color: Colors.blue,
                    onPressed: () {
                      if (customerSearchController.isDeparture.value) {
                        customerSearchController.startingAddressController.text =
                        customerSearchController.selectedItemTitle.value != '' ?
                        customerSearchController.selectedItemTitle.value : customerSearchController
                            .selectedItemAddress.value;

                        customerSearchController.resetSearch();
                        customerNavigationController.toggleExpand();
                        Get.toNamed('/');
                      } else if (!customerSearchController.isDeparture.value &&
                          !customerSearchController.isDestinationSet.value) {
                        customerSearchController.endingAddressController.text =
                        customerSearchController.selectedItemTitle.value != '' ?
                        customerSearchController.selectedItemTitle.value : customerSearchController
                            .selectedItemAddress.value;
                        customerSearchController.isDestinationSet.value = true;
                        if (customerSearchController.startlocation != null &&
                            customerSearchController.endlocation != null) {
                          customerSearchController.finalStartingAddressController.text = customerSearchController.startingAddressController.text;
                          customerSearchController.finalEndingAddressController.text = customerSearchController.endingAddressController.text;
                          nmapController.drawPath(
                              customerSearchController.startlocation!, customerSearchController.endlocation!);
                        }else{
                          print("출발지 혹은 도착지를 다시 선택해주세요");
                        }

                      }else{

                        Get.dialog(
                            CustomerAddDialog(
                              finalStartingAddressController: customerSearchController.finalStartingAddressController,
                              finalEndingAddressController: customerSearchController.finalEndingAddressController,
                            )
                        );


                      }
                    },
                    minWidth: double.infinity,
                    child: Text(
                      customerSearchController.isDeparture.value ? '출발지설정' : customerSearchController.isDestinationSet.value ? '접수요청' : '도착지설정',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),)

          ),
        ],
      ),
    );
  }
}