import 'dart:convert';

import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/terms_and_conditiions/terms_n_condition_modelclass.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TermsANDConditions extends StatefulWidget {
   TermsANDConditions({Key? key,}) : super(key: key);

  @override
  State<TermsANDConditions> createState() => _TermsANDConditionsState();
}

class _TermsANDConditionsState extends State<TermsANDConditions> {
   var LogoImage;
   var email;
   var privacy;
   var title;
   var terms;
   var phone;
   bool isLoading = true;

   @override
  void initState() {
    // TODO: implement initState
     TermsAndCondtion();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        centerTitle: true,
        title: Text("Terms And Condition", style: constantFontStyle(
            fontWeight: FontWeight.w500,

            fontSize: 14,
            color: Colors.white),),
      ),
      body: isLoading
          ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
          :SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: 250,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Center(
                      child: Image.asset("assets/images/image_loader.gif"),
                    ),
                    imageUrl: LogoImage,

                    errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),

                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Container(
                            //  elevation: elevation_size,
                            color: themeColor,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  title,
                                  style: constantFontStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                      const  SizedBox(
                        height: 10,
                      ),

                      Text(
                        "terms and conditions",
                        style: constantFontStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          terms,
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),

                      Text(
                        "privacy policy",
                        style: constantFontStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          privacy,
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),


                      Text(
                        "Contact Us",
                        style: constantFontStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Email:$email \n Phone:$phone",
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ),
                       SizedBox(height: 20,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TermsAndCondtion() async {
    var response =
    await http.get(Uri.parse(TnCsettingsApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);


      LogoImage = data["result"]["logo_imgpath"];
      email = data["result"]["email"];
      privacy = data["result"]["privacy"];
      title = data["result"]["title"];
      terms = data["result"]["terms"];
      phone = data["result"]["phone"];
      debugPrint("this is image $LogoImage");
      setState(() {
        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
      setState(() {
        isLoading = false;
      });
    }
  }
}
