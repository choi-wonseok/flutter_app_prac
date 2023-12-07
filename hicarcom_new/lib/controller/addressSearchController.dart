import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/data/service.dart';
import 'package:hicarcom/model/address.dart';
import 'package:hicarcom/model/address1.dart';

class AddressController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final TextEditingController searchDetailController = TextEditingController();
  final TextEditingController searchlongController = TextEditingController();
  final TextEditingController searchlatController = TextEditingController();

  var searchTec = TextEditingController();
  var scrollController = ScrollController();
  var addressList = <Juso1>[].obs;
  var naAddressList = <Item>[].obs;
  var errorMessage = "검색어를 입력하세요.".obs;

  Future<void> naFetchAddress(String keyword) async {
    var naAddressinfo = await NaAddress().naSearchAddress(keyword);
    print(naAddressinfo);
    print("===========================================================");
    naAddressList.assignAll(naAddressinfo);
  }

}


