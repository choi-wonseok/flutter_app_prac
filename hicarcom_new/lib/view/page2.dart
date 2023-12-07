import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/getinfoController.dart';
import 'package:hicarcom/controller/locationController.dart';
import 'package:intl/intl.dart';

import '../controller/numberController.dart';
import '../model/getinfo.dart';
import 'list_tile.dart';

class Page2 extends StatelessWidget {
  Page2({Key? key}) : super(key: key);
  final getinfoController = Get.put(GetInfoController());
  final mobileNumberController = Get.put(MobileNumberController());

  @override
  Widget build(BuildContext context) {
    final userinfolist = mobileNumberController.userinfolist;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Ensure Material 3 is being used
    print(userinfolist[0].userId.runtimeType);
    final theme = Theme.of(context);
    return FutureBuilder(
      future: getinfoController.fetchData("2", "4", 2, userinfolist[0].userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 로딩 중일 때
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 에러 발생 시
          return Center(child: Text('오류가 발생했습니다.'));
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed:(){
                        Get.defaultDialog(

                          title: '운행료 합계',
                          content: Obx(() =>
                              Column(
                                children: [
                                  Text('현금 합계: ${getinfoController.totalCash.value}'),
                                  Text('부가세 합계: ${getinfoController.totalValueAddedTax.value}'),
                                  Text('외상 합계: ${getinfoController.totalOutstandingBalance.value}'),
                                  Text('카드 합계: ${getinfoController.totalCard.value}'),
                                  Text('총 합계: ${getinfoController.totalRegiPay.value}'),
                                ],
                              ))
                        );
                      },
                      child: Text('내 운행',
                        style: TextStyle(
                        color: colorScheme.onSurface,
                      ),

                      ),

                    ),
                    Row(
                      children: [
                        Obx(
                              () => TextButton(
                            onPressed: () {
                              getinfoController.chooseDate(getinfoController.selectedDate3, "2", "4", 2,userinfolist[0].userId);
                            },
                            child: Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(getinfoController.selectedDate3.value)
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
                              getinfoController.chooseDate(getinfoController.selectedDate4, "2", "4", 2,userinfolist[0].userId);
                            },
                            child: Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(getinfoController.selectedDate4.value)
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
                  onChanged: (value) => getinfoController.searchGetInfo(value, "2", "4", 2,userinfolist[0].userId),
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
                          return MyListTile(
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
