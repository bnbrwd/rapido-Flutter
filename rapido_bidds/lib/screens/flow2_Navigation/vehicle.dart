import 'package:flutter/material.dart';

class Vehicle extends StatefulWidget {
  static const routeName = '/VehiclelistScreen';
  @override
  _VehiclelisrScreenState createState() => _VehiclelisrScreenState();
}

class _VehiclelisrScreenState extends State<Vehicle> {
  var size, height, width, statusBarHeight;

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: width * 0.044,
            right: width * 0.044,
            top: height * 0.056,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset('assets/image/eclipse.png'),
                          ),
                          Positioned(
                            top: height * 0.02,
                            left: width * 0.04,
                            child: Image.asset('assets/image/Vector.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            child: Image.asset('assets/image/eclipse.png'),
                            onTap: () {},
                          ),
                        ),
                        Positioned(
                          top: height * 0.02,
                          left: width * 0.04,
                          child: GestureDetector(
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/image/Vector1.png',
                                  // height: height * 0.005,
                                  // width: width * 0.064,
                                ),
                                SizedBox(height: height * 0.005),
                                Image.asset(
                                  'assets/image/Vector1.png',
                                  // height: height * 0.032,
                                  // width: width * 0.064,
                                  // height: height * 0.005,
                                ),
                                SizedBox(height: height * 0.005),
                                Image.asset(
                                  'assets/image/Vector1.png',
                                  // height: height * 0.032,
                                  // width: width * 0.064,
                                  // height: height * 0.005,
                                )
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * (24 / 640)),
            ],
          ),
        ),
      ),
    );
  }
}
