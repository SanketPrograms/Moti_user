import 'package:big_basket/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "FAQ",
          style: constantFontStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Image.asset("assets/images/logo.png"),
              const   SizedBox(
                height: 0,
              ),
              Text(
                "Kindly check the FAQ below if you are not very familiar with the functioning of this website. If your query is of urgent nature and is different from the set of questions then please contact us at:Email: customerservice@MotiConfectionery.comCall us: 1860 123 1000Chat with us in-app under customer service /Need Help sectionfrom 6 am & 10 pm on all days including Sunday to get our immediate helpIf you are not satisfied with the resolution provided by us, then please write to our Grievance Officer at grievanceofficer@MotiConfectionery.com.",
                style: constantFontStyle(fontWeight: FontWeight.bold),
              ),
              const   SizedBox(
                height: 40,
              ),
              /////////////////////////////////Registration//////////////////////
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                            child: Text(
                              "Registration",
                              style: constantFontStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
                    const  SizedBox(
                      height: 10,
                    ),

                    Text(
                      "How do I register?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    const  SizedBox(
                      height: 10,
                    ),
                    Text(
                      "You can register by clicking on the Register link at the top right corner of the homepage. Please provide the information in the form that appears. You can review the terms and conditions, provide your payment mode details and submit the registration information.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    Text(
                      "Are there any charges for registration?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    const  SizedBox(
                      height: 5,
                    ),
                    Text(
                      "No. Registration on MotiConfectionery.com is absolutely free.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Do I have to necessarily register to shop on MotiConfectionery?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                "You can surf and add products to the cart without registration but only registered shoppers will be able to checkout and place orders. Registered members have to be logged in at the time of checking out the cart, they will be prompted to do so if they are not logged in",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Can I have multiple registrations?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Each email address and contact phone number can only be associated with one MotiConfectionery account.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Can I add more than one delivery address in an account?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Yes, you can add multiple delivery addresses in your MotiConfectionery account. However, remember that all items placed in a single order can only be delivered to one address. If you want different products delivered to different address you need to place them as separate orders.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Can I have multiple accounts with same mobile number and email id?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Each email address and phone number can be associated with one MotiConfectionery account only",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              /////////////////////////////////Account Related//////////////////////
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                            child: Text(
                              "Account Related",
                              style: constantFontStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      "What is My Account?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "My Account is the section you reach after you log in at MotiConfectionery.com. My Account allows you to track your active orders, credit note details as well as see your order history and update your contact details.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    Text(
                      "How do I reset my password?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "You need to enter your email address on the Login page and click on forgot password. An email with a reset password will be sent to your email address. With this, you can change your password. In case of any further issues please contact our customer support team.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "What are credit notes & where can I see my credit notes?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                "Credit notes reflect the amount of money which you have pending in your MotiConfectionery account to use against future purchases. This is calculated by deducting your total order value minus undelivered value. You can see this in My Account under credit note details.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "What is My Shopping List?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "My Shopping List is a comprehensive list of all the items previously ordered by you on MotiConfectionery.com. This enables you to shop quickly and easily in future.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
              /////////////////////////////////Payment//////////////////////
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                            child: Text(
                              "Payment",
                              style: constantFontStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      "What are the modes of payment?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "You can pay for your order on MotiConfectionery.com using the following modes of payment:\na. Cash on delivery (COD)\nb. Credit and debit cards (VISA / Mastercard / Rupay)\nc. Paytm food wallet will be accepted only for food items",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ), SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Are there any other charges or taxes in addition to the price shown? Is VAT added to the invoice?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "There is no VAT. However, GST will be applicable as per Government Regulizations.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Is it safe to use my credit/ debit card on MotiConfectionery?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                "Yes it is absolutely safe to use your card on MotiConfectionery.com. A recent directive from RBI makes it mandatory to have an additional authentication pass code verified by VISA (VBV) or MSC (Master Secure Code) which has to be entered by online shoppers while paying online using visa or master credit card. It means extra security for customers, thus making online shopping safer",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "What is the meaning of cash on delivery?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Cash on delivery means that you can pay for your order at the time of order delivery at your doorstep.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
              /////////////////////////////////Order Related//////////////////
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                            child: Text(
                              "Order Related",
                              style: constantFontStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      "What are delivery slots?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Delivery slots are time slots during which you will receive your order.",
                        style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ), SizedBox(
                      height: 10,
                    ),
                    Text(
                      "What is a cut-off time and what are the corresponding cut-off timing for each slot?",
                        style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Cut off time is the time after which the order gets processed for delivery. After this time you will not be able to modify or cancel your order, cut off time for Slot 3 & Slot 4 is 12 noon on the same day and cut off time for Slot 1 & Slot 2 is 7 pm on the previous day. Actual cut off timings for HYD : For Slot 3 & Slot 4 is 11 AM on the same day and for Slot 1 & Slot 2 is 6 PM on the previous day.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Can I add products after the cut off time for a slot?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "No, you will not be able to make any changes to your order after the cut off time for your selected slot. However, if you do not wish to buy a product you may return it at the time of delivery and the amount will be credited to your MotiConfectionery account.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "How can I check availability of next slot before placing order?",
                      style: constantFontStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Once you log in to your account, you will notice that on the right side of the website, under My Basket the next available slot in which you can order will be displayed.",
                      style: constantFontStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
