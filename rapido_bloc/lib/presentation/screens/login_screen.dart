// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rapido_bloc/bloc/login_bloc.dart';
import 'package:rapido_bloc/constant/strings.dart';
import 'package:rapido_bloc/presentation/screens/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //async means always return future

  var size, height, width, statusBarHeight;
  final _textEditController = TextEditingController();
  // var _colorItem = false;
  // var _validateInputText = false;
  // late String _phone;

  @override
  void initState() {
    super.initState();
  }

  // void _checkValidation() {
  //   if (_textEditController.text.length >= 10) {
  //     setState(() {
  //       _colorItem = true;
  //     });
  //   } else {
  //     setState(() {
  //       _colorItem = false;
  //     });
  //   }
  // }

  var _formKey = GlobalKey<FormState>();

  void validate() {
    if (_formKey.currentState!.validate()) {
      // Navigator.of(context).pushNamed(OTPScreen.routeName);
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

  Widget getAndroidForm(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<String>(
        //here we will listen loginEmail to check updation using getter
        stream: bloc.phoneNumber,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: bloc.changePhoneNumber,
            controller: _textEditController,
            maxLength: 10,
            decoration: InputDecoration(
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                errorStyle: TextStyle(
                  color:
                      snapshot.hasError ? Color(0xFFE63946) : Color(0xFF60AD9C),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: snapshot.hasError
                        ? BorderSide(color: Color(0xFF9E9E9E))
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
                label: Text(
                  'Phone number',
                  style: TextStyle(
                    color: snapshot.hasError ? Colors.red : Colors.green,
                  ),
                ),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          );
        });
  }

  Widget getiOSForm(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Container(
      height: height * 0.087,
      width: width * 0.911,
      child: StreamBuilder<String>(
          stream: bloc.phoneNumber,
          builder: (context, snapshot) {
            return CupertinoTextField(
              onChanged: bloc.changePhoneNumber,
              controller: _textEditController,
              maxLength: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: snapshot.hasError
                    ? Border.all(color: Colors.red)
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
            );
          }),
    );
  }

  Widget _getAndroidButton(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<String>(
        stream: bloc.phoneNumber,
        builder: (context, snapshot) {
          // return ElevatedButton(
          //   style: ButtonStyle(
          //     backgroundColor: snapshot.hasError
          //         ? MaterialStateProperty.all(Colors.grey[400])
          //         : MaterialStateProperty.all(!snapshot.hasData
          //             ? Colors.grey[400]
          //             : Colors.yellow[600]),
          //     foregroundColor: MaterialStateProperty.all(Colors.black),
          //   ),
          //   child: Text(
          //     'Verify',
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onPressed: snapshot.hasError || !snapshot.hasData
          //       ? null
          //       : () {
          //           final _phone = _textEditController.text.toString();
          //           print(
          //               'ph-----------  ${_textEditController.text.toString()}');
          //           BlocProvider.of<LoginBloc>(context)
          //               .add(LoginEventRequested(phone: _phone));
          //           Navigator.of(context).pushNamed(OTP_SCREEN_ROUTE);
          //         },
          // );
          return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: snapshot.hasError
                  ? MaterialStateProperty.all(Colors.grey[400])
                  : MaterialStateProperty.all(!snapshot.hasData
                      ? Colors.grey[400]
                      : Colors.yellow[600]),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: Text(
              'Verify',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: snapshot.hasError || !snapshot.hasData
                ? null
                : () {
                    final _phone = _textEditController.text.toString();
                    print(
                        'ph-----------  ${_textEditController.text.toString()}');
                    BlocProvider.of<LoginBloc>(context)
                        .add(LoginEventRequested(phone: _phone));
                    // Navigator.of(context).pushNamed(OTP_SCREEN_ROUTE);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTPScreen()));
                  },
          );
        });
  }

  Widget _getiOSButton(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<String>(
      stream: bloc.phoneNumber,
      builder: (context, snapshot) {
        return CupertinoButton(
          color: snapshot.hasError ? Colors.grey[400] : Colors.yellow[600],
          child: Text(
            'Verify',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          onPressed: snapshot.hasError
              ? null
              : () {
                  Navigator.of(context).pushNamed(OTPScreen.routeName);
                },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of<LoginBloc>(context, listen: false);
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
                child: Platform.isIOS
                    ? getiOSForm(context)
                    : getAndroidForm(context),
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
            ],
          ),
          SizedBox(height: height * 0.198),
          SizedBox(
              width: double.infinity,
              height: height * 0.075,
              child: Platform.isIOS
                  ? _getiOSButton(context)
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
