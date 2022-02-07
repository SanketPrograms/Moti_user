import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/Filter/refine_by_new.dart';
import 'package:big_basket/screens/Filter/sort_by.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterMainScreen extends StatelessWidget {
  const FilterMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(

            appBar: AppBar(
              backgroundColor: themeColor,
              centerTitle:true,
              title:  Text('Filter',style: constantFontStyle(
                  fontWeight: FontWeight.w500
              ),),
              bottom:    PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: ColoredBox(
                    color: Colors.white,
                    child:  Container(child: _tabBar)
                ),
              ),
            ),
            body:const TabBarView(

              children: [
                Padding(
                  padding: EdgeInsets.all(paddingAllTwo),
                  child: Card(child: RefineBy()),
                ),
                Padding(
                    padding: EdgeInsets.all(paddingAllTwo),
                    child: Card(child: RadioListBuilder()))
              ],




            )));
  }
  TabBar get _tabBar =>  TabBar(
    indicatorColor: themeColor,
    indicator:const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0),
        insets: EdgeInsets.symmetric(horizontal:20.0)
    ),

    tabs: [
      Tab(child: Text("Refine by",style: constantFontStyle(color: Colors.black),), ),
      Tab(child: Text("Sort by",style: constantFontStyle(color: Colors.black)) ),
    ],
  );
}