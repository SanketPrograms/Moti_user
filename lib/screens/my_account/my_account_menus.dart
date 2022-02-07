import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/dashboard_new.dart';
import 'package:big_basket/payment/razorpay.dart';
import 'package:big_basket/screens/FAQ/faq.dart';
import 'package:big_basket/screens/customer_services/customer_services.dart';
import 'package:big_basket/screens/dashboard.dart';
import 'package:big_basket/screens/my_account/wallet_summary.dart';
import 'package:big_basket/screens/my_orders/my_orders.dart';
import 'package:big_basket/screens/terms_and_conditiions/terms_and_condition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAcccountMenus extends StatelessWidget {
  const MyAcccountMenus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyOrder()));
                },
                leading: Container(
                  // width: 50,
                  // height: 50,
                  child: Image.asset(
                    "assets/images/time_left.png",
                  //  scale: 10,
                    scale: 1.5,

                  ),
                ),
                title: Text(
                  "My Orders",
                  style: constantFontStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WalletSummary()));
                },
                leading: Container(
                  // width: 50,
                  // height: 50,
                  child: Image.asset(
                    "assets/images/wallet.png",
                    scale: 1.5,

                    //  scale: 10,
                  ),
                ),
                title: Text(
                  "My Wallet",
                  style: constantFontStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              // ListTile(
              //   onTap: () {
              //    // Navigator.push(context,
              //  //       MaterialPageRoute(builder: (context) => RazorpayPayement()));
              //   },
              //   leading: Container(
              //     // width: 50,
              //     // height: 50,
              //     child: Image.asset(
              //       "assets/images/valid.png",
              //       scale: 1.5,
              //
              //       //  scale: 10,
              //     ),
              //   ),
              //   title: Text(
              //     "My Payment",
              //     style: constantFontStyle(fontWeight: FontWeight.w500),
              //   ),
              // ),
              // const Divider(
              //   thickness: 1,
              // ),


              // ListTile(
              //   leading: Container(
              //     // width: 50,
              //     // height: 50,
              //     child: Image.asset(
              //       "assets/images/stars.png",
              //       scale: 1.5,
              //
              //       //  scale: 10,
              //     ),
              //   ),
              //   title: Text(
              //     "My Ratings",
              //     style: constantFontStyle(fontWeight: FontWeight.w500),
              //   ),
              // ),


              // const Divider(
              //   thickness: 1,
              // ),
              ListTile(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CustomerServices()));
                },
                leading: Container(
                  // width: 50,
                  // height: 50,
                  child: Image.asset(
                    "assets/images/headphones.png",
                    scale: 1.5,

                    //  scale: 10,
                  ),
                ),
                title: Text(
                  "Customer Services",
                  style: constantFontStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              // ListTile(
              //   leading: Container(
              //     // width: 50,
              //     // height: 50,
              //     child: Image.asset(
              //       "assets/images/gift-card.png",
              //       scale: 1.5,
              //
              //       //  scale: 10,
              //     ),
              //   ),
              //   title: Text(
              //     "My Gift Card",
              //     style: constantFontStyle(fontWeight: FontWeight.w500),
              //   ),
              // ),
              // const Divider(
              //   thickness: 1,
              // ),

              ListTile(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TermsANDConditions()));
                },
                leading: Container(
                  // width: 50,
                  // height: 50,
                  child: Image.asset(
                    "assets/images/terms.png",
                    scale: 5,
                    height: 25,

                    //  scale: 10,
                  ),
                ),
                title: Text(
                  "Terms and Conditions",
                  style: constantFontStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FAQ()));
                },
                leading: Container(
                  // width: 50,
                  // height: 50,
                  child: Image.asset(
                    "assets/images/faq_icon.jpg",
                    scale: 5,
                    height: 25,

                    //  scale: 10,
                  ),
                ),
                title: Text(
                  "FAQ",
                  style: constantFontStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                onTap: () async{

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                          builder: (BuildContext context) => DashBoardNew()));                  Singleton.showmsg(context, "Message", "Logout Successfully");
                },
                leading: Container(
                  // width: 50,
                  // height: 50,
                  child: Image.asset(
                    "assets/images/logout.png",
                    scale: 1.5,

                    //  scale: 10,
                  ),
                ),
                title: Text(
                  "LogOut",
                  style: constantFontStyle(fontWeight: FontWeight.w500,),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
