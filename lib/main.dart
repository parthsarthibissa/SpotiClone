import 'package:flutter/material.dart';
import 'package:spoticlone/Screens/HomeScreen/HomeScreen.dart';
import 'package:spoticlone/Screens/MainScreen/MainScreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
    navigatorKey: navigatorKey,
  ));
}
