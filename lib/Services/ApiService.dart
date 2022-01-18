import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String? baseUrl = '';
  Future<Response> getData(String? url) async {
    Response res = await http.get(Uri.parse(baseUrl! + url!));
    return res;
  }

  postData() {}
  putData() {}
  deleteData() {}
}
