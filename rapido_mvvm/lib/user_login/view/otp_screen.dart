import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/components/app_loading.dart';
import 'package:flutter_complete_guide/user_login/view/location_permission_given.dart';
import 'package:flutter_complete_guide/user_login/view_models/login_view_model.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  static const routeName = '/otpscreen';
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with TickerProviderStateMixin {
  UserViewModel userViewModel;

  var mobileNumber = '8951528560';
  var _otp;

  var size, height, width, statusBarHeight;
  AnimationController controller;

  @override
  void initState() {
    startTimer();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
    userViewModel = new UserViewModel();
  }

  // didChangeDependencies it always runs when page is open though
  @override
  void didChangeDependencies() {
    //runs before build is executed
    super.didChangeDependencies();
  }

  Timer _timer;
  int _start = 30;
  var _resend = true;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _resend = false;
          });
        } else {
          setState(() {
            _start -= 1;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  // Future<void> _getTokenGenerated() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   final extractedUserData =
  //       json.decode(prefs.getString('userData')) as Map<String, Object>;
  //   //convert String into Map
  //   _token = extractedUserData['token'];
  //   print(_token);
  // }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okey'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    // otpVerificationRequest.token = _token;
    // userViewModel.getUserOtpVerify();
    // _getTokenGenerated();
    // userViewModel.setTokenExtracted(_token);

    var _otpTextField = OTPTextField(
      length: 6,
      width: width * 0.91,
      fieldWidth: width * 0.109,
      style: TextStyle(fontSize: 17),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        _otp = pin;
        userViewModel.setMobileOtp(_otp);
        // userViewModel.getUserOtpVerify();
        print("Completed: " + _otp);
      },
      onChanged: (pin) {
        print("Changed: " + pin);
      },
    );

    var _singleChildScrollView = SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: width * 0.044,
          right: width * 0.044,
          top: height * 0.10,
        ),
        // height: height * 0.075,
        // width: width * 0.91,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter the OTP',
                style: TextStyle(
                  color: Color.fromRGBO(32, 33, 34, 1),
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(height: height * 0.018),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'We have sent an OTP to ${mobileNumber}',
                style: TextStyle(
                  color: Color.fromRGBO(158, 158, 158, 1),
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: height * 0.009),
            Align(
              alignment: Alignment.centerLeft,
              child: Platform.isIOS ? _otpTextField : _otpTextField,
            ),
            SizedBox(height: height * 0.018),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      height: height * 0.025,
                      width: width * 0.050,
                      child: CircularProgressIndicator(
                        value: controller.value,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange),
                        semanticsLabel: 'Linear progress indicator',
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.027,
                    ),
                    Container(
                      child: Text(
                        'Auto verifying',
                        style: TextStyle(
                          color: Color.fromRGBO(158, 158, 158, 1),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: _resend
                      ? Text(
                          'Resend OTP in ${_start}s',
                          style: TextStyle(
                            color: Color.fromRGBO(158, 158, 158, 1),
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.end,
                        )
                      : Text(
                          'Resend OTP Now',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 10, 255, 1),
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.end,
                        ),
                ),
              ],
            ),
            SizedBox(height: height * 0.203),
            SizedBox(
              width: double.infinity,
              height: height * 0.07,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(249, 216, 21, 1)),
                  foregroundColor:
                      MaterialStateProperty.all(Color.fromRGBO(32, 33, 34, 1)),
                ),
                child: Text(
                  'Verify',
                  style: TextStyle(fontSize: height * 0.03),
                ),
                onPressed: () {
                  userViewModel.getUserOtpVerify(context);
                  print('validation----${!userViewModel.vlidate}');
                  if (!userViewModel.vlidate) {
                    Navigator.of(context)
                        .pushNamed(LocationPermissionGiven.routeName);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: Platform.isIOS
          ? Scaffold(
              body: _singleChildScrollView,
            )
          : Scaffold(
              body: _singleChildScrollView,
            ),
    );
  }
}

/*
return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialize the OTP screen by passing validation logic and route callback
      home: OtpScreen.withGradientBackground(
        topColor: Colors.white,
        bottomColor: Color(0xFF753a88),
        otpLength: 4,
        validateOtp: validateOtp,
        routeCallback: moveToNextScreen,
        themeColor: Colors.white,
        titleColor: Colors.white,
        title: "Phone Number Verification",
        subTitle: "Enter the code sent to \n +919876543210",
        icon: Image.asset(
          'assets/image/rapido_Logo.png',
          fit: BoxFit.fill,
        ),
      ),
    );

    */
