// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/Elements/AppBar/CustomAppBar.dart';
import 'package:spoticlone/Screens/Elements/BottomNavigationBar/CustomBottomNavigationBar.dart';
import 'package:spoticlone/Screens/Elements/BottomPlayBar/BottomPlayBar.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/Recents.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getSpotifySetup();
    // TODO: implement initState
    super.initState();
  }

  getSpotifySetup() async {
    await SpotifySdk.connectToSpotifyRemote(
        clientId: '466b7b09bfdd4ddbab9992ed2bb37220', redirectUrl: '');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 10,
            child: BottomPlayBar(
              sc: scaffoldState,
            )),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const CustomAppBar(),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: ApplicationColors.mainGreen,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Recently Played',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: RecentlyPlayed()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.music_note,
                          color: ApplicationColors.mainGreen,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Your Daily Mixes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
