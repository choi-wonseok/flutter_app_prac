import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/notifiController.dart';
import 'package:hicarcom/data/service.dart';
import 'package:intl/intl.dart';
import '../model/getinfo.dart';

class AddController extends GetxController {

  var selectedServiceIndex = 0.obs;

  final RxInt regiId = 0.obs;
  final RxString regiName = ''.obs;
  final RxString regiCompany = ''.obs;
  final RxString regiCompanyBranch = ''.obs;
  final RxString regiCompanyType = ''.obs;
  final RxString regiContact = ''.obs;
  final RxString regiCarType = ''.obs;
  final RxString regiCarNum = ''.obs;
  final RxString regiType = ''.obs;
  final RxString regiDate = ''.obs;
  final RxString regiReserveDt = ''.obs;
  final RxString regiReserveAt = ''.obs;
  final RxString regiDAddress = ''.obs;
  final RxString regiDContact = ''.obs;
  final RxString regiAAddress = ''.obs;
  final RxString regiAContact = ''.obs;
  final RxString regiDepartTime = ''.obs;
  final RxString regiDepartKm = ''.obs;
  final RxString regiArriveTime = ''.obs;
  final RxString regiArriveKm = ''.obs;
  final RxString regiDetail = ''.obs;
  final RxString regiPay = ''.obs;
  final RxString regiPayType = ''.obs;
  final RxString regiLevel = ''.obs;
  final RxString regiPostDate = ''.obs;
  final RxString regiDLat = ''.obs;
  final RxString regiDLong = ''.obs;
  final RxString regiALat = ''.obs;
  final RxString regiALong = ''.obs;
  final RxString regiDistance = ''.obs;

  final TextEditingController regiIdController = TextEditingController();
  final TextEditingController regiNameController = TextEditingController();
  final TextEditingController regiCompanyController = TextEditingController();
  final TextEditingController regiCompanyBranchController = TextEditingController();
  final TextEditingController regiCompanyTypeController = TextEditingController();
  final TextEditingController regiContactController = TextEditingController();
  final TextEditingController regiCarTypeController = TextEditingController();
  final TextEditingController regiCarNumController = TextEditingController();
  final TextEditingController regiTypeController = TextEditingController();
  final TextEditingController regiDateController = TextEditingController();
  final TextEditingController regiReserveDtController = TextEditingController();
  final TextEditingController regiReserveAtController = TextEditingController();
  final TextEditingController regiDAddressController = TextEditingController();
  final TextEditingController regiDContactController = TextEditingController();
  final TextEditingController regiAAddressController = TextEditingController();
  final TextEditingController regiAContactController = TextEditingController();
  final TextEditingController regiDepartTimeController = TextEditingController();
  final TextEditingController regiDepartKmController = TextEditingController();
  final TextEditingController regiArriveTimeController = TextEditingController();
  final TextEditingController regiArriveKmController = TextEditingController();
  final TextEditingController regiDetailController = TextEditingController();
  final TextEditingController regiPayController = TextEditingController();
  final TextEditingController regiPayTypeController = TextEditingController();
  final TextEditingController regiLevelController = TextEditingController();
  final TextEditingController regiPostDateController = TextEditingController();
  final TextEditingController regiDLatController = TextEditingController();
  final TextEditingController regiDLongController = TextEditingController();
  final TextEditingController regiALatController = TextEditingController();
  final TextEditingController regiALongController = TextEditingController();
  final TextEditingController regiDistanceController = TextEditingController();



  @override
  void onClose() {
    // Dispose controllers when the controller is closed to prevent memory leaks
    regiIdController.dispose();
    regiNameController.dispose();
    regiCompanyController.dispose();
    regiCompanyBranchController.dispose();
    regiCompanyTypeController.dispose();
    regiContactController.dispose();
    regiCarTypeController.dispose();
    regiCarNumController.dispose();
    regiTypeController.dispose();
    regiDateController.dispose();
    regiReserveDtController.dispose();
    regiReserveAtController.dispose();
    regiDAddressController.dispose();
    regiDContactController.dispose();
    regiAAddressController.dispose();
    regiAContactController.dispose();
    regiDepartTimeController.dispose();
    regiDepartKmController.dispose();
    regiArriveTimeController.dispose();
    regiArriveKmController.dispose();
    regiDetailController.dispose();
    regiPayController.dispose();
    regiPayTypeController.dispose();
    regiLevelController.dispose();
    regiPostDateController.dispose();
    regiDLatController.dispose();
    regiDLongController.dispose();
    regiALatController.dispose();
    regiALongController.dispose();

    focusNode.dispose();
    super.onClose();
  }

  Future<bool> addInfo() async {
    GetInfo addedInfo = GetInfo(
      regiId: 0,
      regiName: regiNameController.text,
      regiCompany: regiCompanyController.text,
      regiCompanyBranch: regiCompanyBranchController.text,
      regiCompanyType: regiCompanyTypeController.text,
      regiContact: regiContactController.text,
      regiCarType: regiCarNumController.text,
      regiCarNum: regiCarNumController.text,
      regiType: regiTypeController.text,
      regiDate: regiDateController.text,
      regiReserveDt: regiReserveDtController.text,
      regiReserveAt: regiReserveAtController.text,
      regiDAddress: regiDAddressController.text,
      regiDContact: regiDContactController.text,
      regiAAddress: regiAAddressController.text,
      regiAContact: regiAContactController.text,
      regiDepartTime: regiDepartTimeController.text,
      regiDepartKm: regiDepartKmController.text,
      regiArriveTime: regiArriveTimeController.text,
      regiArriveKm: regiArriveKmController.text,
      regiDetail: regiDetailController.text,
      regiPay: regiPayController.text,
      regiPayType: regiPayTypeController.text,
      regiLevel: "1",
      regiPostDate: '',
      regiDLat: regiDLat.toString() ,
      regiDLong: regiDLong.toString(),
      regiALat:regiALat.toString(),
      regiALong:regiALong.toString() ,
      regiDistance: regiDistance.toString(),
      userId: null,
    );

    // print(updatedInfo.toJson());
    bool addSuccess = await ServiceAdd().addList(addedInfo);
    Get.find<NotificationController>().getQue(regiDLat.toString(), regiDLong.toString());
    return addSuccess;
  }
  var isFocused = false.obs;
  var focusNode = FocusNode();
  var isFieldFocused = false.obs;
  var isAddressSelected = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
    // Set regiDate to today's date
    regiDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // Update the TextEditingController as well
    regiDateController.text = regiDate.value;
  }
}
