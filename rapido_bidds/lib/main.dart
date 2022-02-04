import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/samples/googlemap.dart';
import 'package:flutter_complete_guide/screens/flow2_Navigation/google_live_location.dart';
import 'package:flutter_complete_guide/screens/flow2_Navigation/location_permission_option_screen.dart';
import 'package:flutter_complete_guide/screens/flow2_Navigation/vehicle.dart';
import 'package:flutter_complete_guide/screens/flow2_Navigation/vehicle_list_screen.dart';
import './screens/flow2_Navigation/onboarding_screen.dart';
import 'screens/flow1_login/location_permission_given.dart';
import 'screens/flow1_login/location_permission_not_given.dart';
import 'screens/flow1_login/otp_screen.dart';
import 'screens/flow1_login/splash_screen.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Platform.isIOS
    //     ? CupertinoApp(
    //         title: 'Rapido Screen',
    //         home: SplachScreen(),
    //         routes: {
    //           OTPScreen.routeName: (ctx) => OTPScreen(), //registered
    //           LocationPermissionGiven.routeName: (ctx) =>
    //               LocationPermissionGiven(), //registered
    //           LocationPermissionNotGiven.routeName: (ctx) =>
    //               LocationPermissionNotGiven(), //registered
    //         },
    //       )
    //     : MaterialApp(
    //         title: 'Rapido Screen',
    //         home: SplachScreen(),
    //         // home: LocationPermissionNotGiven(),
    //         // home: LoginScreen(),
    //         debugShowCheckedModeBanner: false,
    //         routes: {
    //           OTPScreen.routeName: (ctx) => OTPScreen(), //registered
    //           LocationPermissionGiven.routeName: (ctx) =>
    //               LocationPermissionGiven(), //registered
    //           LocationPermissionNotGiven.routeName: (ctx) =>
    //               LocationPermissionNotGiven(), //registered
    //           OnboardingScreen.routeName: (ctx) =>
    //               OnboardingScreen(), //registered
    //         },
    //       );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rapido Screen',
      // home: OnboardingScreen(),
      // home: VehiclelistScreen(),
      // home: GoogleLiveLocation(),
      home: LocationPermissionUptionScreen(),
      routes: {
        Vehicle.routeName: (ctx) => Vehicle(), //registered
        OnboardingScreen.routeName: (ctx) => OnboardingScreen(), //registered
      },
    );
  }
}
