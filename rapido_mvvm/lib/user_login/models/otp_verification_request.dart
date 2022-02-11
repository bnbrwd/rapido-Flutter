// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:flutter/material.dart';
import 'dart:convert';

OtpVerificationRequest welcomeFromJson(String str) =>
    OtpVerificationRequest.fromJson(json.decode(str));

String welcomeToJson(OtpVerificationRequest data) => json.encode(data.toJson());

class OtpVerificationRequest with ChangeNotifier{
  OtpVerificationRequest({
    @required this.token,
    @required this.otp,
  });

  String token;
  String otp;

  factory OtpVerificationRequest.fromJson(Map<String, dynamic> json) =>
      OtpVerificationRequest(
        token: json["token"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "otp": otp,
      };
}
