import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Services/SpotifyServices.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlaybackDataController extends GetxController {
  var isLoading = true.obs;
  PlayerState? playbackData;

  @override
  void onInit() {
    getPlaybackState();

    super.onInit();
  }

  void getPlaybackState() async {
    try {
      isLoading(true);
      var data = await SpotifySpecificServices().getCurrentPlayingState(true);

      if (data != null) {
        playbackData = data;
      }
    } catch (e) {
      print(e.toString());
      Get.dialog(AlertDialog(
        backgroundColor: ApplicationColors.mainBlack,
        content: Column(
          children: [Text('Error Connecting to Spotify')],
        ),
      ));
    } finally {
      isLoading(false);
    }
  }
}
