// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io' show Platform;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:rapido_bloc/bloc/login_bloc.dart';
import 'package:rapido_bloc/bloc/otp_verify_bloc.dart';
import 'package:rapido_bloc/presentation/screens/location_permission_given.dart';

class OTPScreen extends StatefulWidget {
  static const routeName = '/otp_screen';

  const OTPScreen({Key? key}) : super(key: key);
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with TickerProviderStateMixin {
  var mobileNumber = '8951528560';

  var size, height, width, statusBarHeight;
  late AnimationController controller;

  late String _token;

  bool isValid = false;
  final navigatorKey = GlobalKey<NavigatorState>();

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

  // didChangeDependencies it always runs when page is open though
  @override
  void didChangeDependencies() {
    //runs before build is executed
    super.didChangeDependencies();
  }

  late Timer _timer;
  int _start = 30;
  var _resend = true;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
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
        title: const Text('An Error Occured!'),
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
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          print('d------${state.loginResponse.data.token}');
          _token = state.loginResponse.data.token;
        }
      },
      builder: (context, state) {
        return Localizations(
          locale: const Locale('en', 'US'),
          delegates: <LocalizationsDelegate<dynamic>>[
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
          ],
          child: Platform.isIOS
              ? Scaffold(
                  body: singleChildScrollView(context),
                )
              : Scaffold(
                  body: singleChildScrollView(context),
                ),
        );
      },
    );
  }

  Widget singleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
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
                'We have sent an OTP to $mobileNumber',
                style: TextStyle(
                  color: Color.fromRGBO(158, 158, 158, 1),
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: height * 0.009),
            Align(
              alignment: Alignment.centerLeft,
              child: Platform.isIOS
                  ? getOtpTextField(context)
                  : getOtpTextField(context),
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
              child: BlocConsumer<OtpVerifyBloc, OtpVerifyState>(
                listener: (context, state) {
                  if (state is! OtpVerifySuccess) {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print('k-----${state.otpVerificationResponse.message}');
                    if (state.otpVerificationResponse.message == 'success') {
                      setState(() {
                        isValid = true;
                      });
                    }
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    key: const Key('tapotpverify'),
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
                    // onPressed: () {
                    //   if (!isValid) {
                    //     _showErrorDialog(context, 'Not Valid');
                    //   } else {
                    //     // Navigator.of(context)
                    //     //     .pushNamed(LocationPermissionGiven.routeName);
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 LocationPermissionGiven()));
                    //   }
                    // },
                    onPressed: () {
                      if (mounted) {
                        Navigator.pushReplacement(
                            navigatorKey.currentContext!,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LocationPermissionGiven()));
                      } else {
                        Navigator.pushReplacement(
                            navigatorKey.currentContext!,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LocationPermissionGiven()));
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LocationPermissionGiven()));

                      // Navigator.of(context, rootNavigator: true).pop();
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             LocationPermissionGiven()));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getOtpTextField(BuildContext context) {
    return OTPTextField(
      key: const Key('otpentered'),
      length: 6,
      width: width * 0.91,
      fieldWidth: width * 0.109,
      style: TextStyle(fontSize: 17),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        final otp = pin;
        BlocProvider.of<OtpVerifyBloc>(context)
            .add(OtpVerifyEventRequested(otp: otp, token: _token));
        print("Completed: " + otp);
      },
      onChanged: (pin) {
        final otp = pin;
        BlocProvider.of<OtpVerifyBloc>(context)
            .add(OtpVerifyEventRequested(otp: otp, token: _token));
        print("Changed: " + pin);
      },
    );
  }
}
