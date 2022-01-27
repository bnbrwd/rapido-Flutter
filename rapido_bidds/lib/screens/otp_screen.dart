import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatefulWidget {
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with TickerProviderStateMixin {
// logic to validate otp return [null] when success else error [String]
  // Future<String> validateOtp(String otp) async {
  //   await Future.delayed(Duration(milliseconds: 2000));
  //   if (otp == "1234") {
  //     return null;
  //   } else {
  //     return "The entered Otp is wrong";
  //   }
  // }

  // action to be performed after OTP validation is success
  // void moveToNextScreen(context) {
  //   Navigator.push(context, MaterialPageRoute(
  //       builder: (context) => SuccessfulOtpScreen()));
  // }

  var mobileNumber = '9887246792';

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

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
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
                child: OTPTextField(
                  length: 6,
                  width: width * 0.91,
                  fieldWidth: width * 0.109,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                ),
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
                    foregroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(32, 33, 34, 1)),
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: height * 0.03),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
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
