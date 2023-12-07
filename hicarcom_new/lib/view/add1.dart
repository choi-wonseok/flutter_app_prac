import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/addController.dart';
import '../controller/getinfoController.dart';


class Add extends StatelessWidget {
   Add({super.key});
   final addController = Get.put(AddController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('접수'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // buildTextField('regiId', addController.regiIdController),
              buildTextField('regiName', addController.regiNameController),
              buildTextField('regiCompany', addController.regiCompanyController),
              buildTextField('legiCompanyBranch', addController.regiCompanyBranchController),
              buildTextField('legiCompanyType', addController.regiCompanyTypeController),
              buildTextField('regiContact', addController.regiContactController),
              buildTextField('regiCarType', addController.regiCarTypeController),
              buildTextField('regiCarNum', addController.regiCarNumController),
              buildTextField('regiType', addController.regiTypeController),
              buildTextField('regiDate', addController.regiDateController),
              buildTextField('regiReserveDt', addController.regiReserveDtController),
              buildTextField('regiReserveAt', addController.regiReserveAtController),
              buildTextField('regiDAddress', addController.regiDAddressController),
              buildTextField('regiDContact', addController.regiDContactController),
              buildTextField('regiAAddress', addController.regiAAddressController),
              buildTextField('regiAContact', addController.regiAContactController),
              buildTextField('regiDepartTime', addController.regiDepartTimeController),
              buildTextField('regiDepartKm', addController.regiDepartKmController),
              buildTextField('regiArriveTime', addController.regiArriveTimeController),
              buildTextField('regiArriveKm', addController.regiArriveKmController),
              buildTextField('regiDetail', addController.regiDetailController),
              buildTextField('regiPay', addController.regiPayController),
              buildTextField('regiPayType', addController.regiPayTypeController),
              buildTextField('regiLevel', addController.regiLevelController),

              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }




  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
