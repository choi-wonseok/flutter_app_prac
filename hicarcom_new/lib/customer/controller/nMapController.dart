import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/locationController.dart';
import 'package:hicarcom/customer/controller/customerNavigationController.dart';
import 'package:hicarcom/data/service.dart';

import '../../model/address.dart';
import 'customerSearchController.dart';

class NMapController extends GetxController{

  NMarker? marker;
  bool isFirstLoad = true;
  late NaverMapController mapController;
  NLatLng? currentLocation;
  final TextEditingController startInputController = TextEditingController();
  final TextEditingController endInputController = TextEditingController();



  List<NLatLng> path = [];  // 경로를 저장할 변수

  Map<String, NArrowheadPathOverlay> pathOverlays = {};

  final CustomerSearchController customerSearchController = Get.find();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }



  Future<void> onMapCreated(NaverMapController controller) async {
    mapController = controller;

  }


  void onCameraIdle() async {
    if (Get.find<CustomerNavigationController>().isExpanded.value) {
      return; // isExpanded가 true인 경우 함수를 더 이상 실행하지 않음
    }
      NCameraPosition cameraPosition = await mapController.getCameraPosition();
      NLatLng lastIdlePosition = cameraPosition.target;
      if(customerSearchController.isDeparture.value){
        await customerSearchController.updateSeletedAddress(lastIdlePosition);
        await customerSearchController.updateStartingAddress(lastIdlePosition);
        customerSearchController.startlocation = lastIdlePosition;
      }else{
        await customerSearchController.updateSeletedAddress(lastIdlePosition);
        customerSearchController.endlocation = lastIdlePosition;
      }

      print("Map Center after movement stopped: Latitude: ${lastIdlePosition.latitude}, Longitude: ${lastIdlePosition.longitude}");


      marker = NMarker(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        position: lastIdlePosition,
      );

      update();
      await mapController.clearOverlays();
      mapController.addOverlay(marker!);

  }
  Future<void> processIdlePosition(NLatLng lastIdlePosition) async {
    if (customerSearchController.isDeparture.value) {
      await customerSearchController.updateSeletedAddress(lastIdlePosition);
      await customerSearchController.updateStartingAddress(lastIdlePosition);
      customerSearchController.startlocation = lastIdlePosition;
    } else {
      await customerSearchController.updateSeletedAddress(lastIdlePosition);
      customerSearchController.endlocation = lastIdlePosition;
    }
  }
  // Future<void> fetchCurrentLocation() async {
  //   NLocationOverlay locationOverlay = await mapController.getLocationOverlay();
  //   currentLocation = await locationOverlay.getPosition();
  //   print('현재 위치: ${currentLocation!.latitude}, ${currentLocation!.longitude}');
  //
  //   startingAddressController.text = selectedItemAddress.value;
  // }

  Future<void> moveToCurrentLocation() async {
    NLocationOverlay locationOverlay = await mapController.getLocationOverlay();
    NLatLng currentLocation = await locationOverlay.getPosition();
    // 마커 추가

    NCameraUpdate cameraUpdate = NCameraUpdate.scrollAndZoomTo(
        target: currentLocation, zoom: 16.0);
    mapController.updateCamera(cameraUpdate);
    await customerSearchController.updateStartingAddress(currentLocation);

  }

  Future<void> drawPath(NLatLng start, NLatLng end) async {
    Map<String, dynamic> routes = await NaAddress().wayPath(start, end);
    for (var option in ['trafast', 'tracomfort', 'traoptimal']) {
      List<NLatLng> path = routes[option]['path'];

      // 경로를 지도에 표시
      NArrowheadPathOverlay pathOverlay = NArrowheadPathOverlay(
          id: 'path_$option',
          coords: path,
          width: 10,
          color: option == 'trafast' ? Colors.red : option == 'tracomfort' ? Colors.green : Colors.blue
      );

      mapController.addOverlay(pathOverlay);
      pathOverlays[option] = pathOverlay;
    }
  }
  void showPath(String option) {
    for (var key in pathOverlays.keys) {
      NOverlayInfo overlayInfo = NOverlayInfo(
        id: pathOverlays[key]!.info.id,
        type: NOverlayType.pathOverlay,
      );
      if (key == option) {
        // 선택된 경로를 지도에 추가
        mapController.addOverlay(pathOverlays[key]!);
      } else {
        // 기존에 추가된 경로가 있다면 지도에서 제거
        mapController.deleteOverlay(overlayInfo);
      }
    }
  }


  void appReset() {
    marker = null;
    isFirstLoad = true;
    path.clear();

  }
}

