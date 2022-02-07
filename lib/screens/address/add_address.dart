import 'dart:convert';

import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/screens/address/view_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddAddress extends StatefulWidget {
  AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  double paddingAll = 12;
  double elevation_work = 0;
  double elevation_home = 0;
  double elevation_other = 0;
  Color ColorWork = Colors.blueGrey.shade100;
  Color ColorOther = Colors.blueGrey.shade100;
  Color ColorHome = Colors.blueGrey.shade100;
  var currentPosition;
  var currentLocationAddress;
  String addresstype = "home";
  bool _PhoneNovalidate = false;
  bool _HouseNovalidate = false;
  bool _Appartmentvalidate = false;
  bool _Streetvalidate = false;
  bool _Areavalidate = false;
  bool _CurrentCityvalidate = false;
  bool _PinCodevalidate = false;

  TextEditingController FnameController = TextEditingController();

  TextEditingController LnameController = TextEditingController();

  TextEditingController phoneNoController = TextEditingController();

  TextEditingController houseNoController = TextEditingController();

  TextEditingController appartmentController = TextEditingController();

  TextEditingController streetController = TextEditingController();

  TextEditingController areaController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController pincodeController = TextEditingController();

  TextEditingController addressTypeController = TextEditingController();

  TextEditingController addressNameController = TextEditingController();

  String? userlat;
  String? userlong;


  @override
  void initState() {
    // TODO: implement initState

    getSharedData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: GestureDetector(
      //   onTap: () {
      //     if (phoneNoController.text.length != 10) {
      //       Singleton.showmsg(context, "Message", "PLease ADD Contact Number");
      //     } else {
      //       sendData();
      //     }
      //   },
      //   // child: Text("ADD ADDRESS",style: constantFontStyle(color: Colors.white),),
      //   child: Text(
      //     "ADD ADDRESS",
      //     style: constantFontStyle(color: Colors.white),
      //   ),
      // ),
      appBar: customAppBar("ADD ADDRESS"),
      body: SingleChildScrollView(
        //   width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
              ),
            ),
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white54),
                                foregroundColor: MaterialStateProperty.all(Colors.green),
                              ),
                              onPressed: () {
                                _determinePosition();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                               //   Icon(Icons.),
                                  Text(
                                    "Use My Current Location",
                                    style: constantFontStyle(
                                        fontSize: Fontsize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ))),
                    ),
                  ],
                ),
                SizedBox(height: 10,),

                Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: personalDetails()),
                Container(
                    height: MediaQuery.of(context).size.height / 1.9,
                    child: AddressDetails()),
               // SizedBox(height: 10),
                GestureDetector(
                  onTap: () {

                    setState(() {


                      if(phoneNoController.text.isEmpty||houseNoController.text.isEmpty||appartmentController.text.isEmpty|| streetController.text.isEmpty|| areaController.text.isEmpty||cityController.text.isEmpty|| pincodeController.text.isEmpty) {
                        phoneNoController.text.isEmpty||phoneNoController.text.length != 10
                            ? _PhoneNovalidate = true
                            : _PhoneNovalidate = false;
                        houseNoController.text.isEmpty
                            ? _HouseNovalidate = true
                            : _HouseNovalidate = false;
                        appartmentController.text.isEmpty ?
                        _Appartmentvalidate = true : _Appartmentvalidate =
                        false;
                        streetController.text.isEmpty
                            ? _Streetvalidate = true
                            : _Streetvalidate = false;
                        areaController.text.isEmpty
                            ? _Areavalidate = true
                            : _Areavalidate = false;
                        cityController.text.isEmpty ? _CurrentCityvalidate =
                        true : _CurrentCityvalidate = false;
                        pincodeController.text.isEmpty
                            ? _PinCodevalidate = true
                            : _PinCodevalidate = false;
                      }
                      else{


                          sendData();

                      }
                    });

                  },
                  // child: Text("ADD ADDRESS",style: constantFontStyle(color: Colors.white),),
                  child: Row(
                      children: [
                        Expanded(
                            child:Container(
                              height: 45,
                              child: Card(
                                elevation: 5,
                                color: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(25.0),
                                    bottomLeft: Radius.circular(25.0),
                                  ),
                                ),
                                child: Center(child: Text("ADD ADDRESS",style: constantFontStyle(color: Colors.white70),)),
                              ),
                            )

                        ),
                      ],
                    ),
                  ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget personalDetails() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),

      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingAll),
          child: Text(
            "Personal Details",
            style: constantFontStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingAll),
                child: TextField(
                  controller: FnameController,
                  decoration: InputDecoration(
                      hintText: "First Name", labelText: "Enter First Name"),
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingAll),
                child: TextField(
                  controller: LnameController,
                  decoration: InputDecoration(
                     // errorText: _validate ? 'Value Can\'t Be Empty' : null,

                      hintText: "Last Name", labelText: "Enter Last Name"),
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingAll),
          child: TextField(
            controller: phoneNoController,
            decoration: InputDecoration(
                errorText: _PhoneNovalidate ? 'Invalid Number' : null,

                hintText: "Mobile Number",
                labelText: "Contact Number To Say Hello"),
            style:
            constantFontStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget AddressDetails() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingAll),
          child: Text(
            "Address Details",
            style: constantFontStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingAll),
                child: TextField(
                  controller: houseNoController,
                  decoration: InputDecoration(
                      errorText: _HouseNovalidate ? 'Value Can\'t Be Empty' : null,


                      hintText: "House No", labelText: "Enter House No"),
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingAll),
                child: TextField(
                  controller: appartmentController,
                  decoration: InputDecoration(
                      errorText: _Appartmentvalidate ? 'Value Can\'t Be Empty' : null,

                      hintText: "Apartment Name",
                      labelText: "Enter Apartment Name"),
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingAll),
          child: TextField(
            controller: streetController,
            decoration: InputDecoration(
                errorText: _Streetvalidate ? 'Value Can\'t Be Empty' : null,

                hintText: "Street Details", labelText: "Enter Street Details"),
            style:
            constantFontStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: paddingAll),
        //   child: TextField(
        //     controller: areaController,
        //     decoration: InputDecoration(
        //         hintText: "Landmark", labelText: "Enter Landmark Details"),
        //     style:
        //         constantFontStyle(fontWeight: FontWeight.w500, fontSize: 12),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingAll),
          child: TextField(
            controller: areaController,
            decoration: InputDecoration(
                errorText: _Areavalidate ? 'Value Can\'t Be Empty' : null,

                hintText: "Area Details", labelText: "Enter Area Details"),
            style:
            constantFontStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingAll),
                child: TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                      errorText: _CurrentCityvalidate ? 'Value Can\'t Be Empty' : null,

                      hintText: "City", labelText: "Current City"),
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingAll),
                child: TextField(
                  controller: pincodeController,
                  decoration: InputDecoration(
                      errorText: _PinCodevalidate ? 'Value Can\'t Be Empty' : null,

                      hintText: "Pincode", labelText: "Enter Pincode"),
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Choose Nick Name for Address",
            style:
            constantFontStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
        Row(
          children: [
            //         GestureDetector(
            //           onTap: (){
            //
            //           },
            //           child: Expanded(
            //             child: Container(
            //               height: 50,
            //               child: Card(
            //                 child: Center(
            //                   child: Text("Home" ,    style: constantFontStyle(
            // fontWeight: FontWeight.w500, fontSize: 12),),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    elevation_home = 10;
                    elevation_other = 0;
                    elevation_work = 0;
                    ColorHome = Colors.green.shade200;
                    ColorOther = Colors.blueGrey.shade100;
                    ColorWork = Colors.blueGrey.shade100;
                    addresstype = "Home";
                  });
                },
                child: Container(
                  height: 50,
                  child: Card(
                    color: ColorHome,
                    elevation: elevation_home,
                    child: Center(
                      child: Text(
                        "Home",
                        style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    elevation_home = 0;
                    elevation_other = 0;
                    elevation_work = 10;
                    ColorHome = Colors.blueGrey.shade100;
                    ColorOther = Colors.blueGrey.shade100;
                    ColorWork = Colors.green.shade200;
                    addresstype = "Work";
                  });
                },
                child: Container(
                  height: 50,
                  child: Card(
                    color: ColorWork,
                    elevation: elevation_work,
                    child: Center(
                      child: Text(
                        "Work",
                        style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    elevation_home = 0;
                    elevation_other = 10;
                    elevation_work = 0;
                    ColorHome = Colors.blueGrey.shade100;
                    ColorOther = Colors.green.shade200;
                    ColorWork = Colors.blueGrey.shade100;
                    addresstype = "Other";
                  });
                },
                child: Container(
                  height: 50,
                  child: Card(
                    elevation: elevation_other,
                    color: ColorOther,
                    child: Center(
                      child: Text(
                        "Other",
                        style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 5,),

      ],
    );
  }

  sendData() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getString('userId');
    final dataBody = {
      "userid": userID.toString(),
      "fname": FnameController.text,
      "lname": LnameController.text,
      "phone": phoneNoController.text,
      "houe_no": houseNoController.text,
      "apartment": appartmentController.text,
      "street": streetController.text,
      "area": areaController.text,
      "city": cityController.text,
      "pin": pincodeController.text,
      "type": addresstype,
      "lat": userlat,
      "long": userlong,
      "aname": addressNameController.text,
    };
    var response = await http.post(Uri.parse(addAddressApi), body: dataBody);
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
            var address = houseNoController.text + appartmentController.text + streetController.text+cityController.text+pincodeController.text;
        //    setData(address,pincodeController.text);

        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            ViewAddress()), (Route<dynamic> route) => false);
        Singleton.showmsg(context, "Message", "Address Added Successfully");
      });
      debugPrint(body.toString());
    } else {
      debugPrint(body.toString());
    }
  }

  setData(address,userPincode) async{
    final prefs = await SharedPreferences.getInstance();

    debugPrint("address Saved $address");
    setState(() {
      prefs.setString('userAddress', address);
      prefs.setString('userPincode', userPincode);
      prefs.setString('userAid', userPincode);
      prefs.setString('addressEmpty', "No");
    });

  }


  getSharedData() async {
    final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
    final counter = prefs.getString('username') ?? "";
    final phoneNo = prefs.getString('phone') ?? "";
    setState(() {
      FnameController.text = counter;
      phoneNoController.text = phoneNo;
    });
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;

    getCurrentLocationAddress();
    setState(() {
      userlat = currentPosition.toString().split("Latitude:").last.split(",").first;
      userlong = currentPosition.toString().split("Longitude:").last.split(",").first;
      debugPrint(currentPosition.toString() + "current location is ");
    });


  }

  getCurrentLocationAddress() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      currentPosition;

      List<Placemark> listPlaceMarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      debugPrint("this is currrenttt lat and long" + currentPosition.toString());

      Placemark place = listPlaceMarks[0];
      debugPrint(place.toString());
      setState(() {
        currentLocationAddress =
        "${place.name},${place.locality} ${place.postalCode},${place.administrativeArea}";
       // prefs.setString("userAddress",currentLocationAddress);
        debugPrint(currentLocationAddress.toString());

        houseNoController.text = place.street.toString();
        streetController.text = place.subLocality.toString();

         areaController.text = place.name.toString();

         cityController.text = place.locality.toString();

        pincodeController.text = place.postalCode.toString();


      });
    } catch (e) {
      debugPrint(e.toString() + "Issue 2 ");
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return getCurrentLocation();
  }
}
