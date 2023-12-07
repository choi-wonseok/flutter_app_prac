import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controller/imageUploadController.dart';

class ImageUpload extends StatelessWidget {
  int data;
  final imageuploadcontroller = Get.put(ImageUploadController());

  ImageUpload({required this.data});

  @override
  Widget build(BuildContext context) {
    imageuploadcontroller.fetchImages(data.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('사진 첨부'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (imageuploadcontroller.imageList.isNotEmpty) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(
                        imageuploadcontroller.imageList.length,
                        (index) => Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(imageuploadcontroller
                                  .imageList[index].imageUrl!),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  imageuploadcontroller.removeImage(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo, size: 50),
                    Text("최대한 정확하게 찍어주세요"),
                  ],
                );
              }
            }),
            Container(
              width: double.infinity,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                        width: 2.0,
                        color: Colors.grey,
                        style: BorderStyle.solid),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => Wrap(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, top: 10.0),
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: Icon(Icons.close_rounded),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_camera),
                          title: Text('직접 촬영하기'),
                          onTap: () async {
                            await imageuploadcontroller.addImage(
                                isCamera: true, regiId: data.toString());

                            Get.back();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('사진첩에서 선택하기'),
                          onTap: () {
                            imageuploadcontroller.addImage(
                                isCamera: false, regiId: data.toString());
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo),
                      Text('올리기'),
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() => ElevatedButton(
                        onPressed: imageuploadcontroller.imageList.isNotEmpty
                            ? () {
                                Get.back();
                                imageuploadcontroller.clearImages();
                              }
                            : null,
                        child: Text("확인",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled))
                                return Colors.grey;
                              return Colors
                                  .blue; // Use the component's default.
                            },
                          ),
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
