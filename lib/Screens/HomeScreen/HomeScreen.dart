// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Models/AlbumModel.dart';
import 'package:spoticlone/Models/ArtistModel.dart';
import 'package:spoticlone/Models/CategoryModel.dart';
import 'package:spoticlone/Screens/Elements/AppBar/CustomAppBar.dart';
import 'package:spoticlone/Screens/Elements/BottomPlayBar/BottomPlayBar.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/DecoContainer.dart';
import 'package:spoticlone/Services/ApiInterface.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            CustomAppBar(token: widget.token),
            
            Expanded(
              child: SingleChildScrollView(
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
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'SEE ALL',
                              style: TextStyle(
                                color: ApplicationColors.mainGreen,
                                fontSize: 14,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 255,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: item.length,
                      itemBuilder: (builder, index) {
                        return DecoContainer(
                          model: albumModel,
                          imageUrl: item[index].images![0].url,
                          title: item[index].name!,
                          artist:
                              item[index].totalTracks.toString() + ' Tracks',
                        );
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
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'SEE ALL',
                              style: TextStyle(
                                color: ApplicationColors.mainGreen,
                                fontSize: 14,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 255,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (builder, index) {
                        return DecoContainer(
                          model: categoryModel,
                          imageUrl: categoryList[index].icons![0].url,
                          title: categoryList[index].name!,
                          artist: categoryList[index].id!.toUpperCase(),
                        );
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
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'SEE ALL',
                              style: TextStyle(
                                color: ApplicationColors.mainGreen,
                                fontSize: 14,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 255,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: artistList.length,
                      itemBuilder: (builder, index) {
                        return DecoContainer(
                          model: artistModel,
                          imageUrl: artistList[index].images![0].url,
                          title: artistList[index].name!,
                          artist: artistList[index].type,
                        );
                      },
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
