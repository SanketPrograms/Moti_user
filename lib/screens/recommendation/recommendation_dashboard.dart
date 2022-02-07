import 'package:big_basket/Widgets/appbar.dart';
import 'package:big_basket/Widgets/drawer.dart';
import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/screens/recommendation/recommendation_listview.dart';
import 'package:big_basket/screens/recommendation/recommendation_text.dart';
import 'package:big_basket/screens/recommendation/top_cards.dart';
import 'package:big_basket/screens/search/searchnavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationDashboard extends StatelessWidget {
  const RecommendationDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return Singleton.handleBack(context);

      },
      child: Scaffold(

        drawer: drawer(),
       appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed:(){  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchNavigation()));} ,icon: Icon(Icons.search)),
            ),

          ],
         backgroundColor: themeColor,
         title: Text("Your Shopping List",style: constantFontStyle(
           fontSize: 14,
         ),),
         centerTitle: true,
       ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
           //
          //   TopCards(),
            RecommendationText(),
            RecommendationListview()
          ],),
        ),
      ),
    );
  }
}
