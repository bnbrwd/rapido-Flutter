import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rapido_cubit/constant/strings.dart';

class NetworkService with ChangeNotifier {
  //OTP API CALL
  Future getUserLoginData(String request) async {
    try {
      final response = await http.post(Uri.parse(LOGIN_URL),
          headers: {"Content-Type": "application/json"},
          body: utf8.encode(request));
      String responseString = response.body;
      print('mob res in networkService == $responseString');
      return response;
    } catch (error) {
      print('error in mob --$error');
      return null;
    }
  }

  // OTP varify api.
  Future getOtpVerify(String request) async {
    try {
      final response = await http.post(Uri.parse(VERIFY_URL),
          headers: {"Content-Type": "application/json"},
          body: utf8.encode(request));
      String responseString = response.body;
      print('Otp res in networkService == $responseString');
      return response;
    } catch (error) {
      print('error in otp --$error');
      return null;
    }
  }
}
