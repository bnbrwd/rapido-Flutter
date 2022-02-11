// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

LoginResponse welcomeFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String welcomeToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse with ChangeNotifier{
  LoginResponse({
    this.data,
    this.status,
    this.message,
  });

  Data data;
  int status;
  String message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  Data({
    this.token,
  });

  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
