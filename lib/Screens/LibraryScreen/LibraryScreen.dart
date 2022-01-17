// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/LibraryScreen/widgets/OptionButtons.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

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
                  FontAwesomeIcons.solidPlayCircle,
                  color: ApplicationColors.mainGreen,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Library',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Icon(
                  FontAwesomeIcons.search,
                  color: ApplicationColors.mainGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  FontAwesomeIcons.plus,
                  color: ApplicationColors.mainGreen,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            // TextFormField(
            //   decoration: InputDecoration(
            //       filled: true,
            //       enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(40)),
            //       focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(50)),
            //       fillColor: Colors.white,
            //       hintText: 'Search'),
            // ),

            Row(
              children: [
                OptionButton(title: 'Albums'),
                Spacer(),
                OptionButton(title: 'Playlists'),
                Spacer(),
                OptionButton(title: 'Artists'),
              ],
            ),

            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.history,
                  color: ApplicationColors.mainGreen,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Recently Played',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
