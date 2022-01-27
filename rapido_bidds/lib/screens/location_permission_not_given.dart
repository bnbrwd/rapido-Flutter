import 'package:flutter/material.dart';

class LocationPermissionNotGiven extends StatefulWidget {
  @override
  State<LocationPermissionNotGiven> createState() =>
      _LocationPermissionNotGivenState();
}

class _LocationPermissionNotGivenState
    extends State<LocationPermissionNotGiven> {
  var size, height, width, statusBarHeight;

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('kk'),
      // ),
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
                  Container(
                    // child: GestureDetector(
                    //   child: Image.asset('assets/image/eclipse.png'),
                    //   onTap: () {},
                    // ),
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
                            child: Image.asset('assets/image/Vector.png'),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // child: GestureDetector(
                    //   child: Image.asset('assets/image/eclipse.png'),
                    //   onTap: () {},
                    // ),
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
                            child: Image.asset(
                              'assets/image/drwer.png',
                              height: height * 0.023,
                              width: width * 0.051,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Let\'s get to know',
                  style: TextStyle(
                    color: Color.fromRGBO(32, 33, 34, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: height * 0.0375),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'What\'s your name',
                  style: TextStyle(
                    color: Color.fromRGBO(32, 33, 34, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: height * 0.012),
              TextFormField(
                // onChanged: (_) => _checkValidation(),
                // controller: _textEditController,
                // maxLength: 10,
                decoration: InputDecoration(
                  // labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: height * 0.025),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'What\'s your city',
                  style: TextStyle(
                    color: Color.fromRGBO(32, 33, 34, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: height * 0.012),
              TextFormField(
                // onChanged: (_) => _checkValidation(),
                // controller: _textEditController,
                // maxLength: 10,
                decoration: InputDecoration(
                  // labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: height * (31 / 640)),
              SizedBox(
                width: double.infinity,
                height: height * (48 / 640),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(249, 216, 21, 1),
                    ),
                    foregroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(32, 33, 34, 1)),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
