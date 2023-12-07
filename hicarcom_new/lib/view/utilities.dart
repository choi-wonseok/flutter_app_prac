
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/addressSearchController.dart';
import 'package:hicarcom/model/address.dart';
import 'package:hicarcom/model/address1.dart';
import 'package:hicarcom/controller/datetimePickerController.dart';

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const InfoColumn({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 11.0,
              color: Colors.grey
          ),
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 11.5
          ),
        ),
      ],
    );
  }
}

class InfoSection extends StatelessWidget {
  final String title;
  final String value;

  const InfoSection({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 11.0,
                color: Colors.grey
            ),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 11.5
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentSection extends StatelessWidget {
  final String type;
  final String amount;

  const PaymentSection({Key? key, required this.type, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text(
            type,
            style: const TextStyle(
                fontSize: 15.0,
                color: Colors.grey
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}


final AddressController controller = Get.find<AddressController>();

// Widget searchTextField() {
//   return Container(
//     color: Colors.white,
//     padding: EdgeInsets.symmetric(horizontal: 20),
//     height: 50,
//     alignment: Alignment.center,
//     child: TextField(
//       controller: controller.searchTec,
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         hintText: "주소 입력",
//         hintStyle: TextStyle(color: Color(0xFFA0A0A0)),
//       ),
//       onChanged: (value) => controller.fetchAddress(value, controller.page.value),
//     ),
//   );
// }

// Widget addressListView() {
//   return Obx(() => controller.addressList.isEmpty
//       ? Center(child: Text(controller.errorMessage.value))
//       : ListView.builder(
//     controller: controller.scrollController,
//     itemCount: controller.addressList.length,
//     itemBuilder: (context, index) {
//       final address = controller.addressList[index];
//       return AddressListItem(address: address);
//     },
//   ));
// }
// class TopBar extends StatelessWidget {
//   const TopBar({Key? key,
//
//     required this.title,
//     required this.onTap,
//     required this.closeIcon,
//     this.height = 60,
//   }) : super(key: key);
//
//   final String title;
//   final Function onTap;
//   final Icon closeIcon;
//   final double height;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: double.infinity,
//       child: Stack(
//         children: <Widget>[
//           titleWidget(),
//           closeWidget(context),
//         ],
//       ),
//     );
//   }
//
//   Widget titleWidget() {
//     return Container(
//       alignment: Alignment.center,
//       color: Colors.white,
//       height: height,
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 17,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
//
//   Widget closeWidget(BuildContext context) {
//     return SizedBox(
//       height: height,
//       width: height,
//       child: Material(
//         color: Colors.white,
//         child: InkWell(
//           splashColor: Color(0xFF757575),
//           onTap: (){},
//           child: Container(
//             margin: EdgeInsets.only(left: 10),
//             alignment: Alignment.centerLeft,
//             child: closeIcon == null ? Icon(Icons.close) : closeIcon,
//           ),
//         ),
//       ),
//     );
//   }
// }


class AddressListItem extends StatelessWidget {
  final Juso1 address;

  const AddressListItem({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final roadLast = address.buldSlno == '0' ? '' : '-' + address.buldSlno;
    final roadTitle = '${address.rn} ${address.buldMnnm}$roadLast';
    final title = address.bdNm.isEmpty ? roadTitle : address.bdNm;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18)),
          SizedBox(height: 5),
          Text(address.jibunAddr, style: TextStyle(color: Color(0xFFA8A8A8))),
          Text('[도로명] ' + address.roadAddr, style: TextStyle(color: Color(0xFFA8A8A8))),
        ],
      ),
    );
  }
}







class TopBar1 extends StatelessWidget {
  const TopBar1({
    Key? key,
    required this.title,
    required this.onTap,
    required this.closeIcon,
    this.height = 60,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final Icon closeIcon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          titleWidget(),
          closeWidget(context),
        ],
      ),
    );
  }

  Widget titleWidget() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      height: height,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget closeWidget(BuildContext context) {
    return SizedBox(
      height: height,
      width: height,
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Color(0xFF757575),
          onTap: (){},
          child: Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: closeIcon == null ? Icon(Icons.close) : closeIcon,
          ),
        ),
      ),
    );
  }
}

