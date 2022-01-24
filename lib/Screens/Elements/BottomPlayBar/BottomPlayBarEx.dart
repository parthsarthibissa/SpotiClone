// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class BottomPlayBarExp extends StatefulWidget {
  const BottomPlayBarExp({Key? key}) : super(key: key);

  @override
  State<BottomPlayBarExp> createState() => _BottomPlayBarExpState();
}

class _BottomPlayBarExpState extends State<BottomPlayBarExp> {
  bool showQueue = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: SpotifySdk.subscribePlayerState(),
        builder: (context, AsyncSnapshot<PlayerState> snap) {
          if (!snap.hasData) {
            return Center(
                child: Text(
              'STREAM',
              style: TextStyle(color: ApplicationColors.white),
            ));
          }
          var track = snap.data!.track!;
          return FutureBuilder(
              future: SpotifySdk.getImage(imageUri: snap.data!.track!.imageUri),
              builder: (context, AsyncSnapshot<Uint8List?>? snapshot) {
                if (!snapshot!.hasData) {
                  return Center(
                      child: Text(
                    'FUTURE',
                    style: TextStyle(color: ApplicationColors.white),
                  ));
                }
                var image = snapshot.data!;

                return AnimatedContainer(
                  height: 400,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ApplicationColors.mainBlack,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              showQueue
                                  ? ApplicationColors.mainBlack.withOpacity(0.8)
                                  : ApplicationColors.mainBlack
                                      .withOpacity(0.5),
                              BlendMode.darken),
                          image: MemoryImage(image))),
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 350),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 12),
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
                                setState(() {
                                  showQueue = false;
                                });
                              },
                              child: Icon(
                                Icons.close,
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
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0.5,
                                    color: ApplicationColors.mainGreen),
                                image:
                                    DecorationImage(image: MemoryImage(image))),
                          ),
                        ),
                      ),

                      Text(
                        track.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ApplicationColors.white),
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
                          Text(
                            track.artist.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: ApplicationColors.white),
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
                                width: 150,
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
                          '4:28',
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                showQueue = !showQueue;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.5, vertical: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5,
                                      color: ApplicationColors.mainGreen),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Queue',
                                    style: TextStyle(
                                        color: ApplicationColors.white,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    showQueue == true
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    size: 18,
                                    color: ApplicationColors.mainGreen,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.shuffle,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.skip_previous_rounded,
                            color: ApplicationColors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          snap.data!.isPaused == true
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
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.repeat,
                            color: Colors.grey,
                            size: 20,
                          ),
                          Spacer(),
                          Icon(
                            Icons.volume_up_rounded,
                            color: ApplicationColors.mainGreen,
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        visible: showQueue,
                        child: Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(image))),
                                ),
                                title: Text(
                                  'Moosetape',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'Sidhu Moose Wala',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.play_arrow_rounded,
                                      color: ApplicationColors.mainGreen,
                                    ),
                                    SizedBox(
                                      width: 7.5,
                                    ),
                                    Icon(
                                      Icons.close,
                                      color: ApplicationColors.white
                                          .withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(image))),
                                ),
                                title: Text(
                                  'Moosetape',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'Sidhu Moose Wala',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.play_arrow_rounded,
                                      color: ApplicationColors.mainGreen,
                                    ),
                                    SizedBox(
                                      width: 7.5,
                                    ),
                                    Icon(
                                      Icons.close,
                                      color: ApplicationColors.white
                                          .withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(image))),
                                ),
                                title: Text(
                                  'Moosetape',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'Sidhu Moose Wala',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.play_arrow_rounded,
                                      color: ApplicationColors.mainGreen,
                                    ),
                                    SizedBox(
                                      width: 7.5,
                                    ),
                                    Icon(
                                      Icons.close,
                                      color: ApplicationColors.white
                                          .withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(image))),
                                ),
                                title: Text(
                                  'Moosetape',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'Sidhu Moose Wala',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.play_arrow_rounded,
                                      color: ApplicationColors.mainGreen,
                                    ),
                                    SizedBox(
                                      width: 7.5,
                                    ),
                                    Icon(
                                      Icons.close,
                                      color: ApplicationColors.white
                                          .withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(image))),
                                ),
                                title: Text(
                                  'Moosetape',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'Sidhu Moose Wala',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.play_arrow_rounded,
                                      color: ApplicationColors.mainGreen,
                                    ),
                                    SizedBox(
                                      width: 7.5,
                                    ),
                                    Icon(
                                      Icons.close,
                                      color: ApplicationColors.white
                                          .withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}