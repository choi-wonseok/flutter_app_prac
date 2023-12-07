import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:hicarcom/api/api.dart';
import 'package:hicarcom/controller/locationController.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hicarcom/controller/numberController.dart';
import 'controller/navigationController.dart';
import 'controller/notifiController.dart';
import 'controller/userinfoController.dart';
import 'customer/controller/customerNavigationController.dart';
import 'customer/controller/nMapController.dart';
import 'firebase_options.dart';
import 'map.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp(); // 초기화 로직 분리
  runApp(MyApp());
}

Future<void> initializeApp() async {
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    NaverMapSdk.instance.initialize(
      clientId: dotenv.env['NAVER_MAP_CLIENT_ID'] ?? '',
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"),
    ),
  ]);

  Get.put(LocationController());
  Get.put(NavigationController());
  Get.put(MobileNumberController());
  Get.put(NotificationController());
  Get.put(UserInfoController());
  Get.put(CustomerNavigationController());
  // Get.put(NMapController());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);
  final mobileNumberController = Get.find<MobileNumberController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      // Execute all the asynchronous operations you need before the app starts
      future: mobileNumberController.initialization,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while waiting for initializations to complete
          return const MaterialApp(home: LoadingScreen());
        } else if (snapshot.hasError) {
          // If we have an error during initialization, display an error message
          return const MaterialApp(home: ErrorScreen(),debugShowCheckedModeBanner: false,);
        } else if (snapshot.data == true) {
          if(mobileNumberController.companyLevel.value == '1'){
            return NaverMapApp();
          }else{
            return GetMaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ko', 'KR'), // 한국어 지원
              ],
              debugShowCheckedModeBanner: false,
              title: 'Hicarcom',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.lightBlue,
                    brightness: Brightness.light
                ),
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.dark
              ),
              themeMode: ThemeMode.system,
              home: HomePage(),
            );
          }
          // Once all initializations are complete and returned true, show the main app

        } else {
          // If initializations complete but returned false, handle accordingly
          return const MaterialApp(home: ErrorScreen());
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png',
          width: 150,
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/images/logo.png',
          width: 130,
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("회원 정보가 없습니다. 사무실에 문의 해주세요.",style: TextStyle(fontSize: 18)),
            Text("1600-4044",style: TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/logo.png',
          width: 130,
        ),
      ),
      body: Obx(() =>
        navigationController.screens[navigationController.selectedIndex.value]
      ),
      bottomNavigationBar: Obx(
            () => NavigationBar(
          selectedIndex: navigationController.selectedIndex.value,
          onDestinationSelected: (index) => navigationController.changePage(index),
          destinations: const[
            NavigationDestination(icon: Icon(Icons.car_crash), label: '접수요청'),
            NavigationDestination(icon: Icon(Icons.view_list), label: '내 운행'),
            NavigationDestination(icon: Icon(Icons.edit_document), label: '접수'),
            NavigationDestination(icon: Icon(Icons.settings), label: '설정'),
          ],
        ),
      ),
    );
  }
}