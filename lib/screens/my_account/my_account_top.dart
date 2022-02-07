import 'dart:convert';

import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/address/view_address.dart';
import 'package:big_basket/screens/update_profile/update_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class my_account_top extends StatefulWidget {
   my_account_top({Key? key}) : super(key: key);

  @override
  State<my_account_top> createState() => _my_account_topState();
}

class _my_account_topState extends State<my_account_top> {


  var username = "";
  var userEmail = "";
  var userPhoneNo = "";
  var userAddress = "";
  bool isLoading = true;
  getSharedData() async{

    final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
    final counter = prefs.getString('username') ?? "";
    final useremail = prefs.getString('userEmail') ?? "";
    final phoneNo = prefs.getString('phone') ?? "";
    final address = prefs.getString('userAddress')??"";
    debugPrint("this is counter $counter");
    setState(() {
      username = counter;
      userEmail = useremail;
      userPhoneNo = phoneNo;
      userAddress = address;

    });
    debugPrint("this is username $username");

  }


  @override
  void initState() {
    // TODO: implement initState
    getSharedData();
   // getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.yellow.shade200, Colors.pink.shade300, Colors.pink
                ,
              ]),

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                   const Expanded(child: CircleAvatar(
                      radius: 40.0,
                      //  minRadius: 50.0,
                      backgroundImage:
                    AssetImage(
                          "assets/images/user_icon.png"),
                      backgroundColor: Colors.transparent,
                    )),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [

                                Text("${username}",
                                  style: constantFontStyle(
                                      fontWeight: FontWeight.bold),),
                                Text("${userEmail}",style: constantFontStyle(
                                    fontWeight: FontWeight.w500),),
                                Text("${userPhoneNo}",style: constantFontStyle(
                                    fontWeight: FontWeight.w500),)
                              ],
                            ),
                            Expanded(child: IconButton(
                              icon: Icon(Icons.edit), onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => UpdateProfile()));
                            },))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  child:Row(
                    children: [
                      IconButton(onPressed: (){},icon: Icon(Icons.location_on_outlined)),

                      Expanded(
                        child: Text(userAddress.toString(), style: constantFontStyle(letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),),
                      ),

                      TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.pinkAccent,
                                width: 1,
                                style: BorderStyle.solid,
                              ))),
                        ),
                        child: Text(
                          "Change",
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Colors.pinkAccent),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ViewAddress()));
                        },
                      ),
                      SizedBox(width: 5,),
                    ],                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // getData() async {
  //   setState(() {});
  //   final prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getString('userId') ?? "";
  //   var response = await http.post(
  //       Uri.parse(getuserProfileApi), body: {"userid": "$userId"});
  //   if (response.statusCode == 200) {
  //     var body = jsonDecode(response.body);
  //    // debugPrint(body["result"]["name"].toString() + "this is user data");
  //   //  for (int i = 0; i < 1; i++) {
  //       username.add(body["result"]["name"]);
  //       userPhoneNo.add(body["result"]["phone"]);
  //       userEmail.add(body["result"]["email"]);
  //  //   }
  //     //
  //     // // subList = s;
  //     //
  //
  //       isLoading = false;
  //
  //   } else {
  //     debugPrint("Error in the Api");
  //   }
  // }

}
