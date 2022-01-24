// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/InsideScreen.dart';
import 'package:spoticlone/main.dart';

class DecoContainer extends StatelessWidget {
  final String? title;
  final dynamic model;
  final String? artist;
  final String? imageUrl;
  DecoContainer(
      {Key? key, required this.model, this.title, this.artist, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
                width: 0.2, color: ApplicationColors.white.withOpacity(0.3)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 130,
                    width: 155,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: imageProvider)),
                  ),
                  placeholder: (context, url) => Center(
                    child: Container(
                      height: 130,
                      width: 155,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: ApplicationColors.mainGreen,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title!,
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(artist!, style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
