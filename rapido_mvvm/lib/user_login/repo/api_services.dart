import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/constant.dart';
import '../models/login_request.dart';
import 'package:flutter_complete_guide/user_login/models/login_request.dart' as welcomeToJson;
import '../models/login_response.dart';
import 'package:flutter_complete_guide/user_login/models/login_response.dart' as welcomeFromJson;
import '../models/otp_verification_request.dart';
import 'package:flutter_complete_guide/user_login/models/otp_verification_request.dart' as req;
import '../models/otp_verification_response.dart';
import 'package:flutter_complete_guide/user_login/models/otp_verification_response.dart' as res;

import 'package:http/http.dart' as http;

class APIServices with ChangeNotifier {
  //OTP API CALL
  static  Future<LoginResponse> getLoginData(LoginRequest loginRequest) async {
    var response;
    var request = welcomeToJson.welcomeToJson(loginRequest);
    try {
      response = await http.post(Uri.parse(LOGIN_URL),
          headers: {"Content-Type": "application/json"},
          body: utf8.encode(request));

      if (response != null) {
        String responseString = response.body;
        print(json.decode(responseString));
        // print('res=  ${welcomeFromJson.welcomeFromJson(response.body)}');
        print(responseString);
        // String str = cast<String>(response);
        return welcomeFromJson.welcomeFromJson(responseString);
      } else {
        return null;
      }
    } catch (error) {
      throw error;
    }
  }

  //OTP VALIDATION API CALL

  Future<OtpVerificationResponse> getVerifyData(
      OtpVerificationRequest otpVerificationRequest) async {
    var response;
    var request = req.welcomeToJson(otpVerificationRequest);
    try {
      response = await http.post(Uri.parse(VERIFY_URL),
          headers: {"Content-Type": "application/json"},
          body: utf8.encode(request));

      if (response != null) {
        String responseString = response.body;
        print(json.decode(responseString));
        // print('res=  ${welcomeFromJson.welcomeFromJson(response.body)}');
        print(responseString);
        // String str = cast<String>(response);
        return res.welcomeFromJson(responseString);
      } else {
        return null;
      }
    } catch (error) {
      throw error;
    }
  }
}
