// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';

class SplashScreen extends StatefulWidget {
  final Widget? nextScreen;
  const SplashScreen({required this.nextScreen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double d = 100;
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 3,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: d,
              color: ApplicationColors.white,
            ),
            Container(
              width: 150,
              height: 100,
              color: ApplicationColors.mainGreen,
            ),
            Center(
                child: Icon(
              FontAwesomeIcons.spotify,
              color: Colors.black,
            ))
          ],
        ),
      ),
    );
  }
}
