import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/getinfoController.dart';
import 'package:hicarcom/data/service.dart';
import 'package:hicarcom/model/getinfo.dart';

class UpdateController extends GetxController {
  var searchResults = <String>[].obs;
  void searchAddress(String input) async {
    // TODO: 주소 검색 로직 구현
    // 임시로 더미 데이터를 사용하여 검색 결과 업데이트
    searchResults.value = ["주소 1", "주소 2", "주소 3"]; // 예시 결과
  }



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
  final RxInt userId = 0.obs;


  late TextEditingController regiIdController;
  late TextEditingController regiNameController;
  late TextEditingController regiCompanyController;
  late TextEditingController regiCompanyBranchController;
  late TextEditingController regiCompanyTypeController;
  late TextEditingController regiContactController;
  late TextEditingController regiCarTypeController;
  late TextEditingController regiCarNumController;
  late TextEditingController regiTypeController;
  late TextEditingController regiDateController;
  late TextEditingController regiReserveDtController;
  late TextEditingController regiReserveAtController;
  late TextEditingController regiDAddressController;
  late TextEditingController regiDContactController;
  late TextEditingController regiAAddressController;
  late TextEditingController regiAContactController;
  late TextEditingController regiDepartTimeController;
  late TextEditingController regiDepartKmController;
  late TextEditingController regiArriveTimeController;
  late TextEditingController regiArriveKmController;
  late TextEditingController regiDetailController;
  late TextEditingController regiPayController;
  late TextEditingController regiPayTypeController;
  late TextEditingController regiLevelController;
  late TextEditingController regiPostDateController;
  late TextEditingController regiDLatController;
  late TextEditingController regiDLongController;
  late TextEditingController regiALatController;
  late TextEditingController regiALongController;
  late TextEditingController regiDistanceController;
  late TextEditingController userIdController;


