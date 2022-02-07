import 'dart:convert';

import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SubmitFeedback extends StatelessWidget {
   SubmitFeedback({Key? key}) : super(key: key);




  TextEditingController phoneController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool btn_loader = false;
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getSharedData();
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(onPressed: (){Navigator.pop(context);} ,icon: Icon(Icons.cancel,color: Colors.black,)),
        backgroundColor: Colors.white,
        title: Text("Leave Feedback",style: constantFontStyle(color: Colors.black,fontSize: 14),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15,),
                 Padding(
                          padding: EdgeInsets.symmetric(horizontal: paddingAll),
                          child: TextField(
                            controller: nameController,
                            decoration:const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                                hintText: "Name", labelText: "Enter Your Name"),
                            style: constantFontStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ),
                  SizedBox(height: 15,),
                  //
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: paddingAll),
                        child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              hintText: "Mobile Number",
                              labelText: "Contact Number To Say Hello"),
                          style:
                          constantFontStyle(fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                  SizedBox(height: 15,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: paddingAll),
                        child: TextField(
                          controller:emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              hintText: "Mail ID",
                              labelText: "Mail ID"),
                          style:
                          constantFontStyle(fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                            minLines: 2,
                            maxLines: 5,
                            controller: feedbackController,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: 'Your Valuable Feedback',
                              labelText: 'Feedback',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                          ),
                  ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         btn_loader?Center(child:CircularProgressIndicator()) :Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 4.0),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.black54),
                                      foregroundColor:
                                      MaterialStateProperty.all(Colors.green),
                                    ),
                                    onPressed: () {

                                      if(emailController.text.isNotEmpty&&nameController.text.isNotEmpty&&feedbackController.text.isNotEmpty&&phoneController.text.isNotEmpty) {
                                        sendData(context);
                                      }
                                      else{
                                        Singleton.showmsg(context, "Message", "Please Fill The Empty Field");

                                      }
                                    },
                                    child: Text(
                                      "Submit",
                                      style: constantFontStyle(
                                          fontSize: Fontsize,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                          ),
                        ],
                      )
                  //
                  //
                    ],
                  ),
            ),

            ),
          ),
      ),

    );
  }

  sendData(context)  async{
    final prefs = await SharedPreferences.getInstance();

    var userID = prefs.getString('userId');
    final dataBody = {
      "userid":userID.toString(),
      "contact":phoneController.text.toString(),
      "email":emailController.text.toString(),
      "message":feedbackController.text.toString(),
    //  "password":passwordController.text,
    };
    var response = await http.post(Uri.parse(feedbackApi),body:dataBody);
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    debugPrint(body["status"].toString());
    if (response.statusCode == 200) {
      Singleton.showmsg(context, "Thank You", "Feedback Added Successfully");
    }
    else{

      Singleton.showmsg(context, "Message", "Error while Sending Feedback");

    }


        }

  getSharedData() async {
    final prefs = await SharedPreferences.getInstance();

    final counter = prefs.getString('username') ?? "";


    final useremail = prefs.getString('userEmail') ?? "";
    final phoneNo = prefs.getString('phone') ?? "";

    nameController.text = counter;
      emailController.text = useremail;
      phoneController.text = phoneNo;

  }
      }



