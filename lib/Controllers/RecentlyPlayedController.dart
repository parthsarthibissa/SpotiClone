import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spoticlone/Services/SpotifyServices.dart';
import 'package:spotify_sdk/models/track.dart';

class RecentlyPlayedController extends GetxController {
  List<Track> trackList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getRecentlyPlayback()async{
    
  }


}
