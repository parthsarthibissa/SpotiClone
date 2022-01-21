// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Controllers/PlaybackDartController.dart';
import 'package:spoticlone/Models/AlbumModel.dart';
import 'package:spoticlone/Models/ArtistModel.dart';
import 'package:spoticlone/Models/CategoryModel.dart';
import 'package:spoticlone/Screens/Elements/AppBar/CustomAppBar.dart';
import 'package:spoticlone/Screens/Elements/BottomPlayBar/BottomPlayBar.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/DecoContainer.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/Recents.dart';
import 'package:spoticlone/Services/ApiInterface.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  final String? token;
  const HomeScreen({Key? key, this.token}) : super(key: key);

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
  List<ArtistProfile> artistList = [];
  List<CategoryItem> categoryList = [];

  final PlaybackDataController playbackDataController =
      Get.put(PlaybackDataController());

  getSpotifySetup() async {
    ApiInterface().getNewAlbums(widget.token!).then((value) {
      AlbumModel albumModel = AlbumModel.fromJson(value);

      setState(() {
        item = albumModel.albums!.items!;
      });
    });
    ApiInterface().getCategories(widget.token!).then((value) {
      CategoryModel categoryModel = CategoryModel.fromJson(value);
      setState(() {
        categoryList = categoryModel.categories!.items!;
      });

      ApiInterface().getRecommendedArtists(widget.token!).then((val) {
        print('ARTIST ' + val.toString());
        ArtistModel artistModel = ArtistModel.fromJson(val);
        setState(() {
          artistList = artistModel.artists!;
        });
        print('AD ' + artistList.toString());
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
                        return Container(
                          height: 75,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ApplicationColors.mainGreen,
                              backgroundColor: ApplicationColors.mainBlack,
                            ),
                          ),
                        );
                      }
                      return FutureBuilder(
                          future: SpotifySdk.getImage(
                            imageUri: playbackDataController
                                .playbackData!.track!.imageUri,
                            dimension: ImageDimension.large,
                          ),
                          builder: (BuildContext context,
                              AsyncSnapshot<Uint8List?>? snapshot) {
                            if (!snapshot!.hasData) {
                              return Container(
                                  height: 100,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            }
                            return BottomPlayBar(
                              sc: scaffoldState,
                              url: snapshot.data,
                              isPlaying: !playbackDataController
                                  .playbackData!.isPaused,
                              artists: playbackDataController
                                  .playbackData!.track!.artist.name,
                              trackName: playbackDataController
                                  .playbackData!.track!.name,
                            );
                          });
                      // return BottomPlayBar(
                      //   sc: scaffoldState,
                      //   url: url,
                      //   isPlaying:
                      //       !playbackDataController.playbackData!.isPaused,
                      //   artists: playbackDataController
                      //       .playbackData!.track!.artist.name,
                      //   trackName:
                      //       playbackDataController.playbackData!.track!.name,
                      // );
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
                                artist: item[index].totalTracks.toString() +
                                    ' Tracks',
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.category,
                                color: ApplicationColors.mainGreen,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Categories',
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
                            itemCount: categoryList.length,
                            itemBuilder: (builder, index) {
                              return DecoContainer(
                                imageUrl: categoryList[index].icons![0].url,
                                title: categoryList[index].name!,
                                artist: categoryList[index].id!.toUpperCase(),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.artstation,
                                color: ApplicationColors.mainGreen,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Recommended Artists',
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
                            itemCount: artistList.length,
                            itemBuilder: (builder, index) {
                              return DecoContainer(
                                imageUrl: artistList[index].images![0].url,
                                title: artistList[index].name!,
                                artist: artistList[index].type,
                              );
                            },
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
