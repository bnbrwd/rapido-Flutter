import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/screens/flow2_Navigation/onboarding_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(GoogleLiveLocation());

class GoogleLiveLocation extends StatelessWidget {
  static const routeName = '/GoogleLiveLocation';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Map Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var size, height, width, statusBarHeight;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  // 23.4110039,85.3392768

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(23.4110039, 85.3392768),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        // await DefaultAssetBundle.of(context).load("assets/image/car_icon.png");
        await DefaultAssetBundle.of(context).load("assets/image/Group2365.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  // will only runs when this page first load.
  @override
  void didChangeDependencies() {
    getPermission();
    super.didChangeDependencies();
  }

  Future<Void> getPermission() async {
    var status = await Permission.location.status;
    print('status${status}');
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // getting the size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          // height: height * 1,
          child: Stack(
            children: <Widget>[
              Container(
                height: height * 1,
                child: GoogleMap(
                  // mapType: MapType.hybrid,
                  mapType: MapType.normal,
                  initialCameraPosition: initialLocation,
                  markers: Set.of((marker != null) ? [marker] : []),
                  circles: Set.of((circle != null) ? [circle] : []),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                ),
              ),
              Positioned(
                child: Container(
                  margin: EdgeInsets.only(
                      left: width * (16 / 360),
                      top: height * (36 / 640),
                      right: width * (16 / 360)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('assets/image/Group606.png'),
                      Image.asset('assets/image/Group1516.png'),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: height * (439 / 640),
                // bottom: 0,
                child: Container(
                  // color: Colors.white,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  height: height * (185 / 640),
                  // margin: EdgeInsets.only(left: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              left: width * (16 / 360),
                              top: height * (16 / 640),
                            ),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Color.fromRGBO(255, 235, 54, 1),
                                  child: ClipRect(
                                    child: Image.asset(
                                      'assets/image/auto.png',
                                      height: height * 0.03,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: width * (24 / 360),
                                      top: height * (3 / 640)),
                                  child: Text(
                                    'Local auto',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(
                            //     top: height * (16 / 640),
                            //     right: width * (12 / 360)),
                            child: IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              left: width * (16 / 360),
                              top: height * (8 / 640),
                            ),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Color.fromRGBO(255, 235, 54, 1),
                                  child: ClipRect(
                                    child: Image.asset(
                                      'assets/image/taxi.png',
                                      height: height * 0.025,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: width * (24 / 360),
                                      top: height * (3 / 640)),
                                  child: Text(
                                    'Local taxi',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(
                            //     top: height * (8 / 640), right: width * (12 / 360)),
                            child: IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              left: width * (16 / 360),
                              top: height * (8 / 640),
                            ),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Color.fromRGBO(255, 235, 54, 1),
                                  child: ClipRect(
                                    child: Image.asset(
                                      'assets/image/car1.png',
                                      height: height * 0.018,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: width * (24 / 360),
                                      top: height * (3 / 640)),
                                  child: Text(
                                    'Inter city',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // margin: EdgeInsets.only(
                            //     top: height * (8 / 640), right: width * (12 / 360),),
                            child: IconButton(
                              icon: Icon(Icons.info_outline),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.location_searching),
      //     onPressed: () {
      //       getCurrentLocation();
      //     }),
    );
  }
}
