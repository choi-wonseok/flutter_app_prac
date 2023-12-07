import 'dart:convert';

Checkimage checkimageFromJson(String str) => Checkimage.fromJson(json.decode(str));

String checkimageToJson(Checkimage data) => json.encode(data.toJson());

class GetImage {
  String imageName; // imageUrl을 imageName으로 변경
  String imagePath;
  int regiId; // imageId를 regiId로 변경
  String? imageUrl; // 추가된 필드

  GetImage(this.imageName, this.imagePath, this.regiId, this.imageUrl); // 생성자에 imageUrl 추가

  factory GetImage.fromJson(Map<String, dynamic> json) {
    return GetImage(
        json['image_name'] as String? ?? '',
        json['image_path'] as String? ?? '',
        json['regi_id'] != null ? int.parse(json['regi_id'].toString()) : 0,
        json['image_url'] as String? ?? ''
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'image_name': imageName, // image_url을 image_name으로 변경
      'image_path' : imagePath,
      'regi_id' : regiId.toString(), // image_id를 regi_id로 변경
      'image_url' : imageUrl // imageUrl 추가
    };
  }
}


class Checkimage {
  bool success;
  List<GetImage> infoData;

  Checkimage({
    required this.success,
    required this.infoData,
  });

  factory Checkimage.fromJson(Map<String, dynamic> json) => Checkimage(
      success: json["success"],
      infoData: List<GetImage>.from(json["infoData"].map((x) => GetImage.fromJson(x as Map<String, dynamic>)))
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "infoData": List<dynamic>.from(infoData.map((x) => x.toJson())),
  };
}
