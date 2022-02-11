import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/user_login/repo/api_services.dart';
import 'package:flutter_complete_guide/user_login/view/location_permission_given.dart';
import 'package:flutter_complete_guide/user_login/view/location_permission_not_given.dart';
import 'package:flutter_complete_guide/user_login/view/otp_screen.dart';
import 'package:flutter_complete_guide/user_login/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        : MultiProvider(
          providers: [
              ChangeNotifierProvider(
                create: (ctx) => APIServices(),
                // now Auth() can be listen in anywhere in application.
              ),
            ],
          child: MaterialApp(
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
            ),
        );
  }
}
