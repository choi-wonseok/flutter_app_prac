// update.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/addressSearchController.dart';
import 'package:hicarcom/controller/datetimePickerController.dart';
import 'package:hicarcom/controller/getinfoController.dart';
import 'package:hicarcom/controller/phoneNumberController.dart';
import 'package:hicarcom/controller/updateController.dart';
import 'package:hicarcom/model/getinfo.dart';
import 'package:hicarcom/view/dialog.dart';
import 'package:hicarcom/view/imageUpload.dart';

import '../controller/numberController.dart';

class Update extends StatelessWidget {
  final GetInfo data;
  Update({required this.data});
  final updateController = Get.put(UpdateController());
  final addressController = Get.put(AddressController());
  final dateTimePickerController = Get.put(DateTimePickerController());
  final mobileNumberController = Get.put(MobileNumberController());





  @override
  Widget build(BuildContext context) {
    updateController.initData(data);
    final userinfolist = mobileNumberController.userinfolist;

    return Scaffold(
      appBar: AppBar(
        title: Text('운행정보 수정'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              dateTextFields(context, '일자', updateController.regiDateController, updateController.regiDate),
              Row(
                children: [
                  Expanded(child: timePickerTextField(context, '예약출발시간', updateController.regiReserveDtController, updateController.regiReserveDt)),
                  SizedBox(width: 5,),
                  Expanded(child: timePickerTextField(context, '예약도착시간', updateController.regiReserveAtController, updateController.regiReserveAt),),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: companyTextField(context, '회원구분', updateController.regiCompanyTypeController, updateController.regiCompanyType)),
                  SizedBox(width: 5),
                  Expanded(child: selectTextField(context, '운행구분', updateController.regiTypeController, updateController.regiType)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: companyTextField(context, '회사이름', updateController.regiCompanyController, updateController.regiCompany)),
                  SizedBox(width: 5),
                  Expanded(child: companyTextField(context, '지점명', updateController.regiCompanyBranchController, updateController.regiCompanyBranch)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: companyTextField(context, '의뢰자 성함', updateController.regiNameController, updateController.regiName),),
                  SizedBox(width: 5),
                  Expanded(child: companyTextField(context, '의뢰자 연락처', updateController.regiContactController, updateController.regiContact),),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: buildTextFieldWithObx(context, '차종', updateController.regiCarTypeController, updateController.regiCarType, false)),
                  SizedBox(width: 5),
                  Expanded(child: buildTextFieldWithObx(context, '차량번호', updateController.regiCarNumController, updateController.regiCarNum, false)),
                ],
              ),
              SizedBox(height: 10),
              addressTextField(context, '출발지 주소', updateController.regiDAddressController, updateController.regiDAddress, true),
              phoneNumverField(context, '출발지 연락처', updateController.regiDContactController, updateController.regiDContact,),
              addressTextField(context, '도착지 주소', updateController.regiAAddressController, updateController.regiAAddress, false),
              phoneNumverField(context, '도착지 연락처', updateController.regiAContactController, updateController.regiAContact),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: timePickerTextField(context, '출발 시간', updateController.regiDepartTimeController, updateController.regiDepartTime)),
                  SizedBox(width: 5),
                  Expanded(child: timePickerTextField(context, '도착 시간', updateController.regiArriveTimeController, updateController.regiArriveTime)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: buildTextFieldWithObx(context, '출발 Km', updateController.regiDepartKmController, updateController.regiDepartKm, true),),
                  SizedBox(width: 5),
                  Expanded(child: buildTextFieldWithObx(context, '도착 Km', updateController.regiArriveKmController, updateController.regiArriveKm, true),),
                ],
              ),
              buildTextFieldWithObx(context, '상세 정보', updateController.regiDetailController, updateController.regiDetail, false),
              Row(
                children: [
                  Expanded(child: selectTextField(context, '결제 유형', updateController.regiPayTypeController, updateController.regiPayType),),
                  SizedBox(width: 5),
                  Expanded(child: buildTextFieldWithObx(context, '결제 금액', updateController.regiPayController, updateController.regiPay, true),),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(()=> ImageUpload(data:data.regiId));
                },
                child: Text('사진보기 및 추가'),
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
                    onPressed: () async {
                      if (updateController.regiDepartTime.value.isNotEmpty && updateController.regiDepartKm.value.isNotEmpty) {
                        if (updateController.regiDepartTime.value.isNotEmpty && updateController.regiDepartKm.value.isNotEmpty &&
                            updateController.regiArriveTime.value.isNotEmpty && updateController.regiArriveKm.value.isNotEmpty)
                        {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(Icons.drive_eta_outlined),
                                    Text("   운행완료",style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text("운행을 완료하시겠습니까?",style: TextStyle(fontSize: 18),),
                                      Text("완료후에는 수정이 불가능합니다!",style: TextStyle(fontSize: 18),),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("취소"),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("확인"),
                                    onPressed: () async {
                                      Get.back();
                                      bool success = await updateController.updateInfo();
                                      if (success) {
                                        // After successful update, refresh data and close the page
                                        Get.find<GetInfoController>().fetchData("2", "4", 2,userinfolist[0].userId); // Refresh data
                                        Get.back();// Close the current page
                                      } else {
                                        // Handle the failure of the update operation, maybe show an error message
                                        Get.snackbar('Error', 'Update failed'); // This is just an example
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }else{
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:  Row(
                                  children: [
                                    Icon(Icons.drive_eta_outlined),
                                    Text("   운행시작",style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                                content: Text("운행을 시작하시겠습니까?",style: TextStyle(fontSize: 18),),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("취소"),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("확인"),
                                    onPressed: () async {
                                      Get.back();
                                      bool success = await updateController.updateInfo();
                                      if (success) {
                                        // After successful update, refresh data and close the page
                                        Get.find<GetInfoController>().fetchData("2", "4", 2,userinfolist[0].userId); // Refresh data
                                        Get.back(); // Close the current page
                                      } else {
                                        // Handle the failure of the update operation, maybe show an error message
                                        Get.snackbar('Error', 'Update failed'); // This is just an example
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                      else if (updateController.regiArriveTime.value.isNotEmpty && updateController.regiArriveKm.value.isNotEmpty){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('출발 시간 및 키로수도 입력해 주세요.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("확인"),
                                  onPressed: () {
                                    Get.back();
                                  }
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else{
                        bool success = await updateController.updateInfo();
                        if (success) {
                          // After successful update, refresh data and close the page
                          Get.find<GetInfoController>().fetchData("2", "4", 2,userinfolist[0].userId); // Refresh data
                          Get.back(); // Close the current page
                        } else {
                          // Handle the failure of the update operation, maybe show an error message
                          Get.snackbar('Error', 'Update failed'); // This is just an example
                        }
                      }
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


  Widget buildTextFieldWithObx(BuildContext context, String labelText, TextEditingController controller, RxString rxString, bool isNumeric) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Obx(() {
      controller.text = rxString.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 1, // 원하는 elevation 값을 설정하세요.
          borderRadius: BorderRadius.circular(4.0), // 원하는 border radius를 설정하세요.
          child: TextFormField(
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text, // Set keyboard type based on isNumeric
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline), // Material 3 typically uses rounded corners
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: colorScheme.onSurfaceVariant, // Use colorScheme for Material 3 colors
              ),
              // Apply other Material 3 styling as needed
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: colorScheme.primary),
              ),
              // If using filled text fields
              filled: true,
              fillColor: colorScheme.surfaceVariant,
              // If you want to use elevation, consider wrapping with Material widget and use `elevation` property
            ),
            controller: controller,
            onChanged: (newValue) {
              rxString.value = newValue;
            },
          ),
        ),
      );
    });
  }


  Widget phoneNumverField(BuildContext context, String labelText, TextEditingController controller, RxString rxString) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Obx(() {
      controller.text = rxString.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 1, // 원하는 elevation 값을 설정하세요.
          borderRadius: BorderRadius.circular(4.0), // 원하는 border radius를 설정하세요.
          child: TextFormField(
            inputFormatters: [NumberFormatter()],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline), // Material 3 typically uses rounded corners
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: colorScheme.onSurfaceVariant, // Use colorScheme for Material 3 colors
              ),
              // Apply other Material 3 styling as needed
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: colorScheme.primary),
              ),
              // If using filled text fields
              filled: true,
              fillColor: colorScheme.surfaceVariant,
              // If you want to use elevation, consider wrapping with Material widget and use `elevation` property
            ),
            controller: controller,
            onChanged: (newValue) {
              rxString.value = newValue;
            },
          ),
        ),
      );
    });
  }

  Widget addressTextField(BuildContext context, String labelText, TextEditingController controller, RxString rxString, bool isDeparture) {
    return Obx(() {
      controller.text = rxString.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 1, // 원하는 elevation 값을 설정하세요.
          child: TextFormField(
            showCursor: false,
            keyboardType: TextInputType.none,
            readOnly: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(),
              labelText: labelText,
            ),
            controller: controller,
            onTap: () {
              Get.dialog(
                WillPopScope(
                  onWillPop: () async {
                    addressController.searchTextController.clear();
                    addressController.searchDetailController.clear();
                    addressController.searchlongController.clear();
                    addressController.searchlatController.clear();
                    return true; // 다이얼로그 닫기 허용
                  },
                  child: AddressDialog(
                    addressController: Get.find<AddressController>(),
                    addressRxString: rxString,
                    isadd: false,
                    isDeparture: isDeparture,
                  ),
                ),
                barrierDismissible: false,
              );
            },
            onChanged: (newValue) {
              rxString.value = newValue;
            },
          ),
        ),
      );
    });
  }

  Widget dateTextFields(BuildContext context, String labelText, TextEditingController controller, RxString rxString) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Obx(() {
      controller.text = rxString.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 1, // 원하는 elevation 값을 설정하세요.
          borderRadius: BorderRadius.circular(4.0), // 원하는 border radius를 설정하세요.
          child: TextFormField(
            readOnly: true,
            showCursor: false,
            keyboardType: TextInputType.none,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline), // Material 3 typically uses rounded corners
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: colorScheme.onSurfaceVariant, // Use colorScheme for Material 3 colors
              ),
              // Apply other Material 3 styling as needed
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: colorScheme.primary),
              ),
              // If using filled text fields
              filled: true,
              fillColor: colorScheme.surfaceVariant,
              // If you want to use elevation, consider wrapping with Material widget and use `elevation` property
            ),
            controller: controller,
            onTap: (){
              dateTimePickerController.chooseDate((selectedDate) {
                rxString.value = selectedDate;
                controller.text = selectedDate; // Update the controller's text here.
              });
            }
          ),
        ),
      );
    });
  }

  Widget companyTextField(BuildContext context, String labelText, TextEditingController controller, RxString rxString) {
    return Obx(() {
      ColorScheme colorScheme = Theme.of(context).colorScheme;
      controller.text = rxString.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 1, // 원하는 elevation 값을 설정하세요.
          borderRadius: BorderRadius.circular(4.0), // 원하는 border radius를 설정하세요.
          child: TextFormField(
            readOnly: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
            keyboardType: TextInputType.none,
            showCursor: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline), // Material 3 typically uses rounded corners
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: colorScheme.onSurfaceVariant, // Use colorScheme for Material 3 colors
              ),
              // Apply other Material 3 styling as needed
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: colorScheme.primary),
              ),
              // If using filled text fields
              filled: true,
              fillColor: colorScheme.surfaceVariant,
              // If you want to use elevation, consider wrapping with Material widget and use `elevation` property
            ),
            controller: controller,
            onTap: () => openSearchDialog(context),
            onChanged: (newValue) {
              rxString.value = newValue;
            },
          ),
        ),
      );
    });
  }

  void openSearchDialog(BuildContext context) {
    Get.dialog(
        SearchCompanyDialog(
          onSelect: (selectedInfo) {
            // Update all fields with the selected company's information
            updateController.regiCompanyController.text = selectedInfo.companyName;
            updateController.regiCompanyBranchController.text = selectedInfo.branchName;
            updateController.regiNameController.text = selectedInfo.userName;
            updateController.regiContactController.text = selectedInfo.phoneNumber;
            updateController.regiCompanyTypeController.text = selectedInfo.companyType;
            // Update the RxStrings as well
            updateController.regiCompany.value = selectedInfo.companyName;
            updateController.regiCompanyBranch.value = selectedInfo.branchName;
            updateController.regiName.value = selectedInfo.userName;
            updateController.regiContact.value = selectedInfo.phoneNumber;
            updateController.regiCompanyType.value = selectedInfo.companyType;
          },
        )); // 여기에서 다이얼로그를 열어줍니다.
  }

  Widget selectTextField(BuildContext context, String labelText, TextEditingController controller, RxString rxString) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Obx(() {
      controller.text = rxString.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 1, // 원하는 elevation 값을 설정하세요.
          borderRadius: BorderRadius.circular(4.0), // 원하는 border radius를 설정하세요.
          child: TextFormField(
            keyboardType: TextInputType.none,
            showCursor: false,
            readOnly: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline), // Material 3 typically uses rounded corners
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: colorScheme.onSurfaceVariant, // Use colorScheme for Material 3 colors
              ),
              // Apply other Material 3 styling as needed
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: colorScheme.primary),
              ),
              // If using filled text fields
              filled: true,
              fillColor: colorScheme.surfaceVariant,
              // If you want to use elevation, consider wrapping with Material widget and use `elevation` property
            ),
            controller: controller,
            onTap: () {
              showModal(context, rxString, labelText); // Pass labelText to showModal
            },
            onChanged: (newValue) {
              rxString.value = newValue;
            },
          ),
        ),
      );
    });
  }

  Widget timePickerTextField(BuildContext context, String labelText, TextEditingController controller, RxString rxString) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Obx(() {
      controller.text = rxString.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          elevation: 1, // 원하는 elevation 값을 설정하세요.
          borderRadius: BorderRadius.circular(4.0), // 원하는 border radius를 설정하세요.
          child: TextFormField(
            readOnly: true, // Make the text field read-only
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline), // Material 3 typically uses rounded corners
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: colorScheme.onSurfaceVariant, // Use colorScheme for Material 3 colors
              ),
              // Apply other Material 3 styling as needed
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: colorScheme.primary),
              ),
              // If using filled text fields
              filled: true,
              fillColor: colorScheme.surfaceVariant,
              // If you want to use elevation, consider wrapping with Material widget and use `elevation` property
            ),
            controller: controller,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                // Optional: Apply Material 3 styling to the time picker
              );

              if (pickedTime != null) {
                String formattedTime = "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
                controller.text = formattedTime;
                rxString.value = formattedTime;
              }
            },
          ),
        ),
      );
    });
  }
}

void showModal(BuildContext context, RxString rxString, String labelText) {
  List<String> options = getOptionsForLabel(labelText); // Get options based on labelText
  ThemeData theme = Theme.of(context);

  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // Material 3 surface color
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Rounded top corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Wrap(
        children: options.map((String option) {
          return ListTile(
            title: Text(
              option,
              style: TextStyle(color: theme.colorScheme.onSurface), // Text color based on Material 3
            ),
            onTap: () {
              rxString.value = option;
              Get.back(); // Close the modal bottom sheet using GetX
            },
          );
        }).toList(),
      ),
    ),
    barrierColor: Colors.black54, // Optional: background color when modal is open
    isScrollControlled: true, // Optional: for full screen modal
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Rounded top corners for modal
    ),
    backgroundColor: Colors.transparent, // Make the modal background transparent
  );
}

List<String> getOptionsForLabel(String labelText) {
  switch (labelText) {
    case "회원구분":
      return ["협력업체", "일반업체", "기타"];
    case "운행구분":
      return ["차량탁송", "일일기사", "대리운전", "어부바"];
    case "결제 유형":
      return ["현금", "부가세", "외상", "카드"];
    default:
      return [];
  }
}

