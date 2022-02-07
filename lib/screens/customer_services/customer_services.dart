import 'package:big_basket/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerServices extends StatelessWidget {
  const CustomerServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        centerTitle: true,
        title: Text("Customer Services", style: constantFontStyle(
            fontWeight: FontWeight.w500,

            fontSize: 14,
            color: Colors.white),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  SizedBox(
                          height: 1,
                        ),

                        Text(
                          "How do I contact customer service?",
                          style: constantFontStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Our customer service team is available throughout the week, all seven days from 6 am to 10 pm. They can be reached at 18601231000 or via email at customerservice@MotiConfectionery.com",
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 12),
                        ),const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "What are your timings to contact customer service?",
                            style: constantFontStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14),
                        ),
                        const   SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Our customer service team is available throughout the week, all seven days from 6 am to 10 pm.",
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                        const    SizedBox(
                          height: 10,
                        ),
                        Text(
                          "How can I give feedback on the quality of customer service?",
                          style: constantFontStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14),
                        ),
                        const    SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Our customer support team constantly strives to ensure the best shopping experience for all our customers. We would love to hear about your experience with MotiConfectionery. Do write to us atkbn@MotiConfectionery.com in case of positive or negative feedback.",
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                        const    SizedBox(
                          height: 10,
                        ),
                        Text(
                          "How do I raise a claim with customer service for any of the Guarantees - Delivery Guarantee, Quality Guarantee?",
                          style: constantFontStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14),
                        ),
                        const  SizedBox(
                          height: 5,
                        ),
                        Text(
                          "If you face any issues with price, quality or delivery of products we will take every measure to address the issue and make it up to you. Please contact our customer support team with details or your order as well as the issue you faced.",
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                        const  SizedBox(
                          height: 10,
                        ),

                        Text(
                          "Will MotiConfectionery ask for sensitive information such as bank account details, PIN number, card number?",
                          style: constantFontStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14),
                        ),
                        const  SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Please note that our customer service team will never ask you to share information other than your email ID, phone number, and name registered with MotiConfectionery. If you get any email, call or message from anyone claiming to be from MotiConfectionery asking for sensitive information such as bank account details, PIN number, card number, etc., please do not share it.",
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 12),
                        ),
                        const   SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
