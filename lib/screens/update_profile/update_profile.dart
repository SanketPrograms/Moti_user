import 'dart:convert';

import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/main.dart';
import 'package:big_basket/screens/my_account/my_account.dart';
import 'package:big_basket/screens/my_account/my_account_top.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  var userID;



  @override
  void initState() {
    // TODO: implement initState
    getSharedData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Update Profile"),
      body: Column(children: [
        SizedBox(height: 25,),
        Container(
          height: 50,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
            child: TextField(

              controller: nameController,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit,color: Colors.grey,size: 16,),
                  prefix: Text("Name: ",style: constantFontStyle(color: Colors.grey,fontSize: 12),),
                border: OutlineInputBorder(),
                labelText: 'User Name',
                hintText: 'Enter Your Name',
                hintStyle: constantFontStyle(),
                labelStyle: constantFontStyle()
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),

        Container(
          height: 50,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit,color: Colors.grey,size: 16,),
                  prefix: Text("Number: ",style: constantFontStyle(color: Colors.grey,fontSize: 12),),
                border: OutlineInputBorder(),
                labelText: 'Mobile Number',
             //   hintText: 'Enter Mobile Number',
                  hintStyle: constantFontStyle(),
                  labelStyle: constantFontStyle()
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),

        Container(
          height: 50,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
            child: TextField(

              controller: emailController,

              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit,color: Colors.grey,size: 16,),
                  prefix: Text("Email: ",style: constantFontStyle(color: Colors.grey,fontSize: 12),),
                border: OutlineInputBorder(),
                labelText: ' Email',
              //   hintText: 'Enter Email Address',
                  hintStyle: constantFontStyle(),
                  labelStyle: constantFontStyle()
              ),
            ),
          ),
        ),
        SizedBox(height: 30,),

        Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.orangeAccent.shade200),
                  foregroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  sendData();
                },
                child: Text(
                  "Update Profile",
                  style: constantFontStyle(
                      fontSize: Fontsize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ))),
      ],),
    );
  }

  sendData()  async{

    final dataBody = {

      "name":nameController.text,
      "email":emailController.text,
      "phone":phoneController.text,
      "userid":userID.toString(),


    };
    var response = await http.post(Uri.parse(updateProfileApi),body:dataBody);
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
      // Navigator.push(context, MaterialPageRoute(
      //     builder: (context) => my_account_top()));
      Singleton.showmsg(context, "Message", "Profile Updated Succesfully");
      debugPrint(body.toString());
    } else {
         Singleton.showmsg(context, "Message", body["message"].toString());
    }
  }




  getSharedData() async{

    final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
//     final counter = prefs.getString('username') ?? "";
     final userId = prefs.getString('userId') ?? "";
    final uemail = prefs.getString('userEmail') ?? "";
    final uphoneNo = prefs.getString('phone') ?? "";
    final uName = prefs.getString('username') ?? "";

    setState(() {
      userID = userId;

      nameController.text = uName;
      emailController.text = uemail;
      phoneController.text = uphoneNo;
      debugPrint("this is userid$userID");


    });


  }
}
