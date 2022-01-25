// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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
  RxBool isLoading = true.obs;
  PlayerState? playbackData;
  RxString? trackName = ''.obs;

  @override
  void onInit() {
    getPlaybackState();

    super.onInit();
  }

  void getPlaybackState() async {
    try {
      isLoading(true);
      PlayerState data =
          await SpotifySpecificServices().getCurrentPlayingState(true);

      if (data != null) {
        playbackData = data;
        trackName = playbackData!.track!.name.obs;
      }
    } catch (e) {
      print(e.toString());
      Get.dialog(AlertDialog(
        backgroundColor: ApplicationColors.mainBlack,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Error Connecting to Spotify')],
        ),
      ));
    } finally {
      isLoading(false);
    }
  }
}
