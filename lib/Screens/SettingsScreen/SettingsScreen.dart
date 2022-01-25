// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/Elements/BottomPlayBar/BottomPlayBar.dart';
import 'package:spotify_sdk/models/user_status.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomPlayBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          // margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: ApplicationColors.mainGreen,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: SpotifySdk.subscribeUserStatus(),
                  builder: (builder, AsyncSnapshot<UserStatus> snapshot) {
                    return ListTile(
                      leading: Icon(
                        Icons.online_prediction,
                        color: ApplicationColors.mainGreen,
                      ),
                      title: Text(
                        snapshot.data!.code.toString() == '0'
                            ? 'Connected'.toUpperCase()
                            : 'Disconnected'.toUpperCase(),
                        style: TextStyle(
                            color: ApplicationColors.mainGreen,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  }),
              Divider(
                color: ApplicationColors.mainGreen,
                thickness: 0.2,
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.paintBrush,
                  color: ApplicationColors.mainGreen,
                ),
                title: Text(
                  'Change Theme',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.spotify,
                  color: ApplicationColors.mainGreen,
                ),
                title: Text(
                  'Disconnect Spotify',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Spacer(),
              Container(
                height: 100,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  'Developed By\n Parth Sarthi Bissa',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
