import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hicarcom/data/service.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class CustomerSearchController extends GetxController{
  final TextEditingController startingAddressController = TextEditingController();
  final TextEditingController endingAddressController = TextEditingController();
  final TextEditingController finalStartingAddressController = TextEditingController();
  final TextEditingController finalEndingAddressController = TextEditingController();
  var listItems = [].obs;
  var isSearchPerformed = false.obs;
  var isDeparture = true.obs;
  var isDestinationSet = false.obs;
  NLatLng? startlocation;
  NLatLng? endlocation;

  Rx<NLatLng> selectedPosition = NLatLng(0, 0).obs;
  RxString selectedItemTitle = ''.obs;
  RxString selectedItemAddress = ''.obs;

  void resetSearch() {
    listItems.clear();
    isSearchPerformed.value = false;
  }

  void searchAddress(String query) async {
    final results = await NaAddress().naSearchAddress(query);
    print(results);
    listItems.value = results;
    isSearchPerformed.value = true;
  }

  Future<List<String>> updateAddressFromLatLng(NLatLng position) async {
    List<String> addressInfo = await NaAddress().reverGeocoding(position);
    return addressInfo;
  }

  Future<void> updateStartingAddress(NLatLng position) async{
    List<String> address = await updateAddressFromLatLng(position);
    if(address.length ==1){
      startingAddressController.text = address[0];
    }else{
      if (address[2].isNotEmpty) {
        startingAddressController.text = address[2];
      } else if(address[1].isNotEmpty) {
        startingAddressController.text = address[1];
      }else{
        startingAddressController.text  = address[0];
      }
    }
  }

  Future<void> updateSeletedAddress(NLatLng position) async{
    List<String> address = await updateAddressFromLatLng(position);
    if(address.length ==1){
      selectedItemAddress.value = address[0];
      selectedItemTitle.value = address[0];
    }else{
      if (address[2].isNotEmpty) {
        selectedItemTitle.value = address[2];
      } else {
        selectedItemTitle.value = address[1];
      }
      selectedItemAddress.value  = address[0];
    }
  }

  void appReset() {

    startingAddressController.clear();
    endingAddressController.clear();
    listItems.clear();
    isSearchPerformed.value = false;
    selectedPosition.value = NLatLng(0, 0);
    selectedItemTitle.value = '';
    selectedItemAddress.value = '';
    startlocation = null;
    endlocation = null;
    isDeparture.value = true;
    isDestinationSet.value = false;

  }
}