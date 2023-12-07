import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimePickerController extends GetxController {
  var pickedDate = DateTime.now().obs;

  void updatePickedDate(DateTime newDate) {
    pickedDate.value = newDate;
  }
  Future<void> chooseDate(Function(String) updateRxString) async {
    await Get.dialog(
      AlertDialog(
        title: Text('날짜 선택', style: Get.textTheme.titleMedium),
        content: Container(
          height: 400,
          width: 300, // Update the width to fit Material 3 design if needed
          child: Column(
            children: [
              Expanded(
                child: CalendarDatePicker(
                  initialDate: pickedDate.value,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2040),
                  onDateChanged: (DateTime newDate) {
                    updateRxString(DateFormat('yyyy-MM-dd').format(newDate)); // Use your desired date format.
                    Get.back();
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  updateRxString(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                  Get.back();
                },
                child: Text('오늘', style: Get.textTheme.labelLarge),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
