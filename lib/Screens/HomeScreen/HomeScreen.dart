// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_new

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Models/AlbumModel.dart';
import 'package:spoticlone/Models/ArtistModel.dart';
import 'package:spoticlone/Models/CategoryModel.dart';
import 'package:spoticlone/Screens/Elements/AppBar/CustomAppBar.dart';
import 'package:spoticlone/Screens/Elements/BottomPlayBar/BottomPlayBar.dart';
import 'package:spoticlone/Screens/GetStartedScreen/GetStartedScreen.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/DecoContainer.dart';
import 'package:spoticlone/Screens/SplashScreen/SplashScreen.dart';
import 'package:spoticlone/Services/ApiInterface.dart';

import '../../main.dart';

final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  final String? token;
  const HomeScreen({Key? key, this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getSpotifySetup();

    super.initState();
  }

  final TextEditingController textEditingController = TextEditingController();
  List<Item> item = [];
  List<ArtistProfile> artistList = [];
  List<CategoryItem> categoryList = [];
  AlbumModel? albumModel;
  CategoryModel? categoryModel;
  ArtistModel? artistModel;
  getSpotifySetup() async {
    ApiInterface().getNewAlbums(widget.token!).then((value) {
      setState(() {
        albumModel = AlbumModel.fromJson(value);

        item = albumModel!.albums!.items!;
      });
    }).catchError((onError) {
      showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              backgroundColor: ApplicationColors.mainBlack,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Error',
                    style: TextStyle(
                        color: ApplicationColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Divider(
                    color: ApplicationColors.mainGreen,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Spotify Disconnected. Please run the spotify app and try again',
                    style: TextStyle(
                        color: ApplicationColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 35,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ApplicationColors.mainGreen, width: 0.5)),
                      width: 200,
                      child: Material(
                        color: ApplicationColors.mainBlack,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () async {
                            bool? appCheck = await LaunchApp.isAppInstalled(
                              androidPackageName: 'com.spotify.music',
                            );
                            if (appCheck == true) {
                              LaunchApp.openApp(
                                androidPackageName: 'com.spotify.music',
                              );
                              setState(() {});

                              navigatorKey.currentState!.pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (builder) {
                                return SplashScreen(
                                    nextScreen: GetStartedScreen());
                              }), (route) => false);
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Spotify not installed');
                              LaunchApp.openApp(
                                  openStore: true,
                                  androidPackageName: 'com.spotify.music');
                            }
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.spotify,
                                  size: 16,
                                  color: ApplicationColors.mainGreen,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Open Spotify',
                                  style: TextStyle(
                                      color: ApplicationColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
    ApiInterface().getCategories(widget.token!).then((value) {
      setState(() {
        categoryModel = CategoryModel.fromJson(value);

        categoryList = categoryModel!.categories!.items!;
      });

      ApiInterface().getRecommendedArtists(widget.token!).then((val) {
        print('ARTIST ' + val.toString());
        setState(() {
          artistModel = ArtistModel.fromJson(val);

          artistList = artistModel!.artists!;
        });
        print('AD ' + artistList.toString());
      });
    });
  }

  final PageController? pageController1 = PageController(viewportFraction: 0.7);
  final PageController? pageController2 = PageController(viewportFraction: 0.7);
  final PageController? pageController3 = PageController(viewportFraction: 0.7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomPlayBar(
            opened: true,
          ),
        ],
      ),
      key: scaffoldState,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          CustomAppBar(token: widget.token),
          Expanded(
            child: SingleChildScrollView(
                child: ShowUpAnimation(
              curve: Curves.bounceInOut,
              animationDuration: Duration(milliseconds: 750),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.album,
                          color: ApplicationColors.mainGreen,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Fresh Albums',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 325,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: PageView.builder(
                      controller: pageController1,
                      scrollDirection: Axis.horizontal,
                      itemCount: item.length,
                      itemBuilder: (builder, index) {
                        return builder1(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.category,
                          color: ApplicationColors.mainGreen,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Categories',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 325,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: PageView.builder(
                      controller: pageController2,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (builder, index) {
                        return builder2(index);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.artstation,
                          color: ApplicationColors.mainGreen,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Recommended Artists',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 325,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: PageView.builder(
                      controller: pageController3,
                      scrollDirection: Axis.horizontal,
                      itemCount: artistList.length,
                      itemBuilder: (builder, index) {
                        return builder3(index);
                      },
                    ),
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  builder1(int index) {
    return AnimatedBuilder(
        animation: pageController1!,
        builder: (builder, child) {
          double value = 1.0;
          if (pageController1!.position.haveDimensions) {
            value = pageController1!.page! - index;
            value = (1 - (value.abs() * 0.30)).clamp(0.75, 1.0);
          }
          return Center(
              child: SizedBox(
                  height: Curves.easeOut.transform(value) * 300,
                  width: 230,
                  child: child));
        },
        child: DecoContainer(
          model: albumModel,
          imageUrl: item[index].images![0].url,
          title: item[index].name!,
          artist: item[index].totalTracks.toString() + ' Tracks',
        ));
  }

  builder2(int index) {
    return AnimatedBuilder(
        animation: pageController2!,
        builder: (builder, child) {
          double value = 1.0;
          if (pageController2!.position.haveDimensions) {
            value = pageController2!.page! - index;
            value = (1 - (value.abs() * 0.30)).clamp(0.75, 1.0);
          }
          return new Center(
              child: new SizedBox(
                  height: Curves.easeOut.transform(value) * 300,
                  width: 230,
                  child: child));
        },
        child: DecoContainer(
          model: categoryModel,
          imageUrl: categoryList[index].icons![0].url,
          title: categoryList[index].name!,
          artist: '',
        ));
  }

  builder3(int index) {
    return AnimatedBuilder(
        animation: pageController3!,
        builder: (builder, child) {
          double value = 1.0;
          if (pageController3!.position.haveDimensions) {
            value = pageController3!.page! - index;
            value = (1 - (value.abs() * 0.30)).clamp(0.75, 1.0);
          }
          return new Center(
              child: new SizedBox(
                  height: Curves.easeOut.transform(value) * 300,
                  width: 230,
                  child: child));
        },
        child: DecoContainer(
          model: artistModel,
          imageUrl: artistList[index].images![0].url,
          title: artistList[index].name!,
          artist: artistList[index].type,
        ));
  }
}
