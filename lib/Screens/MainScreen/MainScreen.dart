// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/HomeScreen/HomeScreen.dart';
import 'package:spoticlone/Screens/LibraryScreen/LibraryScreen.dart';
import 'package:spoticlone/Screens/SearchScreen/SearchScreen.dart';

class MainScreen extends StatelessWidget {
  final PersistentTabController persistentTabController =
      PersistentTabController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PersistentTabView(
      context,
      backgroundColor: Colors.black,
      screens: [HomeScreen(), SearchScreen(), LibraryScreen()],
      controller: persistentTabController,
      itemAnimationProperties: ItemAnimationProperties(
          curve: Curves.easeInBack, duration: Duration(milliseconds: 350)),
      screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.easeInBack,
          duration: Duration(milliseconds: 350)),
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(15), boxShadow: []),
      items: [
        PersistentBottomNavBarItem(
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.grey,
            title: 'Home',
            textStyle: TextStyle(color: Colors.white),
            activeColorPrimary: ApplicationColors.mainGreen,
            activeColorSecondary: ApplicationColors.mainGreen,
            icon: Icon(Icons.home)),
        PersistentBottomNavBarItem(
            activeColorPrimary: ApplicationColors.mainGreen,
            inactiveColorPrimary: Colors.grey,
            title: 'Search',
            textStyle: TextStyle(color: Colors.white),
            activeColorSecondary: ApplicationColors.mainGreen,
            inactiveColorSecondary: Colors.grey,
            icon: Icon(Icons.search)),
        PersistentBottomNavBarItem(
            activeColorPrimary: ApplicationColors.mainGreen,
            inactiveColorPrimary: Colors.grey,
            title: 'Library',
            textStyle: TextStyle(color: Colors.white),
            activeColorSecondary: ApplicationColors.mainGreen,
            inactiveColorSecondary: Colors.grey,
            icon: Icon(FontAwesomeIcons.solidPlayCircle)),
      ],
      navBarStyle: NavBarStyle.style5,
    ));
  }
}
