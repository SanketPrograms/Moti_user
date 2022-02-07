import 'dart:convert';

import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/dashboard_new.dart';
import 'package:big_basket/screens/address/add_address.dart';
import 'package:big_basket/screens/address/address_edit.dart';
import 'package:big_basket/screens/dashboard.dart';
import 'package:big_basket/screens/user_login/login_sliding_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewAddress extends StatefulWidget {
  const ViewAddress({Key? key}) : super(key: key);

  @override
  State<ViewAddress> createState() => _ViewAddressState();
}

class _ViewAddressState extends State<ViewAddress> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int? value;
  bool isLoading = true;
  var userAddress;
  List<String> userAddressType = [];
  List<String> userApartment = [];
  List<String> userFirstName = [];
  List<String> userLastName = [];
  List<String> userPhoneNo = [];
  List<String> userFlatNo = [];
  List<String> userPincode = [];
  List<String> userStreet = [];
  List<String> userArea = [];
  List<String> userCity = [];
  List<String> userAddressId = [];
  int resultLength = 0;
   var addressID;
  bool noAddress = true;

  @override
  void initState() {
    // TODO: implement initState

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{return
        await Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
            DashBoardNew()), (Route<dynamic> route) => false);
      },
      child: Scaffold(
        key: _scaffoldKey,

        appBar: customAppBar("Address"),
        body: isLoading
            ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          noAddress == true
                              ? Text(
                                  "Saved Address",
                                  style: constantFontStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                )
                              : Text(
                                  "No Saved Address",
                                  style: constantFontStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                          GestureDetector(
                            onTap: () {
                              getSharedData();

                            },
                            child: Text(
                              "+Add New Address",
                              style: constantFontStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      noAddress == true
                          ? dynamicListview()
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 38.0),
                              child: Center(
                                  child: Text(
                                "Please Add New Address",
                                style: constantFontStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )),
                            ),

                      SizedBox(height: 10,),


                    ],
                  ),
                ),
              ),
      ),
    );
  }


  setData(address,pincode,userAddressId) async{

    debugPrint("address Saved$address");
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('userAddress', address);
      prefs.setString('userPincode', pincode);
      prefs.setString('addressId', userAddressId);
      prefs.getString("addressEmpty") == "No";

    });
  }
  Widget dynamicListview() {
    // print(11"this is findword $findWord");
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
        itemCount: resultLength,
        //  itemCount: title.length,
        shrinkWrap: true,
          physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                addressID = userAddressId[index];
                value = index;
                var userAddress = "${userApartment[index]}HouseNo ${userFlatNo[index]}, ${userCity[index]}${userPincode[index]}";

                setData(userAddress,userPincode[index],userAddressId[index]);
                showInSnackBar("Address Changed Successfully");
              });

            },
            child: Card(
              elevation: elevation_size,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: RadioListTile<int>(
                          activeColor: themeColor,
                          value: index,
                          groupValue: value,
                          onChanged: (ind) {
                            setState(() {
                              addressID = userAddressId[index];
                              value = ind!.toInt();
                                  var userAddress = "${userApartment[index]}HouseNo ${userFlatNo[index]}, ${userCity[index]}${userPincode[index]}";

                              setData(userAddress,userPincode[index],userAddressId[index]);
                                 showInSnackBar("Address Changed Successfully");
                            });
                          }),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Default Address:- ",
                                  style: constantFontStyle(
                                      color: Colors.red, fontSize: 10),
                                ),
                                Text(
                                  userAddressType[index],
                                  style: constantFontStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  userFirstName[index] + userLastName[index],
                                  style: constantFontStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${userApartment[index]} HouseNo:${userFlatNo[index]}, \n${userCity[index]} - ${userPincode[index]}",
                                    style: constantFontStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  userPhoneNo[index],
                                  style: constantFontStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditAddress(
                                      userAddressType: userAddressType[index],
                                      userApartment: userApartment[index],
                                      userFirstName: userFirstName[index],
                                      userLastName: userLastName[index],
                                      userPhoneNo: userPhoneNo[index],
                                      userFlatNo: userFlatNo[index],
                                      userPincode: userPincode[index],
                                      userCity: userCity[index],
                                      userStreet: userStreet[index],
                                      userArea: userArea[index],
                                      userAddressId: userAddressId[index],
                                    ),
                                  ));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black54,
                            )),
                        Text(
                          "|",
                          style: constantFontStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                        IconButton(
                            onPressed: () {

                              debugPrint(userAddressId[index]);
                              deleteAddress(userAddressId[index]);
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.black54,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getString('userId');

    debugPrint("this is userID $userId");
    var response = await http.get(Uri.parse("$viewAddress?userid=$userId"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint(data.toString());

      userAddressType.clear();
      userApartment.clear();
      userFirstName.clear();
      userLastName.clear();
      userPhoneNo.clear();
      userFlatNo.clear();
      userAddressId.clear();
      userCity.clear();
      userStreet.clear();
      userPincode.clear();
      userArea.clear();

      var s = [];

      if (data["status"] == "200") {
        resultLength = data["result"].length;
        for (int i = 0; i < data["result"].length; i++) {
          userAddressType.add(data["result"][i]["type"]);
          userAddressId.add(data["result"][i]["id"]);
          userApartment.add(data["result"][i]["apartment"]);
          userFirstName.add(data["result"][i]["fname"]);
          userLastName.add(data["result"][i]["lname"]);
          userPhoneNo.add(data["result"][i]["phone"]);
          userFlatNo.add(data["result"][i]["houe_no"]);
          userPincode.add(data["result"][i]["pin"]);
          userCity.add(data["result"][i]["city"]);
          userStreet.add(data["result"][i]["street"]);
          userArea.add(data["result"][i]["area"]);

        }

        // subList = s;

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          noAddress = false;
        });
      }
    } else {
      debugPrint("Error in the Api");
    }
  }

  getSharedData() async {
    final prefs = await SharedPreferences.getInstance();
    var userName;
    userName = prefs.getString('username');
    var phoneNo;
    phoneNo = prefs.getString('phone');
    if(phoneNo == null) {

      Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context)=>Login_Sliding_image()));


    }
    else{
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddAddress(),
          ));
    }
  }

  deleteAddress(addressId) async {


    debugPrint("this is addresssId $addressId");
    // if(addressId == null){
    //   addressId = userAddressId[0];
    // }
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    final dataBody = {
      "userid": userID,
      "aid": addressId.toString(),

      //  "password":passwordController.text,
    };
    var response = await http.post(Uri.parse(deleteAddressApi), body: dataBody);
    var body = jsonDecode(response.body);

    // debugPrint(body["status"].toString());
    if (response.statusCode == 200) {
      if (body["status"] == "200") {
        setState(() {
           showInSnackBar("Deleted Succefully!");
          // cartApi();
          getData();
        });
      } else {
        setState(() {
          showInSnackBar("Something Went Wrong");

        });
     //   Singleton.showmsg(context, "Message", body["message"]);
      }

      debugPrint(body.toString());
    } else {
    //  Singleton.showmsg(context, "Message", body["error"]);
    }
  }
  void showInSnackBar(defaulttText) {
    _scaffoldKey.currentState!
        .showSnackBar(SnackBar(content: Text(defaulttText)));
  }
}
