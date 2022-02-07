// import 'dart:convert';
// import 'dart:io';
// import 'package:big_basket/Widgets/myaccount_appbar.dart';
// import 'package:big_basket/constants/Singleton.dart';
// import 'package:big_basket/constants/apis.dart';
// import 'package:big_basket/constants/constant.dart';
// import 'package:big_basket/screens/user_login/otp_page.dart';
// import 'package:big_basket/screens/user_login/user_login.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserRegistration extends StatefulWidget {
//
//   @override
//   State<UserRegistration> createState() => _UserRegistrationState();
// }
//
// class _UserRegistrationState extends State<UserRegistration> {
//   TextEditingController nameController = TextEditingController();
//
//   TextEditingController emailController = TextEditingController();
//
//   TextEditingController passwordController = TextEditingController();
//
//   TextEditingController phoneController = TextEditingController();
//   PickedFile? _image ;
//
//   getImage() async{
//     PickedFile? pickedImage;
//     pickedImage = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = pickedImage;
//       debugPrint(pickedImage!.path.toString());
//     });
//
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar("User Registration"),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           // InkWell(
//           // onTap: getImage,
//           // child:  CircleAvatar(
//           //
//           //     // backgroundImage:
//           //     radius: 60.0,
//           //     backgroundImage: _image!=null?FileImage(File(_image!.path,),):FileImage(File("")),
//           //
//           //       backgroundColor: Colors.black,
//           //   ),
//           // ),
//
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
//             child: TextField(
//               controller: nameController,
//               decoration: InputDecoration(
//                 border: const OutlineInputBorder(),
//                 labelText: 'User Name',
//                 hintText: 'Enter Your Name',
//                 hintStyle: constantFontStyle(),
//                 labelStyle: constantFontStyle()
//               ),
//             ),
//           ),
//           Padding(
//             padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
//             child: TextField(
//               controller: phoneController,
//               decoration: InputDecoration(
//                 border:const OutlineInputBorder(),
//                 labelText: 'Mobile Number',
//                 hintText: 'Enter Mobile Number',
//                   hintStyle: constantFontStyle(),
//                   labelStyle: constantFontStyle()
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
//             child: TextField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 border:const OutlineInputBorder(),
//                 labelText: ' Email',
//                 hintText: 'Enter Email Address',
//                   hintStyle: constantFontStyle(),
//                   labelStyle: constantFontStyle()
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
//             child: TextField(
//               controller: passwordController,
//               decoration: InputDecoration(
//                   border:const OutlineInputBorder(),
//                   labelText: ' Password',
//                   hintText: 'Enter new Password',
//                   hintStyle: constantFontStyle(),
//                   labelStyle: constantFontStyle()
//               ),
//             ),
//           ),
//
//           Padding(
//               padding: const EdgeInsets.all(1.0),
//               child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                     MaterialStateProperty.all(Colors.orangeAccent.shade200),
//                     foregroundColor: MaterialStateProperty.all(Colors.green),
//                   ),
//                   onPressed: () async{
//                     sendData(context);
//                      setState(() {
//
//                      });
//
//
//
//                   },
//                   child: Text(
//                     "Register",
//                     style: constantFontStyle(
//                         fontSize: Fontsize,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ))),
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
//  //    SharedPreferences prefs = await SharedPreferences.getInstance();
//     final dataBody = {
//      "name":nameController.text,
//       "email":emailController.text,
//       "phone":phoneController.text,
//       "password":passwordController.text,
//      // "imgpath":"image.jpeg"
//
//     };
//
//     var response = await http.post(Uri.parse(registrationApi),body:dataBody);
//     var body = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       debugPrint(body.toString());
//       if (body["error"] == 0) {
//
//         sendDataOtp(context);
//     }
//
//     else{
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>UserLogin()));
//
//     }
//
//
//
//
//     } else {
//        debugPrint("yess");
//       Singleton.showmsg(context, "Message", body["message"]);
//
//
//     }
//   }
//
//   sendDataOtp(context)  async{
//     final dataBody = {
//       "phone":phoneController.text.toString(),
//       //  "password":passwordController.text,
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
//           Navigator.push(context, MaterialPageRoute(builder: (context) =>
//               PinCodeVerificationScreen(
//                   phoneController.text),));
//         });
//       }else {
//         if (body["error"] == "User Not Found") {
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
//       Singleton.showmsg(context, "Message", body["error"]);
//
//     }
//   }
// }
