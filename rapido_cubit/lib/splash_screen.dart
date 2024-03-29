import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapido_cubit/presentation/screens/login_screen.dart';

class SplachScreen extends StatefulWidget {
  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  _navigateToLoginScreen() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  var size, height, width, statusBarHeight;

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var continer1 = <Widget>[
      Container(
        margin: EdgeInsets.only(
          left: width * 0.22,
          right: width * 0.22,
          top: height * 0.085,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/image/cross.png',
            height: height * 0.32,
            width: width * 0.55,
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(height: height * 0.068),
      Container(
        margin: EdgeInsets.only(
          left: width * 0.166,
          right: width * 0.166,
        ),
        child: Image.asset(
          'assets/image/rapido_Logo.png',
          fit: BoxFit.cover,
        ),
      ),
    ];

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: Column(
              children: continer1,
            ),
          )
        : Scaffold(
            body: Column(
              children: continer1,
            ),
          );
  }
}
