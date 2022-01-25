// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Models/MyTopArtists.dart';
import 'package:spoticlone/Models/MyTopTracks.dart';
import 'package:spoticlone/Screens/Elements/BottomPlayBar/BottomPlayBar.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/DecoContainer.dart';
import 'package:spoticlone/Screens/LibraryScreen/widgets/OptionsButton.dart';
import 'package:spoticlone/Services/ApiInterface.dart';
import 'package:spotify_sdk/models/user_status.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class LibraryScreen extends StatefulWidget {
  final String? token;
  const LibraryScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    getDataReq();
    super.initState();
  }

  List<TopTrackItem> topTracks = [];
  MyTopTracksModel? model;
  MyTopArtists? artistModel;
  List<TopArtistItem> topArtists = [];
  getDataReq() {
    ApiInterface().getMyTopTracks(widget.token!).then((value) {
      setState(() {
        model = MyTopTracksModel.fromJson(value);
        topTracks = model!.items!;
      });
    });
    ApiInterface().getMyTopArtists(widget.token!).then((value) {
      setState(() {
        artistModel = MyTopArtists.fromJson(value);
        topArtists = artistModel!.items!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [BottomPlayBar()],
        ),
        backgroundColor: Colors.black,
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
                    FontAwesomeIcons.solidPlayCircle,
                    color: ApplicationColors.mainGreen,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Your Library',
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

              SizedBox(
                height: 30,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
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
                            'Your Top Tracks',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 255,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: topTracks.length,
                        itemBuilder: (builder, index) {
                          return DecoContainer(
                            model: model,
                            imageUrl: topTracks[index].album!.images![0].url!,
                            title: topTracks[index].name!,
                            artist: topTracks[index].artists![0].name,
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
                            Icons.album,
                            color: ApplicationColors.mainGreen,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Favourite Artists',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 255,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: topArtists.length,
                        itemBuilder: (builder, index) {
                          return DecoContainer(
                            model: artistModel,
                            imageUrl: topArtists[index].images![0].url,
                            title: topArtists[index].name!,
                            artist: topArtists[index].name,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
