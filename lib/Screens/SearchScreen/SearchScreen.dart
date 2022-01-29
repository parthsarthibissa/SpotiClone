// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';
import 'package:spoticlone/Models/SearchResultModel.dart';
import 'package:spoticlone/Screens/Elements/BottomPlayBar/BottomPlayBar.dart';
import 'package:spoticlone/Screens/Elements/SearchContainer/SearchContainer.dart';
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

  List<Item>? tracks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomPlayBar(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
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

                      tracks = searchResults!.tracks!.items!;
                    });
                  });
                },
                onChanged: (query) {
                  ApiInterface()
                      .getSearchedItem(widget.token!, query)
                      .then((value) {
                    setState(() {
                      searchResults = SearchResults.fromJson(value);

                      tracks = searchResults!.tracks!.items!;
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
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
                  'Search Results',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20, crossAxisSpacing: 10, crossAxisCount: 2),
              shrinkWrap: true,
              itemCount: tracks!.length,
              itemBuilder: (builder, index) {
                return SearchContainer(
                  model: searchResults!.tracks,
                  imageUrl: tracks![index].album!.images![0].url,
                  title: tracks![index].name!,
                  artist: tracks![index].artists![0].name!,
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
