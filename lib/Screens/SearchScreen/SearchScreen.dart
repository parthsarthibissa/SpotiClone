// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Models/SearchResultModel.dart';
import 'package:spoticlone/Screens/HomeScreen/widgets/DecoContainer.dart';
import 'package:spoticlone/Services/ApiInterface.dart';

class SearchScreen extends StatefulWidget {
  final String? token;
  SearchScreen({required this.token});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textEditingController = TextEditingController();
  SearchResults? searchResults;
  List<AlbumElement>? albums = [];
  List<TracksItem>? tracks = [];
  List<EpisodesItem>? episodes = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.search,
                    color: ApplicationColors.mainGreen,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Hero(
              tag: 'Search',
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: TextFormField(
                  controller: textEditingController,
                  onFieldSubmitted: (query) {
                    ApiInterface()
                        .getSearchedItem(widget.token!, query)
                        .then((value) {
                      setState(() {
                        searchResults = SearchResults.fromJson(value);
                        albums = searchResults!.albums!.items!;
                        tracks = searchResults!.tracks!.items!;
                        episodes = searchResults!.episodes!.items!;
                      });
                    });
                  },
                  onChanged: (query) {
                    ApiInterface()
                        .getSearchedItem(widget.token!, query)
                        .then((value) {
                      setState(() {
                        searchResults = SearchResults.fromJson(value);
                        albums = searchResults!.albums!.items!;
                        tracks = searchResults!.tracks!.items!;
                        episodes = searchResults!.episodes!.items!;
                      });
                      print('sadsadasd' + tracks.toString());
                    });
                  },
                  onSaved: (query) {
                    ApiInterface()
                        .getSearchedItem(widget.token!, query!)
                        .then((value) {
                      setState(() {
                        searchResults = SearchResults.fromJson(value);
                        albums = searchResults!.albums!.items!;
                        tracks = searchResults!.tracks!.items!;
                        episodes = searchResults!.episodes!.items!;
                      });
                      print('sadsadasd' + tracks.toString());
                    });
                  },
                  decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.white,
                      hintText: 'Search '),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
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
                          'Album Results',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
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
                      itemCount: albums!.length,
                      itemBuilder: (builder, index) {
                        return DecoContainer(
                          model: searchResults!.albums,
                          imageUrl: albums![index].images![0].url,
                          title: albums![index].name!,
                          artist: albums![index].artists![index].name!,
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
                          Icons.album,
                          color: ApplicationColors.mainGreen,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Track Results',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
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
                      itemCount: tracks!.length,
                      itemBuilder: (builder, index) {
                        return DecoContainer(
                          model: searchResults!.tracks,
                          imageUrl: tracks![index].album!.images![index].url,
                          title: tracks![index].name!,
                          artist: tracks![index].artists![index].name!,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
