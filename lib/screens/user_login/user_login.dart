// import 'dart:convert';
//
// import 'package:big_basket/Widgets/myaccount_appbar.dart';
// import 'package:big_basket/constants/apis.dart';
// import 'package:big_basket/constants/constant.dart';
// import 'package:big_basket/constants/singleton.dart';
// import 'package:big_basket/screens/dashboard.dart';
// import 'package:big_basket/screens/user_login/otp_page.dart';
// import 'package:big_basket/screens/user_registration/registration_new_ui.dart';
// import 'package:big_basket/screens/user_registration/user_registration.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserLogin extends StatefulWidget {
//
//
//   UserLogin({Key? key}) : super(key: key);
//
//   @override
//   State<UserLogin> createState() => _UserLoginState();
// }
//
// class _UserLoginState extends State<UserLogin> {
//   TextEditingController nameController = TextEditingController();
//
//   TextEditingController emailController = TextEditingController();
//
//   TextEditingController passwordController = TextEditingController();
//
//   TextEditingController phoneController = TextEditingController();
//   bool registerBtnLoader = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar("Login"),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           SizedBox(height: 10,),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Text(
//               'Enter Register Mobile Number',
//               style: constantFontStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               textAlign: TextAlign.center,
//             ),
//           ),
//
//           SizedBox(height: 10,),
//
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
//             child: TextField(
//               controller: phoneController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: ' Mobile No',
//                 hintText: 'Enter Mobile No',
//                   hintStyle: constantFontStyle(),
//                   labelStyle: constantFontStyle()
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
//           //   child: TextField(
//           //     controller: passwordController,
//           //     decoration: InputDecoration(
//           //         border: OutlineInputBorder(),
//           //         labelText: ' Password',
//           //         hintText: 'Enter new Password',
//           //         hintStyle: constantFontStyle(),
//           //         labelStyle: constantFontStyle()
//           //     ),
//           //   ),
//           // ),
//           SizedBox(height: 10,),
//
//
//           registerBtnLoader
//               ? Center(child: CircularProgressIndicator())
//               : Padding(
//               padding: const EdgeInsets.all(1.0),
//               child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                     MaterialStateProperty.all(Colors.orangeAccent.shade200),
//                     foregroundColor: MaterialStateProperty.all(Colors.green),
//                   ),
//                   onPressed: () {
//
//                        setState(() {
//                          if(phoneController.text.length==10){
//                            registerBtnLoader = true;
//
//                            sendData(context);
//                          }
//                          else{
//                            Singleton.showmsg(context, "Message", "Invalid phone Number");
//                          }
//                        });
//
//
//
//                   },
//                   child: Text(
//                     "Get Otp",
//                     style: constantFontStyle(
//                         fontSize: Fontsize,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ))),
//           SizedBox(height: 10,),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("If You Don't Have Account ?",style: constantFontStyle(fontSize: 14,color: Colors.black),),
//               GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));},child: Text("Register",style: constantFontStyle(fontSize: 14,color: Colors.deepPurple,fontWeight: FontWeight.bold),))
//             ],
//           )
//         ],),
//       ),
//
//     );
//
//
//
//     }
//
//   sendData(context)  async{
//     final dataBody = {
//       "phone":phoneController.text.toString(),
//     //  "password":passwordController.text,
//     };
//     var response = await http.post(Uri.parse(loginApi),body:dataBody);
//     var body = jsonDecode(response.body);
//     debugPrint(body.toString());
//     debugPrint(body["status"].toString());
//     if (response.statusCode == 200) {
//
//
//       if(body["status"]=="success"){
//         setState(() {
//           registerBtnLoader = false;
//
//           Navigator.push(context, MaterialPageRoute(builder: (context) =>
//               PinCodeVerificationScreen(
//                   phoneController.text),));
//         });
//       }else {
//
//         if (body["error"] == "User Not Found") {
//           setState(() {
//             registerBtnLoader = false;
//
//           });
//           Singleton.showmsg(context, "Message", "Invalid User Please Register");
//           //  setdata(body["result"][0]["name"]);
//
//           //  var username = body["result"]["name"].toString();
//           //  var userEmail = body["result"]["email"].toString();
//           //
//           // final prefs = await SharedPreferences.getInstance();
//           // prefs.setString('username', username);
//           // prefs.setString('userEmail', userEmail);
//           //
//           // Navigator.push(
//           //     context, MaterialPageRoute(builder: (context) => Dashboard()));
//         } else {
//           setState(() {
//             registerBtnLoader = false;
//
//           });
//           Singleton.showmsg(context, "Message", "Error while Sending otp");
//
//
//         }
//       }
//
//
//
//       debugPrint(body.toString());
//     } else {
//       setState(() {
//         registerBtnLoader = false;
//
//       });
//       Singleton.showmsg(context, "Message", body["error"]);
//
//     }
//   }
//
//   Future<bool> saveSession() async{
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     return pref.setString('username', 'Some Data');
//   }
// }
