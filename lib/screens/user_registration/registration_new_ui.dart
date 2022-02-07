import 'dart:convert';
import 'dart:io';

import 'package:big_basket/Widgets/background.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/screens/user_login/login_sliding_image.dart';
import 'package:big_basket/screens/user_login/otp_page.dart';
import 'package:big_basket/screens/user_login/user_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  var _image;
  ImagePicker picker = ImagePicker();

 bool registerBtnLoader = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(

      body: SingleChildScrollView(
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "REGISTER",
                  style: constantFontStyle(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                      fontSize: 18
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20),
              // Center(
              //   child: GestureDetector(
              //     onTap: () {
              //       _showPicker(context);
              //     },
              //     child: CircleAvatar(
              //       radius: 55,
              //       // backgroundColor: Color(0xffFDCF09),
              //       backgroundColor: Colors.transparent,
              //       child: _image != null
              //           ? ClipRRect(
              //         borderRadius: BorderRadius.circular(50),
              //         child: Image.file(
              //           _image,
              //           width: 100,
              //           height: 100,
              //           fit: BoxFit.fill,
              //         ),
              //       )
              //           : Container(
              //         decoration: BoxDecoration(
              //             color: Colors.grey[200],
              //             borderRadius: BorderRadius.circular(50)),
              //         width: 100,
              //         height: 100,
              //         child: Icon(
              //           Icons.camera_alt,
              //           color: Colors.grey[800],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),


              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: constantFontStyle()
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      labelText: "Mobile Number",
                      labelStyle: constantFontStyle()
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: constantFontStyle()
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // Container(
              //   alignment: Alignment.center,
              //   margin: EdgeInsets.symmetric(horizontal: 40),
              //   child: TextField(
              //     controller: passwordController,
              //     decoration: InputDecoration(
              //         labelText: "Password",
              //         labelStyle: constantFontStyle()
              //     ),
              //     obscureText: true,
              //   ),
              // ),

              SizedBox(height: size.height * 0.05),

              registerBtnLoader
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      registerBtnLoader = true;
                      sendData(context);
                    });

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: ()
                  {
                  Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context)=>Login_Sliding_image()));

                },
                  child: Text(
                    "Already Have an Account? Sign in",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  _imgFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);


    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromCamera() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera);


    setState(() {
      _image = File(image!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  // _asyncFileUpload(File file) async {
  //   //create multipart request for POST or PATCH method
  //   var request = http.MultipartRequest("POST", Uri.parse(registrationApi));
  //   //add text fields
  //   request.fields["name"] = nameController.text;
  //   request.fields["email"] = emailController.text;
  //   request.fields["phone"] = phoneController.text;
  //   request.fields["password"] = passwordController.text;
  //   //create multipart using filepath, string or bytes
  //   var pic = await http.MultipartFile.fromPath("imgpath", file.path);
  //   //add multipart to request
  //   request.files.add(pic);
  //   var response = await request.send();
  //
  //   //Get the response from the server
  //   var responseData = await response.stream.toBytes();
  //   var responseString = String.fromCharCodes(responseData);
  //   debugPrint(responseString);
  //
  //
  //   if (response.statusCode == 200) {
  //     sendDataOtp(context);
  //   }
  //
  //   else {
  //     Singleton.showmsg(context, "Message", "Registration Failed");
  //   }
  // }
sendData(context)  async{
  //    SharedPreferences prefs = await SharedPreferences.getInstance();
  final dataBody = {
    "name":nameController.text,
    "email":emailController.text,
    "phone":phoneController.text,
    "password":"1234",
    // "imgpath":"image.jpeg"

  };

  var response = await http.post(Uri.parse(registrationApi),body:dataBody);
  var body = jsonDecode(response.body);
  if (response.statusCode == 200) {
    debugPrint(body.toString());
    if (body["error"] == 0) {

      sendDataOtp(context);
    }

    else{
      setState(() {
        registerBtnLoader = false;

      });
    Singleton.showmsg(context, "Message", body["message"]);

    }




  } else {
    setState(() {
      registerBtnLoader = false;

    });
    debugPrint("yess");
    Singleton.showmsg(context, "Message", body["message"]);


  }
}

  sendDataOtp(context)  async{
    final dataBody = {
      "phone":phoneController.text.toString(),
      //  "password":passwordController.text,
    };
    var response = await http.post(Uri.parse(loginApi),body:dataBody);
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    debugPrint(body["status"].toString());
    if (response.statusCode == 200) {


      if(body["status"]=="success"){

         setState(() {
           registerBtnLoader = false;

           Navigator.push(context, MaterialPageRoute(builder: (context) =>
              PinCodeVerificationScreen(
                  phoneController.text),));
         });
       }else {
        if (body["error"] == "User Not Found") {
          Singleton.showmsg(context, "Message", "Invalid User Please Register");
          //  setdata(body["result"][0]["name"]);

          //  var username = body["result"]["name"].toString();
          //  var userEmail = body["result"]["email"].toString();
          //
          // final prefs = await SharedPreferences.getInstance();
          // prefs.setString('username', username);
          // prefs.setString('userEmail', userEmail);
          //
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Dashboard()));
        } else {
          Singleton.showmsg(context, "Message", "Error while Sending otp");
          setState(() {

          });
          registerBtnLoader = false;


        }
      }



      debugPrint(body.toString());
    } else {
      Singleton.showmsg(context, "Message", body["error"]);

    }
  }
}