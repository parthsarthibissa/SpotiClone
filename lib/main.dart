// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/GetStartedScreen/GetStartedScreen.dart';
import 'package:spoticlone/Screens/HomeScreen/HomeScreen.dart';
import 'package:spoticlone/Screens/SplashScreen/SplashScreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final appData = GetStorage();

Future<void> main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  // ignore: prefer_const_constructors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  appData.writeIfNull('darkmode', false);

  String? signed;
  SharedPreferences pref = await SharedPreferences.getInstance();
  signed = pref.getString('authToken');

  if (signed != null) {
    String? token = pref.getString('authToken');
    print('AUTH TOKEN ' + token.toString());
    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        nextScreen: HomeScreen(token: token),
      ),
      builder: EasyLoading.init(),
      navigatorKey: navigatorKey,
    ));
  } else {
    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        nextScreen: GetStartedScreen(),
      ),
      builder: EasyLoading.init(),
      navigatorKey: navigatorKey,
    ));
  }
}
