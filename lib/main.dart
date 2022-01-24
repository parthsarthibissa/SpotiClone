// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/GetStartedScreen/GetStartedScreen.dart';
import 'package:spoticlone/Screens/HomeScreen/HomeScreen.dart';
import 'package:spoticlone/Screens/MainScreen/MainScreen.dart';
import 'package:spoticlone/Screens/SplashScreen/SplashScreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: prefer_const_constructors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.black, // status bar color
  ));
  String? signed;
  SharedPreferences pref = await SharedPreferences.getInstance();
  signed = pref.getString('authToken');

  if (signed != null) {
    String? token = pref.getString('authToken');
    print('AUTH TOKEN ' + token.toString());
    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        nextScreen: MainScreen(authToken: token),
      ),
      builder: EasyLoading.init(),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: navigatorKey,
    ));
  } else {
    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        nextScreen: GetStartedScreen(),
      ),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: EasyLoading.init(),
      navigatorKey: navigatorKey,
    ));
  }
}
