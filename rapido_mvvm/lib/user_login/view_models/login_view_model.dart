import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/user_login/models/login_request.dart';
import 'package:flutter_complete_guide/user_login/models/login_response.dart';
import 'package:flutter_complete_guide/user_login/models/otp_verification_request.dart';
import 'package:flutter_complete_guide/user_login/models/otp_verification_response.dart';
import 'package:flutter_complete_guide/user_login/repo/api_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  bool _loading = false;
  //here _loading means it is private.
  LoginResponse _loginResponse;
  LoginRequest _loginRequest;
  OtpVerificationRequest _otpVerificationRequest;
  OtpVerificationResponse _otpVerificationResponse;
  String _mobileOtp;
  String _msg, _status;

  String get msg => _msg;
  String get status => _status;
  setStatus(String status, String message) async {
    _status = status;
    _msg = message;
  }

  bool get loading => _loading;
  LoginRequest get loginRequest => _loginRequest;
  LoginResponse get loginResponse => _loginResponse;
  String _token;
  OtpVerificationRequest get otpVerificationRequest => _otpVerificationRequest;
  OtpVerificationResponse get otpVerificationResponse =>
      _otpVerificationResponse;

  String _tokenExtracted;
  String get tokenExtracted => _tokenExtracted;
  setTokenExtracted(String token) {
    _tokenExtracted = token;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setLoginRequest(String phone) {
    _loginRequest = new LoginRequest(phone: phone);
  }

  setLoginResponse(LoginResponse loginResponse) {
    _loginResponse = loginResponse;
  }

  String get mobileOtp => _mobileOtp;
  setMobileOtp(String motp) {
    _mobileOtp = motp;
  }

  setOtpVerificationRequest() {
    _otpVerificationRequest =
        new OtpVerificationRequest(token: tokenExtracted, otp: mobileOtp);
  }

  setOtpVerificationResponse(OtpVerificationResponse otpVerificationResponse) {
    _otpVerificationResponse = otpVerificationResponse;
  }

  getUserLogin() async {
    setLoading(true);
    var response = await APIServices.getLoginData(loginRequest);
    if (response != null) {
      print(response.data.token);
      _token = response.data.token;
      final prefs = await SharedPreferences.getInstance(); // storage
      final userToken = json.encode({
        'token': _token,
      });
      prefs.setString('userData', userToken);
      setLoginResponse(response);
    }
    setLoading(false);
    //here we care calling notifyListeners in setLoading so no need to call
    //everywhere because whenever it will be false we will update the ui with the new data
    //because if we use notifyListeners everywhere it affects the performance.
  }

  getTokenGenerated() async {
    final prefs = await SharedPreferences.getInstance();

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    //convert String into Map
    // _token = extractedUserData['token'];
    // print('Token from memory$_token');
    setTokenExtracted(extractedUserData['token']);
  }

  bool _vlidate = false;
  bool get vlidate => _vlidate;
  setValidation(bool vlidate) async {
    print('validation in viewModel----${vlidate}');
    _vlidate = vlidate;
    notifyListeners();
  }

  // void _validateToken() async{
  //   if (msg == 'success' || status == '100') {
  //     setValidation(true);
  //     notifyListeners();
  //   }
  // }

  void _validateToken() async {
    if (msg == 'success' || status == '100') {
      print('reslt-----${msg} ${msg}');
     await setValidation(true);
    }
  }

  getUserOtpVerify(BuildContext context) async {
    setLoading(true);
    await getTokenGenerated();
    await setOtpVerificationRequest();
    // OtpVerificationResponse response =
    //     await APIServices.getVerifyData(otpVerificationRequest);
    OtpVerificationResponse response =
        await Provider.of<APIServices>(context, listen: false)
            .getVerifyData(otpVerificationRequest);
    if (response != null) {
      setStatus(response.status.toString(), response.message);
      // print('reslt-----${response.status.toString()} ${response.message}');
      await _validateToken();
      setOtpVerificationResponse(response);
    }
    setLoading(false);
  }
}
