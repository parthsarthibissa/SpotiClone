import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spoticlone/Services/ApiService.dart';

class ApiInterface {
  ApiService apiService = ApiService();
  String? ids =
      '6LEG9Ld1aLImEFEVHdWNSB,4PULA4EFzYTrxYvOVlwpiQ,4gdMJYnopf2nEUcanAwstx,45PG2L6Fh2XvYL4ONzpdoW';
  Future<Map<String, dynamic>> getNewAlbums(String token) async {
    return apiService.getData('/browse/new-releases', true, token);
  }

  Future<Map<String, dynamic>> getCategories(String token) async {
    return apiService.getData('/browse/categories', true, token);
  }

  Future<Map<String, dynamic>> getRecommendedArtists(String token) async {
    return apiService.getData('/artists?ids=' + ids!, true, token);
  }

  Future<Map<String, dynamic>> getMyTopTracks(String token) async {
    return apiService.getData('/me/top/tracks', true, token);
  }

  Future<Map<String, dynamic>> getMyTopArtists(String token) async {
    return apiService.getData('/me/top/artists', true, token);
  }

  Future<Map<String, dynamic>> getSearchedItem(
      String token, String query) async {
    return apiService.getData(
        '/search?query=' + query + '&type=track&include_external=audio',
        true,
        token);
  }
}
