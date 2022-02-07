import 'dart:convert';

import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/payment/razorpay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WalletSummary extends StatefulWidget {
   WalletSummary({Key? key}) : super(key: key);

  @override
  State<WalletSummary> createState() => _WalletSummaryState();
}

class _WalletSummaryState extends State<WalletSummary> {
   double paddingAll = 15;
   bool isLoading = true;

   List wallet_date = [];
   List paymentType = [];
   List amount = [];
   var totalBlance;


   @override
  void initState() {
    // TODO: implement initState

     getWalletData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey.shade100,
       appBar: customAppBar("Wallet Summary"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopWalletSummary(),
            FundWalletButton(context),
            isLoading
                ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
                : WalletActivityDates(),
            //BelowText()
          ],
        ),
      ),
    );
  }

  Widget TopWalletSummary(){

    return  Card(
        child: ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text("Walllet Summary",style: Titlefont,),
          subtitle: Text("Current Balance Rs $totalBlance",style: subTitlefont,),
        ),

    );

}

Widget FundWalletButton(context){
    return Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          height:     40,
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(        Colors.black,),
            ),
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RazorpayPayement()));
            },
            child: Text("ADD Fund",style: subTitlefont,),
          ),
        ),

    );
}

   Widget WalletActivityDates(){
     return  Card(
         child: ListTile(
           title: Text("Wallet Acivity for",style: Titlefont,),
           subtitle:dynamicListview()
         ),

     );
   }

   // Widget BelowText(){
   //   return   Center(
   //         child: dynamicListBelowText(),
   //
   //
   //   );
  // }

   getWalletData() async {
     final prefs = await SharedPreferences.getInstance();

     final userId = prefs.getString('userId');

     debugPrint("this is userID $userId");
     var response = await http.get(Uri.parse("$walletApi?userid=$userId"));
     if (response.statusCode == 200) {
       var data = jsonDecode(response.body);
       debugPrint(data.toString());

       wallet_date.clear();
       amount.clear();
       paymentType.clear();
       if (data["status"] == "200") {

         for (int i = 0; i < data["result"].length; i++) {


           wallet_date.add(data["result"][i]["t_date"].toString().split(" ").first);
           amount.add(data["result"][i]["amount"]);
           paymentType.add(data["result"][i]["otype"]);
         }
         totalBlance =   data["balance"].toString();

         // subList = s;

         setState(() {
           isLoading = false;
         });
       } else {
         setState(() {
           isLoading = false;

         });
       }
     } else {
       debugPrint("Error in the Api");
     }
   }

   Widget dynamicListview() {
     // print("this is findword $findWord");     return LayoutBuilder(builder: (context, constraints) {
       return ListView.builder(
         physics: BouncingScrollPhysics(),
           itemCount: wallet_date.length,

           shrinkWrap: true,
           itemBuilder: (context, index)
       {
         return   Padding(
           padding: const EdgeInsets.all(2.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(wallet_date[index],style:  constantFontStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.red) ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("₹"+amount[index],style:  GoogleFonts.cherrySwash(fontSize: 12,fontWeight: FontWeight.w700,color: Colors.red)),
               ),   Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(paymentType[index],style:  GoogleFonts.cherrySwash(fontSize: 12,fontWeight: FontWeight.w700,color: Colors.red)),
               ),
               Divider()

             ],

           ),
         );
       });}}

Widget dynamicListBelowText() {
  // print("this is findword $findWord");     return LayoutBuilder(builder: (context, constraints) {
  return ListView.builder(
      itemCount: 3,

      shrinkWrap: true,
      itemBuilder: (context, index)
      {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",style: subTitlefont),
              const Divider()
            ],
          ),
        );
      });}

