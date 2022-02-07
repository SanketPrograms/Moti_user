import 'package:big_basket/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


PreferredSizeWidget customAppBar(title) {
  return AppBar(
    centerTitle: true,
      actions: const [

        // Padding(
        //   padding: EdgeInsets.all(paddingAll),
        //   child: Icon(
        //       Icons.notifications_active
        //   ),
        // ),
      ],

      title: Row(
        children: [
          Text(title, style: constantFontStyle(

              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white
          )),

        ],
      ),
      backgroundColor: themeColor
  );
}
