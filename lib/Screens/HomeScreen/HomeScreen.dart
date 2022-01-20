// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Controllers/PlaybackDartController.dart';
import 'package:spoticlone/Models/AlbumModel.dart';
import 'package:spoticlone/Screens/Elements/AppBar/CustomAppBar.dart';
import 'package:spoticlone/Screens/Elements/BottomNavigationBar/CustomBottomNavigationBar.dart';
import 'package:spoticlone/Screens/Elements/BottomPlayBar/BottomPlayBar.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/DecoContainer.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/Recents.dart';
import 'package:spoticlone/Services/ApiInterface.dart';
import 'package:spoticlone/Services/SpotifyServices.dart';
import 'package:spotify_sdk/models/album.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isLoading = true;
  @override
  void initState() {
    getSpotifySetup();
    setState(() {
      isLoading = false;
    });
    // TODO: implement initState
    super.initState();
  }

  List<Item> item = [];
  var authToken;

  final PlaybackDataController playbackDataController =
      Get.put(PlaybackDataController());
  getSpotifySetup() async {
    await SpotifySdk.connectToSpotifyRemote(
            clientId: '466b7b09bfdd4ddbab9992ed2bb37220',
            redirectUrl: 'http://localhost:8888/callback')
        .then((value) async {
      authToken = await SpotifySdk.getAuthenticationToken(
          clientId: '466b7b09bfdd4ddbab9992ed2bb37220',
          redirectUrl: 'http://localhost:8888/callback',
          scope:
              "app-remote-control,user-modify-playback-state,playlist-read-private,playlist-modify,playlist-modify-private,user-read-email,user-read-playback-state,user-read-currently-playing,user-library-read,user-library-modify,streaming");
      print(authToken);
    }).then((value) async {
      ApiInterface().getNewAlbums(authToken).then((value) {
        AlbumModel albumModel = AlbumModel.fromJson(value);
        print(albumModel.toJson().toString());
        setState(() {
          item = albumModel.albums!.items!;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: ApplicationColors.mainGreen,
              backgroundColor: ApplicationColors.mainBlack,
            ),
          )
        : SafeArea(
            child: Scaffold(
              key: scaffoldState,
              bottomNavigationBar: BottomAppBar(
                  color: Colors.transparent,
                  elevation: 10,
                  child: Obx(
                    () {
                      if (playbackDataController.isLoading.value) {
                        return CircularProgressIndicator(
                          color: ApplicationColors.mainGreen,
                          backgroundColor: ApplicationColors.mainBlack,
                        );
                      }
                      String url = String.fromCharCodes(
                          playbackDataController.playerImage!);
                      return BottomPlayBar(
                        sc: scaffoldState,
                        url: url,
                        isPlaying:
                            !playbackDataController.playbackData!.isPaused,
                        artists: playbackDataController
                            .playbackData!.track!.artist.name,
                        trackName:
                            playbackDataController.playbackData!.track!.name,
                      );
                    },
                  )),
              backgroundColor: ApplicationColors.mainBlack,
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
                                Icons.album,
                                color: ApplicationColors.mainGreen,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Fresh Albums',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'SEE ALL',
                                    style: TextStyle(
                                      color: ApplicationColors.mainGreen,
                                      fontSize: 14,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          height: 255,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: item.length,
                            itemBuilder: (builder, index) {
                              return DecoContainer(
                                imageUrl: item[index].images![0].url,
                                title: item[index].name!,
                                artist: item[index].totalTracks.toString(),
                              );
                            },
                          ),
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
          );
  }
}
