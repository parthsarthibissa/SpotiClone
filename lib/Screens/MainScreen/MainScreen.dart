// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spoticlone/Screens/HomeScreen/HomeScreen.dart';

class MainScreen extends StatelessWidget {
  final String? authToken;
  MainScreen({required this.authToken});

  final PersistentTabController persistentTabController =
      PersistentTabController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: HomeScreen(
      token: authToken,
    ));
  }
}
