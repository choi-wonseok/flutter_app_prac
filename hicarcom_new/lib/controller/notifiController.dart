import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hicarcom/controller/numberController.dart';

import '../data/service.dart';

class NotificationController extends GetxController{
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String? token1;

    @override
    void onInit() async {
      // TODO: implement onInit
      super.onInit();
      initializeNotifications();
      firebaseCloudMessagingListener();
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      await addUserToken();
    }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_stat_hi'); // 변경된 부분

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String? title, String? body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'hicarcome', 'denny',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  void firebaseCloudMessagingListener() async {
    String? token = await firebaseMessaging.getToken();
    token1 = token;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _showNotification(notification.title, notification.body);
      }
    });

    if (token != null) {
      print('FCM Token: $token');
    } else {
      print('Failed to get FCM token');
    }
  }
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Create an instance of the controller to access non-static methods
    final controller = NotificationController();
    await controller._showNotification(message.notification?.title, message.notification?.body);
  }
  Future getQue(String dLat, String dLong) async {
    print(token1);
      bool result = await NotificationService().sendNotificationRequest(dLat, dLong);
      if (result) {
        print('Notification request was successful.');
        // 이 부분에 성공적으로 처리되었을 때 수행할 작업을 작성하세요.
      } else {
        print('Notification request failed.');
        // 이 부분에 요청 처리에 실패했을 때 수행할 작업을 작성하세요.
      }
      return result;
  }
  Future addUserToken() async{
    var mobilenumbercontroller = Get.find<MobileNumberController>();
    await mobilenumbercontroller.initialization; //
    var userId = mobilenumbercontroller.userinfolist[0].userId;
    bool addToken = await ServiceToken().addToken(userId!, token1!);
    print("몇번째인지 체크 이게 몇번나오나");
    if(addToken){
      print("저장성공==============================");
    }else{
      print('실패============================');
    }

  }
}

