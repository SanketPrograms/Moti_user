import 'dart:convert';

import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/screens/address/view_address.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditAddress extends StatefulWidget {
  var userAddressType;
  var userApartment;
  var userFirstName;
  var userLastName;
  var userPhoneNo;
  var userFlatNo;
  var userPincode;
  var userCity;
  var userArea;
  var userStreet;
  final userAddressId;

  EditAddress({Key? key,this.userApartment,this.userPincode,this.userCity,this.userFlatNo,this.userPhoneNo,this.userLastName,this.userFirstName,this.userAddressType,this.userStreet,this.userArea,this.userAddressId}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  double paddingAll = 12;
  double elevation_work = 0;
  double elevation_home = 0;
  double elevation_other = 0;
  Color ColorWork = Colors.blueGrey.shade100;
  Color ColorOther = Colors.blueGrey.shade100;
  Color ColorHome = Colors.blueGrey.shade100;
  String? userlat;
  String? userlong;
  String addresstype = "home";
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
  var currentPosition;
  var currentLocationAddress;

  getuserData() {
    setState(() {
      addresstype = widget.userAddressType.toString();
      debugPrint("addresstype is $addresstype");

      if (addresstype == "Home") {
        ColorHome = Colors.green.shade200;
      } else if (
      addresstype == "Work"
      ) {
        ColorWork = Colors.green.shade200;
      }
      else {
        ColorOther = Colors.green.shade200;
      }
      LnameController.text = widget.userLastName.toString();
      FnameController.text = widget.userFirstName.toString();
      phoneNoController.text = widget.userPhoneNo.toString();
      houseNoController.text = widget.userFlatNo.toString();
      cityController.text = widget.userCity.toString();
      pincodeController.text = widget.userPincode.toString();
      appartmentController.text = widget.userApartment.toString();
      areaController.text = widget.userArea.toString();
      streetController.text = widget.userStreet.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement
    getuserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: customAppBar("UPDATE ADDRESS"),

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
                                foregroundColor: MaterialStateProperty.all(
                                    Colors.green),
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
               const SizedBox(height: 10,),

                Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 5,
                    child: personalDetails()),
                Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2,
                    child: AddressDetails()),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    if (phoneNoController.text.length != 10) {
                      Singleton.showmsg(
                          context, "Message", "PLease ADD Contact Number");
                    } else {
                      sendData();
                    }
                  },
                  // child: Text("ADD ADDRESS",style: constantFontStyle(color: Colors.white),),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            height: 45,
                            child: Card(
                              elevation: 5,
                              color: Colors.black87,
                              shape:const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                ),
                              ),
                              child: Center(child: Text("Update ADDRESS",
                                style: constantFontStyle(
                                    color: Colors.white70),)),
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
                  decoration:const InputDecoration(
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
                  decoration:const InputDecoration(
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
            decoration: const InputDecoration(
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
      physics:const NeverScrollableScrollPhysics(),
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
      "aid": widget.userAddressId,
      "fname": FnameController.text,
      "lname": LnameController.text,
      "phone": phoneNoController.text,
      "houe_no": houseNoController.text,
      "apartment": appartmentController.text,
      "street": streetController.text,
      "area": areaController.text,
      "city": cityController.text,
      "pin": pincodeController.text,
      "type": addresstype.toString(),
      "lat": userlat,
      "long": userlong,
      "aname": addressNameController.text,
    };
    var response = await http.post(Uri.parse(updateAddress), body: dataBody);
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        var address = houseNoController.text + appartmentController.text +
            streetController.text + cityController.text +
            pincodeController.text;
        setData(address, pincodeController.text,widget.userAddressId);

        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                ViewAddress()), (Route<dynamic> route) => false);
        Singleton.showmsg(context, "Message", "Address Added Successfully");
      });
      debugPrint(body.toString());
    } else {
      debugPrint(body.toString());
    }
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
    });  }

  getCurrentLocationAddress() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      currentPosition;
      List<Placemark> listPlaceMarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = listPlaceMarks[0];
      debugPrint(place.toString());
      setState(() {
        currentLocationAddress =
        "${place.name},${place.locality} ${place.postalCode},${place
            .administrativeArea}";
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

  setData(address, userPincode,userAddressId) async {
    final prefs = await SharedPreferences.getInstance();

    debugPrint("address Saved $address");
    setState(() {
      prefs.setString('userAddress', address);
      prefs.setString('userPincode', userPincode);
      prefs.setString('addressId', userAddressId);
      prefs.setString('addressEmpty', "No");
    });
  }

}