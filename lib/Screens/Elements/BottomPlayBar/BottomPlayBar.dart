// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/HomeScreen/HomeScreen.dart';

class BottomPlayBar extends StatefulWidget {
  final GlobalKey<ScaffoldState>? sc;
  BottomPlayBar({this.sc});

  @override
  State<BottomPlayBar> createState() => _BottomPlayBarState();
}

class _BottomPlayBarState extends State<BottomPlayBar> {
  bool showFab = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
          color: ApplicationColors.mainBlack,
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  ApplicationColors.mainBlack.withOpacity(0.5),
                  BlendMode.darken),
              image: AssetImage('assets/images/moosetape.jpg'))),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Moosetape',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Sidhu Moose Wala',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.skip_previous_rounded,
                  color: ApplicationColors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.play_arrow_rounded,
                  color: ApplicationColors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.skip_next_rounded,
                  color: ApplicationColors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                showFab == true
                    ? InkWell(
                        onTap: () {
                          scaffoldState.currentState!
                              .showBottomSheet((context) {
                            return SizedBox();
                          }).close;
                          setState(() {
                            showFab = false;
                          });
                        },
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: ApplicationColors.white,
                          size: 30,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          scaffoldState.currentState!
                              .showBottomSheet((context) {
                            return Container(
                              color: ApplicationColors.mainBlack,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.spotify,
                                        color: ApplicationColors.mainGreen,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Now Playing',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: ApplicationColors.white),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(vertical: 30),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/moosetape.jpg'))),
                                  ),
                                  Text(
                                    'Moosetape',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: ApplicationColors.white),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Sidhu Moose Wala ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color: ApplicationColors.white),
                                      ),
                                      Icon(
                                        Icons.verified,
                                        size: 15,
                                        color: Colors.blue,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 3,
                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        children: [
                                          Container(
                                            color: ApplicationColors.white,
                                          ),
                                          Container(
                                            width: 150,
                                            color: ApplicationColors.mainGreen,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6.5,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '4:28',
                                      style: TextStyle(
                                          color: ApplicationColors.white
                                              .withOpacity(0.5),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.skip_previous_rounded,
                                        color: ApplicationColors.white,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.play_arrow_rounded,
                                        color: ApplicationColors.white,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.skip_next_rounded,
                                        color: ApplicationColors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            );
                          });
                          setState(() {
                            showFab = true;
                          });
                        },
                        child: Icon(
                          Icons.arrow_drop_up_outlined,
                          color: ApplicationColors.white,
                          size: 30,
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
