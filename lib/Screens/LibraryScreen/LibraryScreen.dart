// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/LibraryScreen/widgets/OptionsButton.dart';
import 'package:spotify_sdk/models/user_status.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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

              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
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
                      'Liked Albums',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: 255,
              //   alignment: Alignment.center,
              //   width: MediaQuery.of(context).size.width,
              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: item.length,
              //     itemBuilder: (builder, index) {
              //       return DecoContainer(
              //         model: albumModel,
              //         imageUrl: item[index].images![0].url,
              //         title: item[index].name!,
              //         artist:
              //             item[index].totalTracks.toString() + ' Tracks',
              //       );
              //     },
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
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
              // Container(
              //   height: 255,
              //   alignment: Alignment.center,
              //   width: MediaQuery.of(context).size.width,
              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: item.length,
              //     itemBuilder: (builder, index) {
              //       return DecoContainer(
              //         model: albumModel,
              //         imageUrl: item[index].images![0].url,
              //         title: item[index].name!,
              //         artist:
              //             item[index].totalTracks.toString() + ' Tracks',
              //       );
              //     },
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
