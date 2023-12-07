import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../api/api.dart';
import '../model/getimage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class ImageUploadController extends GetxController {
  var imageList = <GetImage>[].obs;
  // String? baseUrl = dotenv.env['BASE_URL'];
  var images = <XFile>[].obs;
  final RxInt regiId = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Future<void> fetchImages(String regiId) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('API.getimage'),
  //       body: {'regi_id': regiId},
  //     );
  //
  //     debugPrint(response.statusCode.toString());
  //     if (response.statusCode == 200) {
  //       Checkimage checkImage = checkimageFromJson(response.body);
  //       if (checkImage.success) {
  //         imageList.addAll(checkImage.infoData); // GetImage 객체를 리스트에 추가
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   // update();
  // }

  Future<void> fetchImages(String regiId) async {
    try {
      final response = await http.post(
        Uri.parse(API.getimage),
        body: {'regi_id': regiId},
      );


      if (response.statusCode == 200) {

        Checkimage checkImage = checkimageFromJson(response.body);
        debugPrint(checkImage.toString());
        if (checkImage.success) {
          imageList.addAll(checkImage.infoData);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<void> addImage({required bool isCamera, required String regiId}) async {
    List<XFile>? galleryResultList;
    XFile? cameraResult;

    try {
      if (isCamera) {
        cameraResult = await ImagePicker().pickImage(source: ImageSource.camera);
        if (cameraResult != null) {
          images.add(cameraResult);
          await uploadImage(regiId);

        }
      } else {
        galleryResultList = await ImagePicker().pickMultiImage();
        if (galleryResultList != null) {
          images.addAll(galleryResultList);
          await uploadImage(regiId);
        }
      }
    } catch (e) {
      print(e);
    }
    clearImages();
    await fetchImages(regiId);
  }

  Future<void> uploadImage(String regiId) async {
    if (images.isEmpty) {
      return;
    }

    var uri = Uri.parse(API.imageupload);

    for (var image in images) {
      var request = http.MultipartRequest("POST", uri);
      request.fields['regi_id'] = regiId; //  regiId
      request.fields['imageName'] = image.name; // 파일 이름
      request.fields['imagePath'] = image.path; // 파일 경로

      var imageFile = await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      );

      request.files.add(imageFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        print("Image Uploaded");
      } else {
        print("Upload Failed");
      }
    }
  }
  // void removeImage(int index) {
  //   imageList.removeAt(index);
  // }

  Future<void> removeImage(int index) async {
    // 이미지 삭제를 위한 API URL
    var uri = Uri.parse(API.deleteimage);

    // 삭제할 이미지의 정보
    GetImage image = imageList[index];

    try {
      // 서버에 HTTP POST 요청을 보냅니다.
      final response = await http.post(
        uri,
        // 이미지 정보를 요청 본문에 포함시킵니다.
        body: {'regi_id' : image.regiId.toString(),
              'image_name': image.imageName,
        },
      );

      // 요청이 성공적으로 완료되면
      if (response.statusCode == 200) {
        debugPrint(response.body);
        // 이미지 리스트에서 이미지를 삭제합니다.
        imageList.removeAt(index);
        print("Image Deleted");
      } else {
        print("Deletion Failed");
      }
    } catch (e) {
      print(e);
    }
  }

  void clearImages() {
    imageList.clear();
    images.clear();
  }

}
