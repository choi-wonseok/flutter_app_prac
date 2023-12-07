import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/addController.dart';
import 'package:hicarcom/controller/addressSearchController.dart';
import 'package:hicarcom/controller/getcompanyinfoController.dart';
import 'package:hicarcom/controller/getinfoController.dart';
import 'package:hicarcom/controller/locationController.dart';
import 'package:hicarcom/controller/navigationController.dart';
import 'package:hicarcom/controller/numberController.dart';
import 'package:hicarcom/controller/updateController.dart';
import 'package:hicarcom/data/service.dart';
import 'package:hicarcom/model/address.dart';
import 'package:hicarcom/model/address1.dart';
import 'package:hicarcom/model/getcompanyinfo.dart';
import 'package:hicarcom/model/getinfo.dart';
import 'package:hicarcom/view/utilities.dart';


class DetailsDialog extends StatelessWidget {
  final GetInfo getinfo;
  DetailsDialog({Key? key, required this.getinfo}) : super(key: key);

  final updateController = Get.put(UpdateController());
  final locationController = Get.put(LocationController());
  final mobileNumberController = Get.put(MobileNumberController());


  @override
  Widget build(BuildContext context) {
    double baseFontSize = MediaQuery.of(context).size.width * 0.045; // 디바이스 너비의 4.5%를 기본 글씨 크기로 사용합니다.
    final userinfolist = mobileNumberController.userinfolist;
    TextStyle defaultTextStyle(double scale) {
      return TextStyle(
        fontSize: baseFontSize * scale, // 기본 글씨 크기에 스케일을 곱하여 조정합니다.
      );
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children:[
                  Text(
                    getinfo.regiType,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    getinfo.regiCarNum,
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const MySeparator(color: Colors.grey),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InfoColumn(title: '예약날짜', value: getinfo.regiDate),
                  InfoColumn(title: '예약출발시간', value: getinfo.regiReserveDt),
                  InfoColumn(title: '예약도착시간', value: getinfo.regiReserveAt),
                ],
              ),
              const SizedBox(height: 10),
              InfoSection(title: '출발지', value: getinfo.regiDAddress),
              const SizedBox(height: 10),
              InfoSection(title: '도착지', value: getinfo.regiAAddress),
              const SizedBox(height: 10),
              Obx(() => InfoSection(
                title: '출발지 까지의 거리',
                value: '${locationController.calculateDistance(getinfo.regiDLat, getinfo.regiDLong).toStringAsFixed(1)} Km',
              )),
              const SizedBox(height: 10),
              InfoSection(title: '특이사항', value: getinfo.regiDetail ?? ""),
              const SizedBox(height: 30),
              PaymentSection(type: getinfo.regiPayType, amount: getinfo.regiPay),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(), // Close the dialog
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: () async {
                      bool success = await updateController.takeJob(getinfo.regiId.toString(), userinfolist[0].userId);
                      if (success) {
                        Get.back();
                        Get.find<NavigationController>().changePage(1);
                      }
                    },
                    child: const Text('확인'),
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

class AddressDialog extends StatelessWidget {

  final AddressController addressController;
  final RxString addressRxString; // 추가된 부분
  final bool isadd;
  final bool isDeparture;
  late final dynamic bothController;

  AddressDialog({Key? key,
    required this.addressController,
    required this.addressRxString,
    required this.isadd,
    required this.isDeparture,

  }) : super(key: key){
    // Initialize the controller based on isadd value
    bothController = isadd ? Get.put(AddController()) : Get.put(UpdateController());
  }
  final locationController = Get.find<LocationController>();

  var isAddressSelected1 = false;
  var isAddressSelected2 = false;

  void _clearInputFields() {
    addressController.searchTextController.clear();
    addressController.searchDetailController.clear();
    addressController.searchlongController.clear();
    addressController.searchlatController.clear();
  }




  @override
  Widget build(BuildContext context) {
    double dialogHeight = MediaQuery.of(context).size.height / 2;

    return Dialog(
      child: Container(
        height: dialogHeight,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildAddressTextField(),
            _buildAddressList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _clearInputFields();
                    Get.back();
                  }, // Close the dialog
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    if (isAddressSelected1){
                      if (isDeparture) {
                        // 출발지 정보 업데이트
                        bothController.regiDAddress.value = "${addressController.searchTextController.text.trim()} ${addressController.searchDetailController.text.trim()}";
                        bothController.regiDLong.value = addressController.searchlongController.text.trim();
                        bothController.regiDLat.value = addressController.searchlatController.text.trim();
                        bothController.regiDistance.value = locationController.calculateDistance(addressController.searchlatController.text.trim(), addressController.searchlongController.text.trim()).toString();
                        print("_+_+_+__+_+_+__+_+_+_+_+_+_+_");
                        print(bothController.regiDLat.value);
                        print(bothController.regiDLong.value);
                        print(bothController.regiDistance.value);
                      } else {
                        // 도착지 정보 업데이트
                        bothController.regiAAddress.value = "${addressController.searchTextController.text.trim()} ${addressController.searchDetailController.text.trim()}";
                        bothController.regiALong.value = addressController.searchlongController.text.trim();
                        bothController.regiALat.value = addressController.searchlatController.text.trim();
                        print(bothController.regiDLat.value);
                        print(bothController.regiDLong.value);
                      }
                      addressRxString.value = isDeparture ? bothController.regiDAddress.value : bothController.regiAAddress.value;
                      _clearInputFields();
                      Get.back();
                    }else{
                      Get.dialog(
                        AlertDialog(
                          title: Text("주소를 검색해 선택해 주세요"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("확인"),
                              onPressed: () {
                                Get.back(); // 경고 다이얼로그 닫기
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    },
                  child: const Text('확인'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String currentInput = '';

  Widget _buildAddressTextField() {
    return TextField(
      controller: addressController.searchTextController,
      focusNode: bothController.focusNode,
      decoration: InputDecoration(
        labelText: "주소를 입력하세요",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            // 사용자가 입력한 주소로 검색
            addressController.naFetchAddress(addressController.searchTextController.text);
          },
          icon: Icon(Icons.search),
        ),
      ),
      onTap: () => bothController.isFieldFocused.value = true,
    );
  }


  Widget _buildAddressList() {
    return Obx(() {
      if (bothController.isFieldFocused.value && addressController.naAddressList.isNotEmpty) {
        return _buildListView();
      } else if (isAddressSelected1 == true) {
        return TextField(
          controller: addressController.searchDetailController,
          decoration: InputDecoration(
            labelText: "상세주소를 입력하세요.",
            border: OutlineInputBorder(),
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: addressController.naAddressList.length,
        itemBuilder: (context, index) {
          final address = addressController.naAddressList[index];
          print(address);
             return ListTile(
              title: _buildAddressTile(address),
              onTap: () {
                bothController.focusNode.unfocus();
                bothController.isFieldFocused.value = false;
                isAddressSelected1 = true;
                addressController.searchTextController.text = "${address.roadAddress} ${address.title}";
                addressController.searchlongController.text = address.mapx;
                addressController.searchlatController.text = address.mapy;

              },
            );
        },
      ),
    );
  }

  Widget _buildAddressTile(Item address) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address.title, style: TextStyle(fontSize: 13)),
          SizedBox(height: 5),
          Text(address.address, style: TextStyle(fontSize: 12, color: Color(0xFFA8A8A8))),
          Text('[도로명] ' + address.roadAddress, style: TextStyle(fontSize: 12, color: Color(0xFFA8A8A8))),
          Text(address.mapx),
          Text(address.mapy)
        ],
      ),
    );
  }
}

class SearchCompanyDialog extends StatelessWidget {
  final Function(InfoDatum) onSelect;
  SearchCompanyDialog({super.key, required this.onSelect});

  final companyGetInfoController = Get.put(CompanyInfoController());

  @override
  Widget build(BuildContext context) {
    double dialogHeight = MediaQuery.of(context).size.height / 2;
    return Dialog(
      child: Container(
        height: dialogHeight,
        child: Column(
          children: [
            SearchBar(
              onChanged: (value) => companyGetInfoController.searchCompanyInfo(value),
              hintText: '검색어를 입력하세요...',
              leading: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface),
            ),
            Obx(() => Expanded(
              child: ListView.builder(
                itemCount: companyGetInfoController.companyInfoSearch.length,
                itemBuilder: (context, index) {
                  final information = companyGetInfoController.companyInfoSearch[index];
                  return ListTile(
                    title: _buildInformationTile(information),
                    onTap: () {
                      onSelect(information);
                      Get.back();
                    },
                    // 여기에 다른 정보들을 표시하는 코드 추가
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildInformationTile(information) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(information.userName, style: TextStyle(fontSize: 13)),
          SizedBox(height: 5),
          Text(information.companyName, style: TextStyle(fontSize: 12, color: Color(0xFFA8A8A8))),
          Text(information.branchName, style: TextStyle(fontSize: 12, color: Color(0xFFA8A8A8))),
          Text(information.phoneNumber, style: TextStyle(fontSize: 12, color: Color(0xFFA8A8A8))),
        ],
      ),
    );
  }
}
