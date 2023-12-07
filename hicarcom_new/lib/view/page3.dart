import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => Add());
        },
        child: Text("접수하기"),
      ),
    );
  }
}
