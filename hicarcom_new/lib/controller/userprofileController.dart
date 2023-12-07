import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../api/api.dart';
import '../model/getimage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class UserProfileController extends GetxController {
  // String? baseUrl = dotenv.env['BASE_URL'];
  XFile? image;
  final RxString profile = ''.obs;
  final RxString userProfile = ''.obs;
  final userId1 = ''.obs;

  @override
  void onInit() {
    ever(userId1, (_) => fetchUserProfile(userId1.value));
    super.onInit();

  }

  Future<void> fetchUserProfile(String userId) async {

    print(userId);
    try {
      final response = await http.post(
        Uri.parse(API.getuserprofile),
        body: {'user_id': userId}, // userId가 문자열이어야 함을 확인하세요
      );

      if (response.statusCode == 200) {
        // JSON을 직접 파싱합니다.
        print(response.body);
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // 요청이 성공했는지 확인합니다.
        if (jsonResponse['success']) {
          // 이미지 URL이 'image_url'에 직접 반환된다고 가정합니다.
          String imageUrl = jsonResponse['infoData'][0]['image_url'];
          String imageName = jsonResponse['infoData'][0]['user_profile'];

          // 이미지 값을 업데이트합니다.
          profile.value = imageUrl;
          userProfile.value = imageName;
          print("profile.value" + profile.value);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addImage({required int chooseNum, required String userId}) async {
    XFile? result;

    try {
      if (chooseNum == 1) {
        result = await ImagePicker().pickImage(source: ImageSource.camera);
        if (result != null) {
          image = result;
          await uploadImage(userId);

        }
      } else if (chooseNum == 2){
        result = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (result != null) {
          image = result;
          await uploadImage(userId);
        }
      } else{
        removeImage(userId);
      }
    } catch (e) {
      print(e);
    }
    clearImage();
    await fetchUserProfile(userId);
  }

  Future<void> uploadImage(String userId) async {
    if (image == null) {
      print("null");
      return;
    }

    var uri = Uri.parse(API.updateprofile);

    var request = http.MultipartRequest("POST", uri);
    request.fields['user_id'] = userId; // regiId
    request.fields['user_profile'] = image!.name; // 파일 이름// 파일 경로

    var imageFile = await http.MultipartFile.fromPath(
      'image',
      image!.path,
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

  Future<void> removeImage(String userId) async {
    if (profile.value == '') {
      print("null");
      return;
    }
    print("null 아님");

    // 이미지 삭제를 위한 API URL
    var uri = Uri.parse(API.deleteprofile);

    try {
      // 서버에 HTTP POST 요청을 보냅니다.
      final response = await http.post(
        uri,
        // 이미지 정보를 요청 본문에 포함시킵니다.
        body: {
          'user_id': userId,
        },
      );

      // 요청이 성공적으로 완료되면
      if (response.statusCode == 200) {
        debugPrint(response.body);
        image = null; // 이미지 삭제
        print("Image Deleted");
      } else {
        print("Deletion Failed");
      }
    } catch (e) {
      print(e);
    }
    clearImage();
    await fetchUserProfile(userId);
  }

  void clearImage() {
    image = null;
  }
  void updateUserId(String newUserId) {
    userId1.value = newUserId;
  }

}
