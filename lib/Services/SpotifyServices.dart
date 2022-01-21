// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifySpecificServices {
  Future<PlayerState> getCurrentPlayingState(bool? showLoading) async {
    if (showLoading == true) {
      EasyLoading.show(
          dismissOnTap: false,
          indicator: CircularProgressIndicator(
            color: ApplicationColors.mainGreen,
            backgroundColor: ApplicationColors.mainBlack,
          ));
    }
    final response = await SpotifySdk.getPlayerState();
    EasyLoading.dismiss();
     return response!;
  }
}
