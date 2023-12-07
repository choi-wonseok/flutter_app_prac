import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/getinfoController.dart';
import 'package:hicarcom/controller/locationController.dart';
import 'package:intl/intl.dart';

import '../controller/navigationController.dart';
import 'package:hicarcom/controller/numberController.dart';
import '../model/getinfo.dart';
import 'list_tile.dart';

class Page1 extends StatelessWidget {
  Page1({Key? key}) : super(key: key);

  final getinfoController = Get.put(GetInfoController());



  @override
  Widget build(BuildContext context) {

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Ensure Material 3 is being used
    final theme = Theme.of(context);
    return FutureBuilder(
      future: getinfoController.fetchData("1", "1", 1, null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 로딩 중일 때
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 에러 발생 시
          return Center(child: Text('오류가 발생했습니다.'));
        } else {
          // 데이터가 있을 때
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '접수요청',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                        )
                    ),
                    Row(
                      children: [
                        Obx(
                              () => TextButton(
                            onPressed: () {
                              getinfoController.chooseDate(getinfoController.selectedDate1, "1", "1", 1,null);
                            },
                            child: Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(getinfoController.selectedDate1.value)
                                  .toString(),
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ),
                        Text(
                          "~",
                          style: theme.textTheme.titleMedium,
                        ),
                        Obx(
                              () => TextButton(
                            onPressed: () {
                              getinfoController.chooseDate(getinfoController.selectedDate2, "1", "1", 1,null);
                            },
                            child: Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(getinfoController.selectedDate2.value)
                                  .toString(),
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Assuming SearchBar is a custom widget, it should also be updated to Material 3 style
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: SearchBar(
                  onChanged: (value) => getinfoController.searchGetInfo(value, "1", "1", 1,null),
                  hintText: 'Search...',
                  leading: Icon(Icons.search, color: theme.colorScheme.onSurface),
                ),
              ),
              Expanded(
                child: GetX<GetInfoController>(
                  builder: (controller) {
                    if (controller.getinfoSearch.isEmpty) {
                      // 리스트가 비어 있을 때 표시할 위젯
                      return Center(
                        child: Text(
                          "접수된 운행이 없습니다.",
                          style: TextStyle(
                            color: colorScheme.onSurface, // 테마에 맞는 색상 사용
                            fontSize: 16, // 원하는 글꼴 크기로 조정
                          ),
                        ),
                      );
                    } else {
                      // 리스트에 아이템이 있을 때 리스트 빌드
                      return ListView.builder(
                        itemCount: controller.getinfoSearch.length,
                        itemBuilder: (context, index) {
                          int reverseIndex = controller.getinfoSearch.length - 1 - index;
                          GetInfo getinfo = controller.getinfoSearch[reverseIndex];
                          return MainListTile(
                            getinfo,
                            index: reverseIndex + 1,
                            // Update MainListTile if necessary to match Material 3
                          );
                        },
                      );
                    }
                  },
                ),
              ),

            ],
          );
        }
      },
    );


  }
}