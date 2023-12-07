import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/locationController.dart';
import 'package:hicarcom/model/getinfo.dart';
import 'package:hicarcom/view/dialog.dart';
import 'package:hicarcom/view/update.dart';
import '../controller/navigationController.dart';

class MainListTile extends StatelessWidget {
  final GetInfo getinfo;
  final int index;
  final LocationController locationController = Get.find<LocationController>();

  MainListTile(this.getinfo, {required this.index});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        Get.dialog(
          DetailsDialog(getinfo: getinfo),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners for Material 3
        ),
        elevation: 1, // Optional: Adjust elevation as needed for Material 3 style
        child:Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  children: [
                    Text(
                      '$index',
                      style: TextStyle(fontSize: 10.0, color: Colors.grey),
                    ),
                    CircleAvatar(
                      radius: 20, // The radius is half the height and width to maintain the size
                      backgroundColor: colorScheme.primaryContainer,
                      foregroundColor: Colors.black, // Text color
                      child: Obx(() {
                        var distance = locationController.calculateDistance(getinfo.regiDLat, getinfo.regiDLong);
                        return Text(
                          '${distance.toStringAsFixed(1)} Km',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getinfo.regiDate,
                      style: TextStyle(fontSize: 11.5, color: Colors.grey),
                    ),
                    Text(
                      '${getinfo.regiReserveDt} ~${getinfo.regiReserveAt}',
                      style: TextStyle(fontSize: 11.0),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getinfo.regiName,
                      style: TextStyle(fontSize: 11.0),
                    ),
                    Text(
                      getinfo.regiType,
                      style: TextStyle(fontSize: 11.0, color: Colors.grey),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getinfo.regiCompany,
                      style: TextStyle(fontSize: 11.0, color: Colors.grey),
                    ),
                    Text(getinfo.regiCarNum,
                        style: TextStyle(
                          fontSize: 11.0,
                        )),
                  ],
                )
              ]),
              SizedBox(height: 2.0),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      '출발',
                      style: TextStyle(fontSize: 11.0, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 2.0),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 9,
                    child: Text(
                      getinfo.regiDAddress,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ), //출발지 주소
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      '도착',
                      style: TextStyle(fontSize: 11.0, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 2.0),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 9,
                    child: Text(
                      getinfo.regiAAddress,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0), // 도착지주소
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    getinfo.regiPayType,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(width: 10.0),
                  Text(getinfo.regiPay,
                      style: const TextStyle(
                          fontSize: 19, color: Colors.redAccent))
                ],
              )
            ],
            // 여기에 카드 내용을 추가하세요
          ),
        ),
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final GetInfo getinfo;
  final int index;
  final LocationController locationController = Get.find<LocationController>();

  MyListTile(this.getinfo, {required this.index});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: (){
        if(getinfo.regiLevel == "4"){
          Get.dialog(
            DetailsDialog(getinfo: getinfo),
          );
        }
        else{
          Get.to(() => Update(data: getinfo));
        }

      },
      child: Card(
        margin: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners for Material 3
        ),
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Text(
                  '${getinfo.regiId}',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(
                  getinfo.regiDate,
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '${getinfo.regiReserveDt} ~${getinfo.regiReserveAt}',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  getinfo.regiType,
                  style: TextStyle(fontSize: 13),
                ),
                  getinfo.regiLevel == "2"
                      ? Text("접수승인",style: TextStyle(fontSize: 11, color: Colors.grey),) : getinfo.regiLevel == "3"
                      ? Text("운행시작",style: TextStyle(fontSize: 11, color: Colors.grey)) : Text("운행완료",style: TextStyle(fontSize: 11, color: Colors.grey))

              ]),
              SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getinfo.regiName,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15,),
                  Text(getinfo.regiCarNum,
                      style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold
                      )),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      '출발',
                      style: TextStyle(fontSize: 11.0, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 2.0),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 9,
                    child: Text(
                      getinfo.regiDAddress,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0,),//출발지 주소
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      '도착',
                      style: TextStyle(fontSize: 11.0, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 2.0),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 9,
                    child: Text(
                      getinfo.regiAAddress,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0), // 도착지주소
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    getinfo.regiPayType,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(width: 10.0),
                  Text(getinfo.regiPay,
                      style:
                          const TextStyle(fontSize: 19, color: Colors.redAccent))
                ],
              )
            ],
            // 여기에 카드 내용을 추가하세요
          ),
        ),
      ),
    );
  }
}


