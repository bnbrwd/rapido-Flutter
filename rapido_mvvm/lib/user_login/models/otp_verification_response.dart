// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:flutter/material.dart';
import 'dart:convert';

OtpVerificationResponse welcomeFromJson(String str) => OtpVerificationResponse.fromJson(json.decode(str));

String welcomeToJson(OtpVerificationResponse data) => json.encode(data.toJson());

class OtpVerificationResponse with ChangeNotifier{
    OtpVerificationResponse({
        @required this.data,
        @required this.status,
        @required this.message,
    });

    final Data data;
    final int status;
    final String message;

    factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) => OtpVerificationResponse(
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
        @required this.accessToken,
    });

    final String accessToken;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
    };
}
