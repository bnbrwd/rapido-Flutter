import 'package:flutter/material.dart';
import '../flow2_Navigation/onboarding_screen.dart';

class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            OnboardingScreen(),
          ],
        ),
      ),
    );
  }
}