  @override
  void onClose() {
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
    userIdController.dispose();
    focusNode.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  void initData(GetInfo data) {
    regiName.value = data.regiName;
    regiId.value = data.regiId;
    regiCompany.value = data.regiCompany;
    regiCompanyBranch.value = data.regiCompanyBranch ?? '';
    regiCompanyType.value = data.regiCompanyType ?? '';
    regiContact.value = data.regiContact ?? '';
    regiCarType.value = data.regiCarType;
    regiCarNum.value = data.regiCarNum;
    regiType.value = data.regiType;
    regiDate.value = data.regiDate;
    regiReserveDt.value = data.regiReserveDt;
    regiReserveAt.value = data.regiReserveAt;
    regiDAddress.value = data.regiDAddress;
    regiDContact.value = data.regiDContact ?? '';
    regiAAddress.value = data.regiAAddress;
    regiAContact.value = data.regiAContact ?? '';
    regiDepartTime.value = data.regiDepartTime;
    regiDepartKm.value = data.regiDepartKm;
    regiArriveTime.value = data.regiArriveTime;
    regiArriveKm.value = data.regiArriveKm;
    regiDetail.value = data.regiDetail ?? '';
    regiPay.value = data.regiPay;
    regiPayType.value = data.regiPayType;
    regiLevel.value = data.regiLevel;
    regiPostDate.value = data.regiPostDate;
    regiDLat.value = data.regiDLat;
    regiDLong.value = data.regiDLong;
    regiALat.value = data.regiALat;
    regiALong.value = data.regiALong;
    regiDistance.value = data.regiDistance;
    userId.value = data.userId!;

    regiIdController = TextEditingController(text: data.regiId.toString());
    regiNameController = TextEditingController(text: data.regiName);
    regiCompanyController = TextEditingController(text: data.regiCompany);
    regiCompanyBranchController = TextEditingController(text: data.regiCompanyBranch);
    regiCompanyTypeController = TextEditingController(text: data.regiCompanyType);
    regiContactController = TextEditingController(text: data.regiContact);
    regiCarTypeController = TextEditingController(text: data.regiCarType);
    regiCarNumController = TextEditingController(text: data.regiCarNum);
    regiTypeController = TextEditingController(text: data.regiType);
    regiDateController = TextEditingController(text: data.regiDate);
    regiReserveDtController = TextEditingController(text: data.regiReserveDt);
    regiReserveAtController = TextEditingController(text: data.regiReserveAt);
    regiDAddressController = TextEditingController(text: data.regiDAddress);
    regiDContactController = TextEditingController(text: data.regiDContact);
    regiAAddressController = TextEditingController(text: data.regiAAddress);
    regiAContactController = TextEditingController(text: data.regiAContact);
    regiDepartTimeController = TextEditingController(text: data.regiDepartTime);
    regiDepartKmController = TextEditingController(text: data.regiDepartKm);
    regiArriveTimeController = TextEditingController(text: data.regiArriveTime);
    regiArriveKmController = TextEditingController(text: data.regiArriveKm);
    regiDetailController = TextEditingController(text: data.regiDetail);
    regiPayController = TextEditingController(text: data.regiPay);
    regiPayTypeController = TextEditingController(text: data.regiPayType);
    regiLevelController = TextEditingController(text: data.regiLevel);
    regiPostDateController = TextEditingController(text: data.regiPostDate);
    regiDLatController = TextEditingController(text: data.regiDLat);
    regiDLongController = TextEditingController(text: data.regiDLong);
    regiALatController = TextEditingController(text: data.regiALat);
    regiALongController = TextEditingController(text: data.regiALong);
    regiDistanceController = TextEditingController(text: data.regiDistance);
    userIdController = TextEditingController(text: data.userId!.toString());

  }
  Future<bool> updateInfo() async {
    if (regiDepartTime.value.isNotEmpty && regiDepartKm.value.isNotEmpty) {
      regiLevel.value = "3";
      print("데이터 업데이트: 레벨을 3으로 변경합니다.");
    }

    if (regiDepartTime.value.isNotEmpty && regiDepartKm.value.isNotEmpty &&
        regiArriveTime.value.isNotEmpty && regiArriveKm.value.isNotEmpty) {
      regiLevel.value = "4";
      print("데이터 업데이트: 레벨을 4로 변경합니다.");
    }
    GetInfo updatedInfo = GetInfo(
      regiId: regiId.value,
      regiName: regiName.value,
      regiCompany: regiCompany.value,
      regiCompanyBranch: regiCompanyBranch.value,
      regiCompanyType: regiCompanyType.value,
      regiContact: regiContact.value,
      regiCarType: regiCarType.value,
      regiCarNum: regiCarNum.value,
      regiType: regiType.value,
      regiDate: regiDate.value,
      regiReserveDt: regiReserveDt.value,
      regiReserveAt: regiReserveAt.value,
      regiDAddress: regiDAddress.value,
      regiDContact: regiDContact.value,
      regiAAddress: regiAAddress.value,
      regiAContact: regiAContact.value,
      regiDepartTime: regiDepartTime.value,
      regiDepartKm: regiDepartKm.value,
      regiArriveTime: regiArriveTime.value,
      regiArriveKm: regiArriveKm.value,
      regiDetail: regiDetail.value,
      regiPay: regiPay.value,
      regiPayType: regiPayType.value,
      regiLevel: regiLevel.value,
      regiPostDate: regiPostDate.value,
      regiDLat: regiDLat.value,
      regiDLong: regiDLong.value,
      regiALat: regiALat.value,
      regiALong: regiALong.value,
      regiDistance: regiDistance.value,
      userId: userId.value

    );
    // print(updatedInfo.toJson());
    bool updateSuccess = await ServiceUpdate().updateList(updatedInfo);
    return updateSuccess;
  }



  Future<bool> takeJob(String type1, int? userId) async {
   bool updateJobSuccess = await ServiceJobUpdate().updateJob(type1, userId);
   return updateJobSuccess;
  }

  var isFocused = false.obs;
  var isAddressSelected = false.obs;

  var isFieldFocused = false.obs;

  // FocusNode 인스턴스를 생성합니다.
  var focusNode = FocusNode();


  @override
  void onInit() {
    super.onInit();
    // 포커스 리스너를 추가합니다.
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
  }
}


