// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/LibraryScreen/LibraryScreen.dart';
import 'package:spoticlone/Screens/SearchScreen/SearchScreen.dart';
import 'package:spoticlone/Screens/SettingsScreen/SettingsScreen.dart';
import 'package:spoticlone/Screens/SplashScreen/SplashScreen.dart';
import 'package:spoticlone/main.dart';

class CustomAppBar extends StatelessWidget {
  final String? token;

  const CustomAppBar({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.spotify,
            color: ApplicationColors.mainGreen,
          ),
          SizedBox(
            width: 14,
          ),
          Text(
            'Spotify',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Spacer(),
          Hero(
            tag: 'Search',
            child: IconButton(
              icon: Icon(FontAwesomeIcons.search,
                  color: ApplicationColors.mainGreen),
              onPressed: () {
                navigatorKey.currentState!
                    .push(SlideTransitionAnimation(SearchScreen(
                  token: token,
                )));
              },
            ),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.solidPlayCircle,
                color: ApplicationColors.mainGreen),
            onPressed: () {
              navigatorKey.currentState!
                  .push(SlideTransitionAnimation(LibraryScreen(
                token: token,
              )));
            },
          ),
          IconButton(
            onPressed: () {
              navigatorKey.currentState!
                  .push(SlideTransitionAnimation(SettingsScreen()));
            },
            icon: Icon(Icons.settings, color: ApplicationColors.mainGreen),
          )
        ],
      ),
    );
  }
}
