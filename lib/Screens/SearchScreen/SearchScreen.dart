// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.search,
                  color: ApplicationColors.mainGreen,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Search',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fillColor: Colors.white,
                  hintText: 'Search'),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              indent: 24,
              endIndent: 24,
              color: ApplicationColors.mainGreen,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.userCheck,
                  color: ApplicationColors.mainGreen,
                ),
                SizedBox(
                  width: 14,
                ),
                Text(
                  'Verified Artists',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
