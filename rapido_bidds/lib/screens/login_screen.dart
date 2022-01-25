import 'package:flutter/material.dart';
import '../screens/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  _navigateToLoginScreen() async {
    await Future.delayed(Duration(seconds: 1), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OTPScreen()));
  }

  var size, height, width, statusBarHeight;

  final _textEditController = TextEditingController();

  var _colorItem = false;

  void _checkValidation() {
    if (_textEditController.text.length >= 10) {
      setState(() {
        _colorItem = true;
      });
    } else {
      setState(() {
        _colorItem = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                'Login to your account',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 25),
              Column(
                children: <Widget>[
                  TextFormField(
                    // initialValue: '+91',
                    onChanged: (_) => _checkValidation(),
                    controller: _textEditController,
                    // maxLength: 10,
                    decoration: InputDecoration(
                      prefixIcon: SizedBox(
                        width: 50,
                        child: Center(
                          child: Text(
                            '+91',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      labelText: 'Phone number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'OTP will be sent to this number',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 200),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: _colorItem
                        ? MaterialStateProperty.all(Colors.yellow[600])
                        : MaterialStateProperty.all(Colors.grey[400]),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text('Verify'),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
