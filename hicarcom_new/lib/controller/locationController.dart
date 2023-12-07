import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/numberController.dart';
import 'dart:async';

import 'package:hicarcom/data/service.dart';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  Timer? locationTimer;

  var distance = 0.0.obs;

  double calculateDistance(String regiDLat, String regiDLong) {
    var departLat = double.tryParse(regiDLat) ?? 0.0;
    var departLong = double.tryParse(regiDLong) ?? 0.0;
    double distanceInMeters = Geolocator.distanceBetween(
      latitude.value,
      longitude.value,
      departLat,
      departLong,
    );
    return distanceInMeters / 1000; // 거리를 킬로미터로 변환하여 반환
  }


  @override
  void onInit() {
    super.onInit();
    getStarted();
    startLocationUpdates();
  }
  @override
  void onClose(){
    locationTimer?.cancel();
  }

  void startLocationUpdates() {
    const updateInterval = Duration(minutes: 5); // Set the interval to 5 minutes
    locationTimer = Timer.periodic(updateInterval, (timer) async {
      await getCurrentLocation(); // Update the location every 5 minutes
    });
  }

  Future<void> getStarted() async {
    await getCurrentLocation();
    var mobilenumbercontroller = Get.find<MobileNumberController>();
    await mobilenumbercontroller.initialization; //
    var userId = mobilenumbercontroller.userinfolist[0].userId;
    await ServiceLocation().updateUserLocation(userId, latitude.value.toString(), longitude.value.toString());
  }

  Future<void> getCurrentLocation() async {
    try {
      final hasPermission = await LocationUtils.handlePermission();
      if (!hasPermission) throw 'Location permission not granted.';
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      isLoading.value = false;
      print('Current location: Latitude: ${latitude.value}, Longitude: ${longitude.value}');

    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }
}

class LocationUtils {
  static Future<bool> handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
