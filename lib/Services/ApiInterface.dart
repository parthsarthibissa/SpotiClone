import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spoticlone/Services/ApiService.dart';

class ApiInterface {
  ApiService apiService = ApiService();

  Future<Map<String, dynamic>> getNewAlbums(String token) async {
    return apiService.getData('/browse/new-releases', true,token);
  }
}
