// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:big_basket/Widgets/appbar.dart';
// import 'package:big_basket/Widgets/drawer.dart';
// import 'package:big_basket/constants/singleton.dart';
// import 'package:big_basket/screens/google_maps/current_location.dart';
// import 'package:big_basket/screens/search/search.dart';
// import 'package:big_basket/constants/apis.dart';
// import 'package:big_basket/constants/constant.dart';
// import 'package:big_basket/main.dart';
// import 'package:big_basket/model_class/cart_model_class.dart';
// import 'package:big_basket/screens/cart_items/cart_items.dart';
// import 'package:big_basket/screens/categories_gridview/categories_list_sublist.dart';
// import 'package:big_basket/screens/categories_gridview/shop_by_categories.dart';
// import 'package:big_basket/screens/homepage.dart';
// import 'package:big_basket/screens/product_list/product_list.dart';
// import 'package:big_basket/screens/recommendation/recommendation_dashboard.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:badges/badges.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'categories_gridview/category_subcategory.dart';
//
// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);
//
//   @override
//   _DashboardState createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   int _selectedIndex = 0;
//   var currentPosition;
//   var currentLocationAddress;
//   var CartLength;
//   static final List<Widget> _widgetOptions = <Widget>[
//     HomePage(),
//     CategorySubCategory(),
//    SearchScreen(),
//  RecommendationDashboard(),
//     CartItem(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     localDataCheckNull();
//
//     getData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//        onWillPop: () async {
//       return handleBack();
//     },
//       child: Scaffold(
//         appBar: PreferredSize(
//             preferredSize: Size.fromHeight(0),
//             child: AppBar(
//               // Here we create one to set status bar color
//               backgroundColor:
//                   themeColor, // Set any color of status bar you want; or it defaults to your theme's primary color
//             )),
//         body: IndexedStack(
//           children: _widgetOptions,
//           index: _selectedIndex,
//           // child: Container(
//           //   child: _widgetOptions.elementAt(_selectedIndex),
//           // ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Image.asset(
//                     "assets/images/bottom_navigation/icons8-home.png",
//                     scale: 1.5,
//                     color: _selectedIndex == 0 ? Colors.green : Colors.white),
//                 //  title: Text('Home'),
//                 backgroundColor: Colors.black,
//
//                 title: Text(
//                   'Home',
//                   style: constantFontStyle(fontSize: 10),
//                 ),
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset("assets/images/bottom_navigation/category.png",
//                     scale: 1.5,
//                     color: _selectedIndex == 1 ? Colors.green : Colors.white),
//                 //    title: Text('Search'),
//                 backgroundColor: Colors.black,
//                 title: Text(
//                   'Categories',
//                   style: constantFontStyle(fontSize: Fontsize),
//                 ),
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset(
//                     "assets/images/bottom_navigation/icons8-search.png",
//                     scale: 1.5,
//                     color: _selectedIndex == 2 ? Colors.green : Colors.white),
//                 //    title: Text('Search'),
//                 backgroundColor: Colors.black,
//                 title: Text(
//                   'Search',
//                   style: constantFontStyle(fontSize: Fontsize),
//                 ),
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset("assets/images/bottom_navigation/list.png",
//                     scale: 1.5,
//                     color: _selectedIndex == 3 ? Colors.green : Colors.white),
//                 //    title: Text('Profile'),
//                 backgroundColor: Colors.black,
//                 title: Text(
//                   'Products',
//                   style: constantFontStyle(fontSize: Fontsize),
//                 ),
//               ),
//               // BottomNavigationBarItem(
//               //   icon: Image.asset(
//               //       "assets/images/bottom_navigation/shopping-basket.png",
//               //       scale: 1.5,
//               //       color: _selectedIndex == 4 ? Colors.green : Colors.white),
//               //   //    title: Text('Profile'),
//               //   backgroundColor: Colors.black,
//               //   title: Text(
//               //     'Cart',
//               //     style: constantFontStyle(fontSize: Fontsize),
//               //   ),
//               // ),
//                       BottomNavigationBarItem(
//                         icon:   Padding(
//                       padding:  EdgeInsets.symmetric(horizontal: 5),
//               child: Badge(
//
//                       position: BadgePosition.bottomStart(bottom: 6, start: 15),
//                   //    animationDuration: Duration(milliseconds: 300),
//                   //    animationType: BadgeAnimationType.slide,
//                       badgeColor: Colors.redAccent,
//                    //   toAnimate: true,
//                       badgeContent: itemsNotifier.value.toString() == "[]"?Text(
//                         CartLength??"0",
//                         style: TextStyle(
//                             fontSize: 8,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ):ValueListenableBuilder(
//       valueListenable: itemsNotifier,
//       builder: (context, items, _) {
//         return Text(
//          itemsNotifier.value.toString(),
//                         style: TextStyle(
//                             fontSize: 8,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       );},),
//                       child:  Image.asset(
//             "assets/images/bottom_navigation/shopping-basket.png",
//             scale: 1.5,
//             color: _selectedIndex == 4 ? Colors.green : Colors.white),
//                        )
//               ),
//                         title:
//                             Text(
//                               'Cart',
//                               style: constantFontStyle(fontSize: Fontsize),
//
//                         ),
//                         backgroundColor: Colors.black,
//                       ),
//             ],
//             type: BottomNavigationBarType.shifting,
//             currentIndex: _selectedIndex,
//             selectedIconTheme: IconThemeData(color: themeColor),
//             backgroundColor: themeColor,
//             selectedItemColor: themeColor,
//             iconSize: 30,
//             onTap: _onItemTapped,
//             elevation: 5),
//       ),
//     );
//   }
//
//   getData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getString('userId') ?? "";
//
//     if(userId.isEmpty){}
//     else {
//       setState(() {
//         final StrCartLength = prefs.getString('cartLength') ?? "0";
//         CartLength = StrCartLength;
//       });
//
//
//       var response = await http
//           .post(Uri.parse(getuserProfileApi), body: {"userid": "$userId"});
//       if (response.statusCode == 200) {
//         var body = jsonDecode(response.body);
//         // debugPrint(body["result"]["name"].toString() + "this is user data");
//         //  for (int i = 0; i < 1; i++) {
//         List<String> Uname = [];
//         List<String> Uemail = [];
//         List<String> Uphone = [];
//         Uname.add(body["result"]["name"]);
//         Uphone.add(body["result"]["phone"]);
//         Uemail.add(body["result"]["email"]);
//
//         prefs.setString('username', Uname[0].toString());
//         prefs.setString('userEmail', Uemail[0].toString());
//         prefs.setString('phone', Uphone[0].toString());
//         //   }
//         //
//         // // subList = s;
//         //
//
//       } else {
//         debugPrint("Error in the Api");
//       }
//     }
//   }
//
//   getUserAddress() async {
//     List<String> userAddressType = [];
//     List<String> userApartment = [];
//     List<String> userFirstName = [];
//     List<String> userLastName = [];
//     List<String> userPhoneNo = [];
//     List<String> userFlatNo = [];
//     List<String> userPincode = [];
//     List<String> userStreet = [];
//     List<String> userArea = [];
//     List<String> userCity = [];
//     final prefs = await SharedPreferences.getInstance();
//
//      final userId = prefs.getString('userId');
//      final addressID = prefs.getString('userAddress');
//
//
//
//      debugPrint("this is user Address $addressID");
//
//
//     var response = await http.get(Uri.parse("$viewAddress?userid=$userId"));
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       // debugPrint(data.toString());
//
//       var s = [];
//
//       if (data["status"] == "200") {
//
//         // for (int i = 0; i < data["result"].length; i++) {
//           userAddressType.add(data["result"][0]["type"]);
//           userApartment.add(data["result"][0]["apartment"]);
//           userFirstName.add(data["result"][0]["fname"]);
//           userLastName.add(data["result"][0]["lname"]);
//           userPhoneNo.add(data["result"][0]["phone"]);
//           userFlatNo.add(data["result"][0]["houe_no"]);
//           userPincode.add(data["result"][0]["pin"]);
//           userCity.add(data["result"][0]["city"]);
//           userStreet.add(data["result"][0]["street"]);
//           userArea.add(data["result"][0]["area"]);
//        // }
//
//         // subList = s;
//          var userAddress = "${userApartment[0]}HouseNo ${userFlatNo[0]}, ${userCity[0]}${userPincode[0]}";
//         prefs.setString('userAddress', userAddress);
//
//       } else {
//         setState(() {
//
//         });
//       }
//     } else {
//       debugPrint("Error in the Api");
//     }
//   }
//
//   localDataCheckNull() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     setState(() {
//       if (prefs.getString("userId") != null &&
//           prefs.getString("userAddress") == null) {
//
//
//         getUserAddress();
//       } else {
//         _determinePosition();
//         debugPrint("address id is not available");
//       }
//     });
//
//   }
//
//   getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//
//     currentPosition = position;
//
//     getCurrentLocationAddress();
//     debugPrint(currentPosition.toString() + "current location is ");
//   }
//
//   getCurrentLocationAddress() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     try {
//       currentPosition;
//       List<Placemark> listPlaceMarks = await placemarkFromCoordinates(
//           currentPosition.latitude, currentPosition.longitude);
//       Placemark place = listPlaceMarks[0];
//
//       setState(() {
//         currentLocationAddress =
//         "${place.name},${place.subLocality},${place.locality} ${place.postalCode}";
//         prefs.setString("userAddress",currentLocationAddress);
//         debugPrint(currentLocationAddress.toString());
//       });
//     } catch (e) {
//       debugPrint(e.toString() + "Issue 2 ");
//     }
//   }
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return getCurrentLocation();
//   }
//
//  handleBack() =>showDialog<bool>(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Are you sure?'),
//         content: Text('Do you want to exit this App'),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('No'),
//             onPressed: () {
//               Navigator.of(context).pop(false);
//             },
//           ),
//           FlatButton(
//             child: Text('Yes'),
//             onPressed: () {
//               Navigator.of(context).pop(true);
//             },
//           )
//         ],
//       );
//     },
//   );
//
// }
