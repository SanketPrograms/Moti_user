import 'package:big_basket/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity/connectivity.dart';

class Singleton {

  static void showmsg(BuildContext context, title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title,style: constantFontStyle(fontWeight: FontWeight.bold),),
            content: Text(text,style: constantFontStyle(fontWeight: FontWeight.w500),),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }



//---------------------------checking the InternetConnectivity----------------------------------------------

  static void checkInternetConnectivity(context) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Singleton.showmsg(
          context, 'No internet', "You're not connected to a any network");
    }
  }

  static Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static  void showInSnackBar(BuildContext context,String value) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    Scaffold.of(context).showSnackBar(new SnackBar(
      key: _scaffoldKey,
      content: new Text(value),


    ),);
  }

  // static Future onBackPressed(context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Are you sure?'),
  //         content: Text('Do you want to exit this App'),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('No'),
  //             onPressed: () {
  //               Navigator.of(context).pop(false);
  //             },
  //           ),
  //           FlatButton(
  //             child: Text('Yes'),
  //             onPressed: () {
  //               Navigator.of(context).pop(true);
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   ) ?? false;
  // }

 static handleBack(context) => showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit this App'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    },
  );

}


