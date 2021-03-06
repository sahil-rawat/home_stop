import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_stop/Screens/input_page.dart';
import 'package:home_stop/Screens/shop_page.dart';
import 'package:home_stop/coffee_model.dart';
import 'package:home_stop/Screens/chatscreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

// ignore: must_be_immutable
class Shopping extends StatefulWidget {
  static const String id = 'Shopping';
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 756f0b8b10a869b6236f2c6dd1a1063d307e8ffa
  Shopping({
    Key key,
    this.email,
    this.name,
<<<<<<< HEAD
    this.logout,
    this.Sign_out_google,
  }) : super(key: key);
  final String email;
  final String name;
  final bool logout;
  final Function Sign_out_google;
=======
    this.Latitude,
    this.Longitude,
  }) : super(key: key);
=======
  Shopping({Key key, this.email, this.name}) : super(key: key);
>>>>>>> 182c7f8b5ca1d9f8e0e5d186ff46dc49a0ba1e29
  final String email;
  final String name;
  double Latitude;
  double Longitude;
>>>>>>> 756f0b8b10a869b6236f2c6dd1a1063d307e8ffa
  //include this
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping>
    with SingleTickerProviderStateMixin {
  @override
  PageController _pageController;
  Completer<GoogleMapController> _controller = Completer();
  double zoomVal = 5.0;
  int prevPage;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;


  @override
  void initState() {
    super.initState();
    getCurrentUser();

    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Center(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onLongPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopPage(
                        thumbnail: coffeeShops[index].thumbNail,
                        name: coffeeShops[index].shopName,
<<<<<<< HEAD
                        Phoneno: coffeeShops[index].Phoneno,
                        index: index,
                        email: widget.email,
                        dashboardname: widget.name,
                        logout: widget.logout,
=======
                        index: index,
>>>>>>> 756f0b8b10a869b6236f2c6dd1a1063d307e8ffa
                      ),
                    ),
                  );
                },
                onTap: () {
                  _gotoLocation(
                      coffeeShops[index].lat, coffeeShops[index].long);
                },
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                            height: 90.0,
                            width: 85.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      coffeeShops[index].thumbNail),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coffeeShops[index].shopName,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  coffeeShops[index].address,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ])
                        ]))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getCurrentUser() async {
    try {
      final User = await _auth.currentUser();
      if (User != null) {
        loggedInUser = User;
        print("Logged in as ${loggedInUser.displayName}");
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(22.3072, 73.1812), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(22.3072, 73.1812), zoom: zoomVal)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: debugDefaultTargetPlatformOverride == TargetPlatform.android
            ? 5.0
            : 0.0,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: UserAccountsDrawerHeader(
                accountName: Text(widget.name),
                accountEmail: Text(widget.email),
                currentAccountPicture: new CircleAvatar(
                  child: Text(widget.name[0].toUpperCase()),
                  backgroundColor: Colors.yellow,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: new Text('Share the app'),
                leading: Icon(Icons.share),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.edit_attributes),
                title: new Text('Edit Profile'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.chat),
                title: new Text('Chats'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                loggedInUser: loggedInUser,
                              )));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(FontAwesomeIcons.shoppingCart),
                title: new Text('My Orders'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.settings),
                title: new Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.calendar_today),
                title: new Text('Set Monthly Plan'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            new Divider(
              thickness: 4,
              color: Colors.redAccent,
            ),
            ListTile(
              title: Text('Close'),
              trailing: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
            new Divider(
              thickness: 4,
              color: Colors.redAccent,
            ),
            widget.logout
                ? ListTile(
              title: Text('Log Out'),
              onTap: () {
                widget.Sign_out_google();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Alert"),
                      content: Text("Google Account Logged out"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.pushNamed(context, InputPage.id);
                          },
                        )
                      ],
                    );
                  },
                );
              },
            ):
            ListTile(
              title: Text('Log Out'),
              trailing: Icon(FontAwesomeIcons.signOutAlt),
              onTap: () {
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "ALERT",
                  desc: "Do You Want to Log Out From Your Account",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, InputPage.id);
                        _auth.signOut();
                      },
                      width: 120,
                    )
                  ],
                ).show();
              },
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          Positioned(
            bottom: 15.0,
            child: Container(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: coffeeShops.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _coffeeShopList(index);
                  },
                ),
                width: MediaQuery.of(context).size.width),
          ),
          Container(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Material(
                        elevation: 30,
                        shadowColor: Colors.black54,
                        child: Card(
                          child: TextField(
                            textAlign: TextAlign.center,
                            onChanged: (value) {},
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.shop),
                              fillColor: Colors.white,
                              hintText: "Enter Shop Name",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(22.3072, 73.1812), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 756f0b8b10a869b6236f2c6dd1a1063d307e8ffa
          MahalaxmiMarker,
          ParishramMarker,
          SamsungMarker,
          ApexMarker,
          KrishnaMarker,
<<<<<<< HEAD
=======
=======
          andrewsMarker,
          stumptownMarker,
          thirdrailMarker,
          newyork1Marker,
          newyork2Marker,
>>>>>>> 182c7f8b5ca1d9f8e0e5d186ff46dc49a0ba1e29
>>>>>>> 756f0b8b10a869b6236f2c6dd1a1063d307e8ffa
        },
      ),
    );
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 756f0b8b10a869b6236f2c6dd1a1063d307e8ffa

  Marker MahalaxmiMarker = Marker(
    markerId: MarkerId('Mahalaxmi'),
    position: LatLng(22.309990, 73.181610),
    infoWindow: InfoWindow(title: 'Mahalaxmi Provision Store'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );
  Marker ParishramMarker = Marker(
    markerId: MarkerId('Parishram'),
    position: LatLng(22.302160, 73.175160),
    infoWindow: InfoWindow(title: 'Parishram Electrics'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );
  Marker SamsungMarker = Marker(
    markerId: MarkerId('Samsung Showroom'),
    position: LatLng(22.303270, 73.165670),
    infoWindow: InfoWindow(title: 'Samsung Showroom'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );
<<<<<<< HEAD
=======

>>>>>>> 756f0b8b10a869b6236f2c6dd1a1063d307e8ffa
  Marker ApexMarker = Marker(
    markerId: MarkerId('Apex Dry Fruit Stores'),
    position: LatLng(22.3006, 73.1692),
    infoWindow: InfoWindow(title: 'Apex Dry Fruit Stores'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );
  Marker KrishnaMarker = Marker(
    markerId: MarkerId('Krishna Stationery'),
    position: LatLng(22.3073, 73.1811),
    infoWindow: InfoWindow(title: 'Krishna Stationery'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );
}
<<<<<<< HEAD
=======
=======
}

Marker andrewsMarker = Marker(
  markerId: MarkerId('Mahalaxmi'),
  position: LatLng(22.309990, 73.181610),
  infoWindow: InfoWindow(title: 'Mahalaxmi Provision Store'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker stumptownMarker = Marker(
  markerId: MarkerId('Parishram'),
  position: LatLng(22.302160, 73.175160),
  infoWindow: InfoWindow(title: 'Parishram Electrics'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker thirdrailMarker = Marker(
  markerId: MarkerId('Samsung Showroom'),
  position: LatLng(22.303270, 73.165670),
  infoWindow: InfoWindow(title: 'Samsung Showroom'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//New York Marker

Marker newyork1Marker = Marker(
  markerId: MarkerId('Apex Dry Fruit Stores'),
  position: LatLng(22.3006, 73.1692),
  infoWindow: InfoWindow(title: 'Apex Dry Fruit Stores'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('Krishna Stationery'),
  position: LatLng(22.3073, 73.1811),
  infoWindow: InfoWindow(title: 'Krishna Stationery'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
>>>>>>> 182c7f8b5ca1d9f8e0e5d186ff46dc49a0ba1e29
>>>>>>> 756f0b8b10a869b6236f2c6dd1a1063d307e8ffa
