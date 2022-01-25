// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.error,
  });

  Error? error;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        error: Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error!.toJson(),
      };
}

class Error {
  Error({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
