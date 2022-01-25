// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Controllers/PlaybackDartController.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class BottomPlayBar extends StatefulWidget {
  final bool? opened;

  BottomPlayBar({this.opened});

  @override
  State<BottomPlayBar> createState() => _BottomPlayBarState();
}

class _BottomPlayBarState extends State<BottomPlayBar>
    with SingleTickerProviderStateMixin {
  bool showFab = true;
  bool showQueue = false;
  AnimationController? animationController;
  Animation<Color?>? animation;
  Animation<Color>? musicAnimation;
  bool? liked;
  final PlaybackDataController playerState = Get.put(PlaybackDataController());
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = ColorTween(begin: Colors.grey, end: Colors.red)
        .animate(animationController!);

    animation!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  getImage(imageUri) async {
    return await SpotifySdk.getImage(imageUri: imageUri);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
        ),
        Obx(() {
          playerState.update();
          if (playerState.isLoading == true.obs) {
            return Center(
              child: CircularProgressIndicator(
                color: ApplicationColors.mainGreen,
              ),
            );
          }
          return FutureBuilder(
              future: SpotifySdk.getImage(
                  imageUri: playerState.playbackData!.track!.imageUri),
              builder: (builder, AsyncSnapshot<Uint8List?>? snapshot) {
                if (!snapshot!.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ApplicationColors.mainGreen,
                      backgroundColor: Colors.black,
                    ),
                  );
                }
                var image = snapshot.data!;
                return showFab == true
                    ? AnimatedContainer(
                        height: showFab
                            ? 100
                            : MediaQuery.of(context).size.height / 1.85,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ApplicationColors.mainBlack,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    ApplicationColors.mainBlack
                                        .withOpacity(0.5),
                                    BlendMode.darken),
                                image: MemoryImage(image))),
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 450),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 140,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 7),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        playerState.trackName!.string,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        playerState
                                            .playbackData!.track!.artist.name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.skip_previous_rounded,
                                        color: ApplicationColors.white,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () async {},
                                        child: playerState
                                                    .playbackData!.isPaused ==
                                                false
                                            ? Icon(
                                                Icons.pause,
                                                color: ApplicationColors.white,
                                              )
                                            : Icon(
                                                Icons.play_arrow_rounded,
                                                color: ApplicationColors.white,
                                                size: 30,
                                              ),
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
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            showFab = false;
                                          });
                                        },
                                        child: Icon(
                                          Icons.arrow_drop_up_outlined,
                                          color: ApplicationColors.white,
                                          size: 30,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : AnimatedContainer(
                        height: showQueue == true
                            ? MediaQuery.of(context).size.height / 1.25
                            : 450,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ApplicationColors.mainBlack,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    showQueue
                                        ? ApplicationColors.mainBlack
                                            .withOpacity(0.8)
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
                                          showFab = true;
                                          showQueue = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: ApplicationColors.mainGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Hero(
                                tag: 'photo',
                                child: Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      animationController!.forward();
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 30),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 0.5,
                                              color:
                                                  ApplicationColors.mainGreen),
                                          image: DecorationImage(
                                              image: MemoryImage(image))),
                                    ),
                                  ),
                                ),
                              ),

                              Hero(
                                tag: 'trackName',
                                child: Text(
                                  playerState.playbackData!.track!.name,
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

                              Hero(
                                tag: 'artistName',
                                child: Row(
                                  children: [
                                    Text(
                                      playerState
                                          .playbackData!.track!.artist.name!,
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
                                      onTap: () {
                                        if (liked == true) {
                                          animationController!.forward();
                                          setState(() {
                                            liked = false;
                                          });
                                        } else {
                                          animationController!.reverse();
                                          setState(() {
                                            liked = true;
                                          });
                                        }
                                      },
                                      child: liked == false
                                          ? Icon(
                                              FontAwesomeIcons.solidHeart,
                                              size: 22,
                                              color: animation!.value,
                                            )
                                          : Icon(
                                              FontAwesomeIcons.heart,
                                              size: 22,
                                              color: animation!.value,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Hero(
                                tag: 'progress',
                                child: ClipRRect(
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
                              ),
                              SizedBox(
                                height: 6.5,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '4:28',
                                  style: TextStyle(
                                      color: ApplicationColors.white
                                          .withOpacity(0.5),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Hero(
                                tag: 'control',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shuffle,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.skip_previous_rounded,
                                      color: ApplicationColors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    playerState.playbackData!.isPaused == true
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
                                    Spacer(),
                                    Icon(
                                      Icons.repeat,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: ApplicationColors.mainGreen),
                                  child: Material(
                                    color: ApplicationColors.mainGreen,
                                    borderRadius: BorderRadius.circular(18),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showQueue = !showQueue;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(18),
                                      child: Center(
                                        child: Text(
                                          'Open Queue',
                                          style: TextStyle(
                                            color: ApplicationColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: showQueue,
                                  child: Expanded(
                                      child:
                                          ListView(shrinkWrap: true, children: [
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
                                  ])))
                            ]),
                      );
              });
        }),
      ],
    );
  }
}
