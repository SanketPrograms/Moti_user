import 'dart:convert';

import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatelessWidget {

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("User Registration"),
      body: Column(children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
          child: TextField(
            controller: oldPasswordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Old Password',
              hintText: 'Enter Old Password',
                hintStyle: constantFontStyle(),
                labelStyle: constantFontStyle()
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
          child: TextField(
            controller: newPasswordController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'New Password',
                hintText: 'Enter new Password',
                hintStyle: constantFontStyle(),
                labelStyle: constantFontStyle()
            ),
          ),
        ),

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
                  "Change Password",
                  style: constantFontStyle(
                      fontSize: Fontsize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))),
      ],),

    );



    }

  sendData()  async{

    final dataBody = {
      "userid":"1",
      "oldPassword":oldPasswordController.text,
      "password":newPasswordController.text,
    };
    var response = await http.post(Uri.parse(loginApi),body:dataBody);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      debugPrint(body.toString());
    } else {

    }
  }
}
