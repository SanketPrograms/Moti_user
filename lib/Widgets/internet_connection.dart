import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class internetConnection extends StatelessWidget {
  const internetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:
        Card(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Image.asset("assets/images/no_internet.gif",),
              Text("No Internet",style: constantFontStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              Text("Make Sure You are connected To Internet",style: constantFontStyle(fontSize: 12,fontWeight: FontWeight.w500),),
               SizedBox(height: 10,),
            Container(
              width: 150,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.white54),
                    foregroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyApp()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //   Icon(Icons.),
                      Text(
                        "Retry",
                        style: constantFontStyle(
                            fontSize: Fontsize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  )),
            )
            ],
          ),
        )
      ));
  }
}
