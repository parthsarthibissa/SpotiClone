import 'package:flutter/material.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/DecoContainer.dart';

class TrackDetails extends StatelessWidget {
  final String? imgUrl;
  final String? artistName;
  final String? trackName;

  const TrackDetails(
      {Key? key,
      required this.imgUrl,
      required this.artistName,
      required this.trackName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'img',
        child: DecoContainer(
          artist: artistName!,
          imageUrl: imgUrl!,
          model: '',
          title: trackName,
        ));
  }
}
