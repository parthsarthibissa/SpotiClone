// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/InsideScreen.dart';
import 'package:spoticlone/main.dart';

class DecoContainer extends StatefulWidget {
  final String? title;
  final dynamic model;
  final String? artist;
  final String? imageUrl;
  DecoContainer(
      {Key? key, required this.model, this.title, this.artist, this.imageUrl});

  @override
  State<DecoContainer> createState() => _DecoContainerState();
}

class _DecoContainerState extends State<DecoContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        border: Border.all(
            color: ApplicationColors.mainGreen.withOpacity(0.5), width: 0.5),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, -6),
              blurRadius: 3,
              blurStyle: BlurStyle.inner,
              spreadRadius: 2,
              color: ApplicationColors.mainGreen)
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl!,
              imageBuilder: (context, imageProvider) => Container(
                height: 155,
                width: 155,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: ApplicationColors.mainGreen.withOpacity(0.5),
                        width: 0),
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
            widget.title!,
            maxLines: 1,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          Text(widget.artist!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300))
        ],
      ),
    );
  }
}
