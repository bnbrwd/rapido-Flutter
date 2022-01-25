import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('hello'),
        // ),
        body: Padding(
          padding: EdgeInsets.all(15),
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
                    maxLength: 10,
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
                height: 45,
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
