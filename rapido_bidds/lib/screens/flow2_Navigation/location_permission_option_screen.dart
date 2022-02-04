import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class LocationPermissionUptionScreen extends StatelessWidget {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
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
                      Image.asset('assets/image/Group606.png'),
                      Image.asset('assets/image/Group1516.png'),
                    ],
                  ),
                  SizedBox(height: height * 0.053),
                  Center(
                    child: Image.asset('assets/image/locationDenied.png'),
                  ),
                  SizedBox(height: height * 0.048),
                  Center(
                    child: Text(
                      'Oops!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: height * 0.018),
                  Center(
                    child: Text(
                      'Seems like you have denied location access',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(115, 115, 115, 1)),
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  Center(
                    child: Text(
                      'We cannot proceed without permission',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(255, 0, 0, 1)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.24),
            Container(
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.only(
                      left: width * 0.044,
                      top: height * 0.025,
                      right: width * 0.044,
                      bottom: height * 0.025),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(254, 204, 9, 1)),
                      foregroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(32, 33, 34, 1)),
                    ),
                    child: Text(
                      'Give Permission',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            // FooterView(children: children, footer: footer)
          ],
        ),
      ),
    );
  }
}
