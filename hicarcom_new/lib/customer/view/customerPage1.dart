import 'dart:developer' as developer;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/locationController.dart';
import 'package:hicarcom/customer/controller/customerNavigationController.dart';
import 'package:hicarcom/customer/controller/customerSearchController.dart';
import 'package:hicarcom/customer/controller/nMapController.dart';
import 'package:hicarcom/customer/view/customerNewMapPage.dart';

void onSymbolTapped(NSymbolInfo symbolInfo) {
  developer.log('Symbol tapped: $symbolInfo');
}

class CustomerPage1 extends StatelessWidget {
  CustomerPage1({super.key});

  final locationController = Get.find<LocationController>();
  final customerSearchController = Get.put(CustomerSearchController());
  final nmapController = Get.put(NMapController());

  @override
  Widget build(BuildContext context) {
    final customerNavigationController =
        Get.find<CustomerNavigationController>();
    final appBarHeight = AppBar().preferredSize.height;

    return Stack(
      children: <Widget>[
        Obx(
          () => SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - appBarHeight,
            child: NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                    target: NLatLng(locationController.latitude.value,
                        locationController.longitude.value),
                    zoom: 16.0),
                zoomGesturesEnable: true,
                indoorEnable: false,
                // 실내 맵 사용 가능 여부 설정
                locationButtonEnable: true,
                // 위치 버튼 표시 여부 설정
                consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
              ),
              onMapReady: (controller) async {
                nmapController.onMapCreated(controller);

                log("onMapReady", name: "onMapReady");
              },
              onSymbolTapped: onSymbolTapped,
              onCameraIdle: () => nmapController.onCameraIdle(),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2 - appBarHeight - 60, // 깃발 이미지의 절반 높이만큼 오프셋 조정
          left: MediaQuery.of(context).size.width / 2 - 50, // 깃발 이미지의 절반 너비만큼 오프셋 조정
          child: Image.asset('assets/images/depart.png',
              width: 100, height: 100), // 깃발 이미지 크기 설정
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: customerNavigationController.isExpanded.value
                  ? MediaQuery.of(context).size.height
                  : 174,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (customerNavigationController.isExpanded.value)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_downward), // 뒤로가기 아이콘
                        onPressed:
                        customerNavigationController.toggleExpand,
                      ),
                    ),
                  if (!customerNavigationController.isExpanded.value)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextButton(
                        onPressed: () async {
                          await nmapController.moveToCurrentLocation();
                        },
                        child: Text('내 위치'),
                      ),
                    ),
                  TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    readOnly: customerNavigationController.isReadOnly.value,
                    showCursor: true,
                    controller: customerSearchController.startingAddressController,
                    decoration: InputDecoration(
                      hintText: "출발지",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.add_circle_outlined, size: 15),
                    ),
                    onTap: () {
                      if (!customerNavigationController.isExpanded.value) {
                        customerNavigationController.toggleExpand();
                      }
                      customerNavigationController.isReadOnly.value = false;
                      customerSearchController.isDeparture.value = true;
                      customerSearchController.resetSearch();
                    },
                    onSubmitted: (value){
                      customerSearchController.searchAddress(value);

                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    readOnly: customerNavigationController.isReadOnly.value,
                    showCursor: true,
                    controller: customerSearchController.endingAddressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.add_circle_outlined, size: 15),
                      hintText: "도착지",
                    ),
                    onTap: () {
                      if (!customerNavigationController.isExpanded.value) {
                        customerNavigationController.toggleExpand();
                      }

                      customerNavigationController.isReadOnly.value = false;
                      customerSearchController.isDeparture.value = false;
                      customerSearchController.resetSearch();
                    },
                    onSubmitted: (value){
                      customerSearchController.searchAddress(value);

                    },
                  ),
                  if (customerNavigationController.isExpanded.value) ...[
                    const Divider(),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Text(customerSearchController.isSearchPerformed.value ? "검색결과" : "최근내역"),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: customerSearchController.listItems.length,
                        itemBuilder: (context, index) {
                          final item = customerSearchController.listItems[index];
                          return ListTile(
                            title: Text(item.title),
                            subtitle: Text(item.address,style: TextStyle(fontSize: 12,color: Colors.grey)),
                            onTap: () {
                              customerSearchController.selectedItemTitle.value = item.title;
                              customerSearchController.selectedItemAddress.value = item.address;
                              customerSearchController.selectedPosition.value = NLatLng(double.parse(item.mapy),double.parse(item.mapx));

                              if(customerSearchController.isDeparture.value){
                                customerSearchController.startingAddressController.text = item.title;
                                customerSearchController.startlocation = NLatLng(double.parse(item.mapy),double.parse(item.mapx));
                              }else{
                                customerSearchController.endingAddressController.text = item.title;
                                customerSearchController.endlocation = NLatLng(double.parse(item.mapy),double.parse(item.mapx));
                              }
                              Get.to(() => CustomerNewMapPage()); // NewMapPage는 새로운 지도 화면을 나타내는 위젯입니다.
                              customerNavigationController.toggleExpand();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
