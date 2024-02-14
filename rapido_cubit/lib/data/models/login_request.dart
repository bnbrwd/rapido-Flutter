import 'dart:convert';

import 'package:flutter/material.dart';

LoginRequest welcomeFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String welcomeToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest with ChangeNotifier {
  LoginRequest({
    required this.phone,
    required this.countryCode,
  });

  String phone;
  String countryCode;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        phone: json["phone"],
        countryCode: json["countryCode"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "countryCode": countryCode,
      };
}
