import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('hello'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/image/cross.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 50),
            Image.asset(
              'assets/image/rapido_Logo.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            // Image.asset(
            //   'assets/image/verify.png',
            //   fit: BoxFit.cover,
            // ),
            Text('Splash screen with logo',
                style: Theme.of(context).textTheme.headline6),
          ],
        ),
      ),
    );
  }
}
