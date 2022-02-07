
import 'dart:io';

import 'package:big_basket/Widgets/internet_connection.dart';
import 'package:big_basket/dashboard_new.dart';
import 'package:big_basket/model_class/cart_model_class.dart';
import 'package:big_basket/screens/Filter/filter_mainscreen.dart';
import 'package:big_basket/screens/change_password/change_password.dart';
import 'package:big_basket/screens/customer_services/customer_services.dart';
import 'package:big_basket/screens/dashboard.dart';
import 'package:big_basket/screens/terms_and_conditiions/terms_and_condition.dart';
import 'package:big_basket/screens/text_to_speech/text_to_speech.dart';

import 'package:big_basket/screens/user_login/login_sliding_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/user_login/user_login.dart';
ValueNotifier itemsNotifier = ValueNotifier([]);

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {


   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? handleInternet = "1";


  @override
  void initState() {
    // TODO: implement initState
    checkConnection();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
     // home:  Scaffold(body: Login_Sliding_image()),
     //  home:  Scaffold(body: NewDashBoard()),

     // home:  Scaffold(body: SpeechToText()),
      home:
      Scaffold(
          //body:FilterMainScreen(


      body:handleInternet == "1"?DashBoardNew():internetConnection()),
   //  home:  Scaffold(body: TermsANDConditions()),
     );
  }

  checkConnection() async {



    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {


          debugPrint("Connected");
          setState(() {
            handleInternet = "1";

          });

      }
    } on SocketException catch (_) {


        debugPrint("Not Connected");
setState(() {

});
        handleInternet = "0";


    }
  }
}




