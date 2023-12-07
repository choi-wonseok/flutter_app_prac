// import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
// import 'package:get/get.dart';
//
// import '../controller/nMapController.dart';
//
// class PathMap extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final nmapController = Get.find<NMapController>();
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Obx(() => NaverMap(
//             options: NaverMapViewOptions(
//               initialCameraPosition: NCameraPosition(
//                 target: nmapController.selectedPosition.value,
//                 zoom: 16.0,
//               ),
//               zoomGesturesEnable: true,
//               indoorEnable: false,
//               locationButtonEnable: true,
//               consumeSymbolTapEvents: false,
//             ),
//             onMapReady: (controller) async {
//               nmapController.onMapCreated(controller);
//               // 경로 그리기
//               if (nmapController.startlocation != null && nmapController.endlocation != null) {
//                 nmapController.drawPath(nmapController.startlocation!, nmapController.endlocation!);
//               }
//             },
//             // onCameraIdle: () => nmapController.onCameraIdle(),
//           )),
//           Positioned(
//             top: 30, // 버튼의 상단 위치 조절
//             left: 10, // 버튼의 좌측 위치 조절
//             child: FloatingActionButton(
//               child: Icon(Icons.arrow_back, size: 20,),
//               backgroundColor: Colors.blue,
//               mini: true,
//               onPressed: () {
//                 Get.back();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
