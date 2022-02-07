import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/favourite_page/favourite_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class favourite_main extends StatelessWidget {
  const favourite_main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text("Favorites",style: constantFontStyle(fontSize: 14),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FavouriteList(),
        ],
      ),
    );
  }
}
