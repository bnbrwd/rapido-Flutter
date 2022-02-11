import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );
  }
}
