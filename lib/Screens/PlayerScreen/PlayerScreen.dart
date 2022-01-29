// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/main.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlayerScreen extends StatelessWidget {
  final PlayerState? playerState;
  final dynamic image;
  const PlayerScreen({Key? key, this.playerState, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        duration: Duration(
          seconds: 1,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.75), BlendMode.darken),
                image: MemoryImage(image))),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
                      Icons.arrow_drop_down,
                      color: ApplicationColors.mainGreen,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 350,
                      width: 350,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 0.15, color: ApplicationColors.mainGreen),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: MemoryImage(image))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            playerState!.track!.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: ApplicationColors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 28.0, top: 10),
                          child: Icon(
                            FontAwesomeIcons.heart,
                            size: 22,
                            color: ApplicationColors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      playerState!.track!.artist.name!,
                      style: TextStyle(
                          color: ApplicationColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            iconSize: 25,
                            onPressed: () {},
                            icon: Icon(
                              Icons.repeat,
                              color: ApplicationColors.white,
                            )),
                        IconButton(
                          onPressed: () {
                            SpotifySdk.skipPrevious();
                          },
                          iconSize: 30,
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            color: ApplicationColors.white,
                          ),
                        ),
                        playerState!.isPaused == false
                            ? Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                    border: Border.all(
                                        width: 0.5,
                                        color: ApplicationColors.white)),
                                child: IconButton(
                                  onPressed: () {
                                    SpotifySdk.pause();
                                  },
                                  iconSize: 50,
                                  icon: Icon(
                                    Icons.pause,
                                    color: ApplicationColors.white,
                                  ),
                                ))
                            : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                    border: Border.all(
                                        width: 0.5,
                                        color: ApplicationColors.white)),
                                child: IconButton(
                                  onPressed: () {
                                    SpotifySdk.resume();
                                  },
                                  icon: Icon(
                                    Icons.play_arrow_rounded,
                                    color: ApplicationColors.white,
                                  ),
                                ),
                              ),
                        IconButton(
                            iconSize: 30,
                            onPressed: () {
                              SpotifySdk.skipNext();
                            },
                            icon: Icon(
                              Icons.skip_next_rounded,
                              color: ApplicationColors.white,
                            )),
                        IconButton(
                            iconSize: 25,
                            onPressed: () {},
                            icon: Icon(
                              Icons.shuffle,
                              color: ApplicationColors.white,
                            )),
                      ],
                    ),
                    Container(
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.2, color: ApplicationColors.mainGreen),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: SingleChildScrollView(
                          child: Text(
                            'ਦੱਸ ਪੁੱਤ ਤੇਰਾ head down ਕਾਸਤੋ ਚੰਗਾ ਭਲਾ ਹੱਸਦਾ ਸੀ ਮੌਨ ਕਾਸਤੋ ਆ ਜਿਹੜੇ ਦਰਵਾਜੇ ਵਿਚ board ਚੱਕੀ ਖੜੇ ਆ ਮੈਂ ਚੰਗੀ ਤਰਹ ਜਾਂਦਾ ਆ ਕੌਣ ਕਾਸਤੋ ਕੁਛ ਐਥੇ ਚਾਂਦੀ ਚਮਕੌਂਨਾ ਚੌਂਦੇ ਨੇ ਕੁਛ ਤੈਨੂ ਫਡ ਥੱਲੇ ਲੌਣਾ ਚੌਂਦੇ ਨੇ ਕੁਛ ਕ਼ ਨੇ ਆਏ ਐਥੇ ਭੁੱਖੇ fame ਦੇਨਾਮ ਲੈਕੇ ਤੇਰਾ ਅੱਗੇ ਔਣੇ ਚੌਂਦੇ ਨੇ ਮੁਸੀਬਤ ਤਾਂ ਮਰਦਾ ਤੇ ਪੈਂਦੀ ਰਿਹੰਦੀ ਏ ਦਬੀ ਨਾ ਤੂ ਦੁਨਿਯਾ ਸਵਾਦ ਲੈਂਦੀ ਏ',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
