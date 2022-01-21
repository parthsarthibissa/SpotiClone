import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:spoticlone/Services/SpotifyServices.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlaybackDataController extends GetxController {
  var isLoading = true.obs;
  String? trackName = ''.obs.toString();
  String? artistName = ''.obs.toString();
  bool? isPaused;
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
        artistName = data.track!.artist.name;
        trackName = data.track!.name;
        isPaused = data.isPaused;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
