// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:spoticlone/Constants/AppColors.dart';

class ApiService {
  final String? baseUrl = 'https://api.spotify.com/v1';

  Future<Map<String, dynamic>> getData(
      String? url, bool? isLoading, String authToken) async {
    final Map<String, String> authHeader = {
      'Authorization': 'Bearer ' + authToken,
      'Content-Type': 'application/json'
    };
    try {
      if (isLoading == true) {
        EasyLoading.show(
            dismissOnTap: false,
            indicator: CircularProgressIndicator(
              color: ApplicationColors.mainGreen,
              backgroundColor: ApplicationColors.mainBlack,
            ));
      }

      final res =
          await http.get(Uri.parse(baseUrl! + url!), headers: authHeader);
      EasyLoading.dismiss();

      print(res);
      return json.decode(res.body);
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  postData() {}
  putData() {}
  deleteData() {}
}
