import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/location_permission_given.dart';
import 'package:flutter_complete_guide/screens/location_permission_not_given.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapido Screen',
      home: SplachScreen(),
      // home: LocationPermissionGiven(),
      // home: LocationPermissionNotGiven(),
      debugShowCheckedModeBanner: false,
    );
  }
}
