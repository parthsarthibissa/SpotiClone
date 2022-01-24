// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/main.dart';
import 'package:spotify_sdk/models/player_state.dart';

class PlayerScreen extends StatefulWidget {
  final PlayerState playerState;
  final Uint8List? image;
  const PlayerScreen({Key? key, required this.image, required this.playerState})
      : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: ApplicationColors.mainBlack,
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    ApplicationColors.mainBlack.withOpacity(0.75),
                    BlendMode.darken),
                image: MemoryImage(widget.image!))),
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 350),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.spotify,
                    color: ApplicationColors.mainGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Now Playing',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ApplicationColors.white),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      navigatorKey.currentState!.pop();
                    },
                    child: Icon(
                      Icons.close,
                      size: 38,
                      color: ApplicationColors.mainGreen,
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 300,
                  width: 300,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 0.5, color: ApplicationColors.mainGreen),
                      image:
                          DecorationImage(image: MemoryImage(widget.image!))),
                ),
              ),
            ),

            Hero(
              tag: 'trackName',
              child: Text(
                widget.playerState.track!.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ApplicationColors.white),
              ),
            ),

            // SizedBox(
            //   width: 40,
            // ),
            // Container(
            //   height: 150,
            //   width: 200,
            //   padding:
            //       EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //   margin: EdgeInsets.symmetric(horizontal: 5),
            //   child: SingleChildScrollView(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         SizedBox(
            //           height: 20,
            //         ),
            //         Text(
            //           'ਦੱਸ ਪੁੱਤ ਤੇਰਾ head down ਕਾਸਤੋ ਚੰਗਾ ਭਲਾ ਹੱਸਦਾ ਸੀ ਮੌਨ ਕਾਸਤੋ ਆ ਜਿਹੜੇ ਦਰਵਾਜੇ ਵਿਚ board ਚੱਕੀ ਖੜੇ ਆ ਮੈਂ ਚੰਗੀ ਤਰਹ ਜਾਂਦਾ ਆ ਕੌਣ ਕਾਸਤੋ ਕੁਛ ਐਥੇ ਚਾਂਦੀ ਚਮਕੌਂਨਾ ਚੌਂਦੇ ਨੇ ਕੁਛ ਤੈਨੂ ਫਡ ਥੱਲੇ ਲੌਣਾ ਚੌਂਦੇ ਨੇ ਕੁਛ ਕ਼ ਨੇ ਆਏ ਐਥੇ ਭੁੱਖੇ fame ਦੇਨਾਮ ਲੈਕੇ ਤੇਰਾ ਅੱਗੇ ਔਣੇ ਚੌਂਦੇ ਨੇ ਮੁਸੀਬਤ ਤਾਂ ਮਰਦਾ ਤੇ ਪੈਂਦੀ ਰਿਹੰਦੀ ਏ ਦਬੀ ਨਾ ਤੂ ਦੁਨਿਯਾ ਸਵਾਦ ਲੈਂਦੀ ਏ',
            //           style: TextStyle(
            //               color: Colors.white.withOpacity(0.85),
            //               fontSize: 18,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            Row(
              children: [
                Hero(
                  tag: 'artistName',
                  child: Text(
                    widget.playerState.track!.artist.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: ApplicationColors.white),
                  ),
                ),
                Icon(
                  Icons.verified,
                  size: 15,
                  color: Colors.blue,
                ),
                Spacer(),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      FontAwesomeIcons.solidHeart,
                      size: 22,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 3,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      color: ApplicationColors.white,
                    ),
                    Container(
                      width: (widget.playerState.playbackPosition /
                              widget.playerState.track!.duration) *
                          100,
                      color: ApplicationColors.mainGreen,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 6.5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                (widget.playerState.track!.duration / 60000)
                    .toStringAsFixed(2)
                    .toString(),
                style: TextStyle(
                    color: ApplicationColors.white.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shuffle,
                  color: Colors.grey,
                  size: 20,
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous_rounded,
                      color: ApplicationColors.white,
                      size: 30,
                    )),
                SizedBox(
                  width: 10,
                ),
                widget.playerState.isPaused == true
                    ? Icon(
                        Icons.pause,
                        color: ApplicationColors.white,
                      )
                    : Icon(
                        Icons.play_arrow_rounded,
                        color: ApplicationColors.white,
                        size: 30,
                      ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.skip_next_rounded,
                  color: ApplicationColors.white,
                  size: 30,
                ),
                Spacer(),
                Icon(
                  Icons.repeat,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
