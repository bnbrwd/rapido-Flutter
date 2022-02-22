import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapido_cubit/cubit/login_cubit.dart';
import 'package:rapido_cubit/presentation/screens/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //async means always return future

  var size, height, width, statusBarHeight;
  final _textEditController = TextEditingController();
  var _colorItem = false;
  var _validateInputText = false;
  // late String _phone;

  @override
  void initState() {
    super.initState();
  }

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

  var _formKey = GlobalKey<FormState>();

  void validate() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushNamed(OTPScreen.routeName);
      print('validated');
    } else {
      print('Not Validated');
    }
  }

  bool str = true;

  String getValidationMsg() {
    if (str) {
      return '';
    } else {
      return 'Invalid';
    }
  }

  Widget getAndroidForm() {
    return TextFormField(
      onChanged: (_) => _checkValidation(),
      controller: _textEditController,

      maxLength: 10,
      decoration: InputDecoration(
          errorStyle: TextStyle(
              color: _colorItem
                  ? Color.fromRGBO(96, 173, 156, 1)
                  : Color.fromRGBO(230, 57, 70, 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: !_colorItem
                  ? BorderSide(color: Colors.grey)
                  : BorderSide(color: Colors.green)),
          counter: SizedBox.shrink(),
          prefixIcon: SizedBox(
            width: width * 0.075,
            height: height * 0.0375,
            child: Center(
              child: Text(
                '+91',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          labelText: 'Phone number',
          // hintText: 'Phone number',
          labelStyle:
              TextStyle(color: !_colorItem ? Colors.grey : Colors.green),
          border: OutlineInputBorder()),
      keyboardType: TextInputType.number,
      // onSaved: (input) => _phone = input.toString(),
    );
  }

  Widget getiOSForm() {
    return Container(
      height: height * 0.087,
      width: width * 0.911,
      child: CupertinoTextField(
        onChanged: (_) => _checkValidation(),
        controller: _textEditController,
        maxLength: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: !_colorItem
              ? Border.all(color: Colors.grey)
              : Border.all(color: Colors.green),
        ),
        prefix: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            width: width * 0.075,
            height: height * 0.0375,
            child: Center(
              child: Text(
                '+91',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        placeholder: 'Phone number',
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _getAndroidButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: _colorItem
            ? MaterialStateProperty.all(Colors.yellow[600])
            : MaterialStateProperty.all(Colors.grey[400]),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
      child: Text(
        'Verify',
        style: TextStyle(fontSize: 16),
      ),
      onPressed: () {
        if (_colorItem) {
          final _phone = _textEditController.text.toString();
          print('ph-----------  ${_textEditController.text.toString()}');
          BlocProvider.of<LoginCubit>(context).fetchLogin(_phone);
          Navigator.of(context).pushNamed(OTPScreen.routeName);
        } else {
          setState(() {
            _validateInputText = true;
          });
        }
      },
    );
  }

  Widget _getiOSButton() {
    return CupertinoButton(
        color: _colorItem ? Colors.yellow[600] : Colors.grey[400],
        child: Text(
          'Verify',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        onPressed: () {
          if (_colorItem) {
            // userViewModel.getUserLogin();
            Navigator.of(context).pushNamed(OTPScreen.routeName);
          } else {
            setState(() {
              _validateInputText = true;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    var padding2 = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: height * 0.075),
          Platform.isIOS
              ? Text(
                  'Login to your account',
                  style: TextStyle(fontSize: 25),
                )
              : Text(
                  'Login to your account',
                  style: Theme.of(context).textTheme.headline6,
                ),
          SizedBox(height: height * 0.04),
          Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Platform.isIOS ? getiOSForm() : getAndroidForm(),
              ),
            ],
          ),
          SizedBox(height: height * 0.006),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'OTP will be sent to this number',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                textAlign: TextAlign.start,
              ),
              _validateInputText
                  ? Text(
                      'Invalid',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.start,
                    )
                  : Text(''),
            ],
          ),
          SizedBox(height: height * 0.198),
          SizedBox(
              width: double.infinity,
              height: height * 0.075,
              child: Platform.isIOS
                  ? _getiOSButton()
                  : _getAndroidButton(context)),
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: padding2,
          )
        : MaterialApp(
            home: Scaffold(
              body: padding2,
            ),
          );
  }
}
