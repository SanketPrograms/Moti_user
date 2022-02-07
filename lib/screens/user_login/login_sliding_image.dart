import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/dashboard_new.dart';
import 'package:big_basket/screens/dashboard.dart';
import 'package:big_basket/screens/user_registration/registration_new_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login_Sliding_image extends StatefulWidget {
  @override
  State<Login_Sliding_image> createState() => _Login_Sliding_imageState();
}

class _Login_Sliding_imageState extends State<Login_Sliding_image> {
  final formKey = GlobalKey<FormState>();
  TextEditingController OtpController = TextEditingController();
  TextEditingController UserMobileNo = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  var sliding_value = 0;
  bool showLoginBtn = false;
  bool showContinueBtn = true;
  bool registerBtnLoader = false;


  Timer? _timer;
  int _start = 120;

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }


  @override
  void initState() {
    // TODO: implement

    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(

      child: SingleChildScrollView(
        child: SafeArea(
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                ImageSlideshow(

                  /// Width of the [ImageSlideshow].
                  width: double.infinity,

                  /// Height of the [ImageSlideshow].
                  height: MediaQuery.of(context).size.height/3,

                  /// The page to show when first creating the [ImageSlideshow].
                  initialPage: 0,

                  /// The color to paint the indicator.
                  indicatorColor: themeColor,

                  /// The color to paint behind th indicator.
                  indicatorBackgroundColor: Colors.grey,

                  /// The widgets to display in the [ImageSlideshow].
                  /// Add the sample image file into the images folder
                  children: [

                    Image.asset(
                      'assets/images/login_design/delivery_boy_ani.gif',
                      fit: BoxFit.cover,
                    ),


                    Image.asset(
                      'assets/images/login_design/junk_food_ani.gif',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/login_design/clock_animation.gif',
                      fit: BoxFit.cover,
                    ),
                  ],

                  /// Called whenever the page in the center of the viewport changes.
                  onPageChanged: (value) {
                    debugPrint('Page changed: $value');
                    setState(() {
                      sliding_value = value;
                    });
                  },

                  /// Auto scroll interval.
                  /// Do not auto scroll with null or 0.
                  autoPlayInterval: 8000,

                  /// Loops back to first slide.
                  isLoop: true,
                ),

                SizedBox(height: 10,),
                sliding_value == 0 ? Text(
                  'Healthy & Fresh', style: constantFontStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),) : sliding_value == 1 ? Text(
                  'Daily Needs', style: constantFontStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),) : Text('Late Order', style: constantFontStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),),

                SizedBox(height: 10,),
                sliding_value == 0 ? Center(
                  // padding: const EdgeInsets.symmetric(horizontal: 60.0,vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,
                      child: Text(
                        'Get Healthy Fresh Food, Vegitables, Fruits instantly at your door Steps ',
                        style: constantFontStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12
                        ),),
                    ),
                  ),
                ) : sliding_value == 1 ?
                Center(
                  // padding: const EdgeInsets.symmetric(horizontal: 70.0,vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,

                      child: Text(
                        'Get All Daily Needs Product Near By You at your door steps',
                        style: constantFontStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12
                        ),),
                    ),
                  ),
                ) :
                Center(

                  ///    padding: const EdgeInsets.symmetric(horizontal: 70.0,vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,

                      child: Text(
                        'Get Quick Delivery With Our Best Delivery Service',
                        style: constantFontStyle(
                            fontWeight: FontWeight.w500,

                            fontSize: 12
                        ),),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                Visibility(
                  visible: showContinueBtn,
                  child: Container(
                    height: MediaQuery.of(context).size.height/2,

                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [

                            themeColor,
                            Colors.yellow,
                          ],
                        ),

                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25))
                    ),
                    //  height: MediaQuery.of(context).size.height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,


                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Text('Enter Number', style: constantFontStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white
                        ),),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: TextField(
                            style: constantFontStyle(color: Colors.white),

                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: UserMobileNo,

                            decoration: InputDecoration(



                                hintText: "Mobile Number",
                                hintStyle: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.white70
                                )
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),

                          child: Text(
                            'By Continuing you agree to our terms and conditions and privacy policy',
                            style: constantFontStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.white
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: registerBtnLoader
                              ? Center(child: CircularProgressIndicator(color: themeColor,strokeWidth: 1,)):ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(

                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),

                                ),
                              ),
                            ),
                            child:Text(
                                '    Continue    ', style: constantFontStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.black54
                            )),
                            onPressed: () {
                              setState(() {
                                if (UserMobileNo.text.length != 10) {
                                  Singleton.showInSnackBar(
                                      context, "Invaild Mobile Number");
                                }
                                else {

                                    registerBtnLoader = true;


                                  sendData(context);

                                }
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 0),

                              child: Text(
                                " Don't have account?",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.white
                                ),),
                            ),
                GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));},child: Text("Register!",style: constantFontStyle(fontSize: 14,color: Colors.deepPurple,fontWeight: FontWeight.bold),))
                          ],
                        ),





                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: showLoginBtn,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height/2,

                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [

                              themeColor,
                              Colors.yellow,
                            ],
                          ),

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25))
                      ),
                      //  height: MediaQuery.of(context).size.height,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Enter OTP', style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  UserMobileNo.text.toString(), style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white
                                ),),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                        Login_Sliding_image()), (Route<dynamic> route) => false);

                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('Change', style: constantFontStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.black87
                                  ),),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Form(
                            key: formKey,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 60),
                                child: PinCodeTextField(
                                  appContext: context,
                                  pastedTextStyle: TextStyle(
                                    color: Colors.green.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  length: 4,
                                  obscureText: true,
                                  obscuringCharacter: '*',
                                  // obscuringWidget: FlutterLogo(
                                  //   size: 24,
                                  // ),
                                  blinkWhenObscuring: true,
                                  animationType: AnimationType.fade,
                                  validator: (v) {
                                    if (v!.length < 1) {
                                      return "I'm from validator";
                                    } else {
                                      return null;
                                    }
                                  },
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.underline,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                    disabledColor: Colors.white,
                                    inactiveFillColor: Colors.white30,
                                    activeFillColor: Colors.white30,
                                  ),
                                  cursorColor: Colors.black,
                                  animationDuration: Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  errorAnimationController: errorController,
                                  controller: OtpController,
                                  keyboardType: TextInputType.number,
                                  boxShadows: [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      color: Colors.black12,
                                      blurRadius: 10,
                                    )
                                  ],
                                  onCompleted: (v) {
                                    print("Completed");
                                  },
                                  // onTap: () {
                                  //   print("Pressed");
                                  // },
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      currentText = value;
                                    });
                                  },
                                  beforeTextPaste: (text) {
                                    print("Allowing to paste $text");
                                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                    return true;
                                  },
                                )),
                          ),

                          Text("You will get OTP before: " + _start.toString(),
                              style: constantFontStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Colors.white70
                              )),
                          SizedBox(height: 15,),

                          registerBtnLoader
                              ? Center(child: CircularProgressIndicator(color: themeColor,strokeWidth: 1,)):  ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(

                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),

                                ),
                              ),
                            ),
                            child: Text('    Login    ',
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.black54
                                )),
                            onPressed: () {
                              getOtpRequest(context);
                              setState(() {
                                registerBtnLoader = true;
                              });

                            },
                          ),

                          SizedBox(height: 20,)

                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  sendData(context) async {
    final dataBody = {
      "phone": UserMobileNo.text.toString(),
    };
    var response = await http.post(Uri.parse(loginApi), body: dataBody);
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    debugPrint(body["status"].toString());
    if (response.statusCode == 200) {
      if (body["status"] == "success") {
        setState(() {
          startTimer();

          registerBtnLoader = false;
          showLoginBtn = true;
          showContinueBtn = false;

          // Navigator.push(context, MaterialPageRoute(builder: (context) =>
          //     PinCodeVerificationScreen(
          //         phoneController.text),));
        });
      } else {
        if (body["error"] == "User Not Found") {
          setState(() {
            registerBtnLoader = false;
          });
          Singleton.showmsg(context, "Message", "Invalid User Please Register");
        } else {
          setState(() {
            registerBtnLoader = false;
          });
          Singleton.showmsg(context, "Message", "Error while Sending otp");
        }
      }
    }
  }

  getOtpRequest(context)  async{

    debugPrint("this is otp" + OtpController.text.toString());

    final dataBody = {
      "phone":UserMobileNo.text,
      "otp":OtpController.text,
    };
    var response = await http.post(Uri.parse(verifyOtpApi),body:dataBody);
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    if(response.statusCode == 200){
      if(body["error"]==0){
        var username = body["result"]["name"].toString();
        var userEmail = body["result"]["email"].toString();
        var userID = body["result"]["id"].toString();
        var phone = body["result"]["phone"].toString();
        var OID = body["result"]["oid"].toString();

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('username', username);
        prefs.setString('userEmail', userEmail);
        prefs.setString('userId', userID);
        prefs.setString('phone', phone);
        prefs.setString('cartOid', OID);

        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
            DashBoardNew()), (Route<dynamic> route) => false);

        setState(() {
          registerBtnLoader = false;

        });
      }
      else{
        Singleton.showmsg(context, "Message", "Invalid Otp");
        setState(() {
          registerBtnLoader = false;

        });
      }
    }

  }
}
