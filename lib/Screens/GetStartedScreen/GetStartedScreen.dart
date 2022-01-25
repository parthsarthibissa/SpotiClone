// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/HomeScreen/HomeScreen.dart';
import 'package:spoticlone/Screens/MainScreen/MainScreen.dart';
import 'package:spoticlone/Screens/SplashScreen/SplashScreen.dart';
import 'package:spoticlone/main.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: SpotifySdk.subscribeConnectionStatus(),
        builder: (context, AsyncSnapshot<ConnectionStatus> snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: ApplicationColors.mainBlack,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/spotify.png'))),
                ),
                SizedBox(
                  height: 27,
                ),
                Text(
                  'Welcome To Spoticlone',
                  style: TextStyle(
                      color: ApplicationColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 7,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Spotify ',
                    style: TextStyle(
                        color: ApplicationColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: 'Redesigned',
                    style: TextStyle(
                        color: ApplicationColors.white,
                        fontSize: 22,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: ' REVAMPED',
                    style: TextStyle(
                        color: ApplicationColors.mainGreen,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  )
                ])),
                Spacer(),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  decoration: BoxDecoration(
                      color: ApplicationColors.mainGreen,
                      borderRadius: BorderRadius.circular(16)),
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    color: ApplicationColors.mainGreen,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () async {
                        try {
                          await SpotifySdk.connectToSpotifyRemote(
                                  clientId: '466b7b09bfdd4ddbab9992ed2bb37220',
                                  redirectUrl: 'http://localhost:8888/callback')
                              .then((value) async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setString(
                                'authToken',
                                await SpotifySdk.getAuthenticationToken(
                                    clientId:
                                        '466b7b09bfdd4ddbab9992ed2bb37220',
                                    redirectUrl:
                                        'http://localhost:8888/callback',
                                    scope:
                                        "app-remote-control,user-modify-playback-state,playlist-read-private,playlist-modify,playlist-modify-private,user-read-email,user-read-playback-state,user-read-currently-playing,user-library-read,user-library-modify,streaming"));
                            print(pref.getString('authToken'));
                            if (value == true) {
                              navigatorKey.currentState!.pushReplacement(
                                  SlideTransitionAnimation(MainScreen(
                                      authToken: pref.getString('authToken'))));
                            }
                          });
                        } catch (e) {
                          print(e.toString());
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return AlertDialog(
                                  backgroundColor: ApplicationColors.mainBlack,
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Alert',
                                        style: TextStyle(
                                            color: ApplicationColors.white),
                                      ),
                                      Divider(
                                        indent: 2.5,
                                        endIndent: 2.5,
                                        color: ApplicationColors.mainGreen,
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        'Make sure spotify app is installed and running on your device',
                                        style: TextStyle(
                                            color: ApplicationColors.white),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 35,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: ApplicationColors
                                                      .mainGreen,
                                                  width: 0.5)),
                                          width: 200,
                                          child: Material(
                                            color: ApplicationColors.mainBlack,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: InkWell(
                                              onTap: () async {
                                                bool? appCheck = await LaunchApp
                                                    .isAppInstalled(
                                                  androidPackageName:
                                                      'com.spotify.music',
                                                );
                                                if (appCheck == true) {
                                                  LaunchApp.openApp(
                                                    androidPackageName:
                                                        'com.spotify.music',
                                                  );
                                                  setState(() {});
                                                  navigatorKey.currentState!
                                                      .pop();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Spotify not installed');
                                                  LaunchApp.openApp(
                                                      openStore: true,
                                                      androidPackageName:
                                                          'com.spotify.music');
                                                }
                                              },
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.spotify,
                                                      size: 16,
                                                      color: ApplicationColors
                                                          .mainGreen,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Open Spotify',
                                                      style: TextStyle(
                                                          color:
                                                              ApplicationColors
                                                                  .white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 35,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 200,
                                          child: Material(
                                            color: ApplicationColors.mainGreen,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: InkWell(
                                              onTap: () {
                                                navigatorKey.currentState!
                                                    .pop();
                                              },
                                              child: Center(
                                                child: Text(
                                                  'Back',
                                                  style: TextStyle(
                                                      color: ApplicationColors
                                                          .white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                      child: Center(
                        child: Text(
                          'Connect with Spotify',
                          style: TextStyle(
                              color: ApplicationColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Developed By\n Parth Sarthi Bissa',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: ApplicationColors.white.withOpacity(0.5),
                        fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 18,
                )
              ],
            ),
          );
        });
  }
}
