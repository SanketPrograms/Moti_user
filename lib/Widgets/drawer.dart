import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/dashboard_new.dart';
import 'package:big_basket/main.dart';
import 'package:big_basket/screens/FAQ/faq.dart';
import 'package:big_basket/screens/address/add_address.dart';
import 'package:big_basket/screens/address/view_address.dart';
import 'package:big_basket/screens/customer_services/customer_services.dart';
import 'package:big_basket/screens/dashboard.dart';
import 'package:big_basket/screens/delivery/delivery_option.dart';
import 'package:big_basket/screens/favourite_page/favourite_items.dart';
import 'package:big_basket/screens/favourite_page/favourite_main.dart';
import 'package:big_basket/screens/feedback/submit_feedback.dart';
import 'package:big_basket/screens/homepage/homepage.dart';
import 'package:big_basket/screens/my_account/my_account.dart';
import 'package:big_basket/screens/offers/offers_list.dart';
import 'package:big_basket/screens/recommendation/recommendation_dashboard.dart';
import 'package:big_basket/screens/user_login/login_sliding_image.dart';
import 'package:big_basket/screens/user_login/user_login.dart';
import 'package:big_basket/screens/user_registration/registration_new_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class drawer extends StatefulWidget {
  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  var username = "";
  var userEmail = "";
  var userPhoneNo = "";
  var userAddress = "";
  bool isLoading = false;

  getSharedData() async {
    final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
    final counter = prefs.getString('username') ?? "";

    final address = prefs.getString('userAddress');

    final useremail = prefs.getString('userEmail') ?? "";
    final phoneNo = prefs.getString('phone') ?? "";
    debugPrint("this is counter $counter");
    setState(() {
      username = counter;
      userEmail = useremail;
      userPhoneNo = phoneNo;
    });
    debugPrint("this is username $username");
  }

  getAddress() async {
    final prefs = await SharedPreferences.getInstance();

    final address = prefs.getString('userAddress')??"";

    setState(() {
      userAddress = address;

      debugPrint("this is userAddress $userAddress");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSharedData();
    getAddress();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            username == null || username == ""
                ? GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context)=>Login_Sliding_image()));
                    },
                    child: Container(
                      height: 120,
                      child: UserAccountsDrawerHeader(
                        accountName: Text("Login",
                            style: constantFontStyle(
                                fontWeight: FontWeight.w900, fontSize: 16)),
                        accountEmail: Text("tap to login",
                            style: constantFontStyle(
                                fontWeight: FontWeight.w500, fontSize: 10)),
                        decoration:const BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 120,
                    child: UserAccountsDrawerHeader(
                      accountName: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             Login_Sliding_image()));
                          },
                          child: Text(
                              "HELLO ${username.toString().toUpperCase()}",
                              style: constantFontStyle(
                                  fontWeight: FontWeight.w900, fontSize: 16))),
                      accountEmail: Text(userPhoneNo.toString(),
                          style: constantFontStyle(
                              fontWeight: FontWeight.w400, fontSize: 10)),
                      decoration:const BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  ),
            userAddress == null || userAddress.isEmpty
                ? ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text("Add Address",
                        style: constantFontStyle(
                            fontWeight: FontWeight.w500, fontSize: 10)),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAddress()));
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(userAddress.toString(),
                        style: constantFontStyle(
                            fontWeight: FontWeight.w500, fontSize: 10)),
                    trailing:const Icon(Icons.edit),
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAddress()));
                    },
                  ),
           const Divider(
              thickness: 1.0,
            ),
            ListTile(
              leading:const Icon(Icons.home),
              title: Text("Home",
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12)),
              onTap: () {
                setState(() {
                  Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                          builder: (BuildContext context) => DashBoardNew()));
                  // Navigator.push(context,
                  //     CupertinoPageRoute(builder: (context) => MyApp()));
                });

              },
            ),
            ListTile(
              trailing: SizedBox(child: Image.asset("assets/images/back_arrow.png",scale: 1.4,)),
              leading:const Icon(Icons.settings),
              title: Text("My Account",
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyAccountDashboard()));
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/fav_added1.png",height: 22,color: Colors.black87,),
              title: Text("Favorite List",
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>const favourite_main()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Smart List",
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>const RecommendationDashboard()));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Shop By Category",
                    style: constantFontStyle(fontWeight: FontWeight.w500,),
                  ),
                  const     Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                    thickness: 1.0,
                    color: Colors.black,
                  ),
                      ))
                ],
              ),
            ),
            ListTile(

              leading: Icon(Icons.local_offer),
              title: Row(
                children: [
                  Text("Offer",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500, fontSize: 12)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),
                          child: Text("New",style: constantFontStyle(fontSize: 10,color: Colors.white),),
                        )
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OfferList()));
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/headphones.png",scale: 1.5,),
              title: Text("Customer Service",
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>const CustomerServices()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("FeedBack",
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SubmitFeedback()));
              },
            ),
            ListTile(
              leading: Icon(Icons.live_help_outlined),
              title: Text("FAQ",
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQ()));
              },
            ),

            ListTile(
              leading: Image.asset("assets/images/follow.png",height: 22,color: Colors.black54,),
              title: Text("Follow Us",
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12)),
              onTap: () {

                _launchSocial('fb://profile/408834569303957', 'https://www.facebook.com/moticonfectionerypvtltd/');

              },
            ),
            username == null || username == ""
                ?  SizedBox():ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout",
                  style: constantFontStyle(
                      fontWeight: FontWeight.w500, fontSize: 12)),
              onTap: () async {
                setState(() {});
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
                Singleton.showmsg(context, "Message", "Logout Successfully");
              },
            )
          ],
        ),
      ),
    );
  }

  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
      await canLaunch(url);
      if (!launched) {
        await launch(fallbackUrl);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }
}
