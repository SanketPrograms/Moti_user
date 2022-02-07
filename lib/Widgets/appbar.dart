import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/my_account/my_account.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


PreferredSizeWidget appBar(context) => AppBar(
      actions:  [

        Padding(
          padding:  EdgeInsets.all(paddingAll),
          child: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAccountDashboard()));
            },
            icon: Icon(
                Icons.person
            ),
          ),
        ),
      ],

      title: Row(
        children: [
          Text(applicationName,style: constantFontStyle(

              fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white
          )),

        ],
      ),
      backgroundColor: themeColor
  );

