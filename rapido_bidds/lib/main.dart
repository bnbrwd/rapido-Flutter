import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import './screens/location_permission_given.dart';
import './screens/location_permission_not_given.dart';
import './screens/otp_screen.dart';
import './screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Rapido Screen',
            home: SplachScreen(),
            routes: {
              OTPScreen.routeName: (ctx) => OTPScreen(), //registered
              LocationPermissionGiven.routeName: (ctx) =>
                  LocationPermissionGiven(), //registered
              LocationPermissionNotGiven.routeName: (ctx) =>
                  LocationPermissionNotGiven(), //registered
            },
          )
        : MaterialApp(
            title: 'Rapido Screen',
            home: SplachScreen(),
            // home: LocationPermissionNotGiven(),
            // home: LoginScreen(),
            debugShowCheckedModeBanner: false,
            routes: {
              OTPScreen.routeName: (ctx) => OTPScreen(), //registered
              LocationPermissionGiven.routeName: (ctx) =>
                  LocationPermissionGiven(), //registered
              LocationPermissionNotGiven.routeName: (ctx) =>
                  LocationPermissionNotGiven(), //registered
            },
          );
  }
}
