import 'package:big_basket/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackOrder extends StatelessWidget {
   TrackOrder({Key? key}) : super(key: key);
   var trackColor = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:         Colors.blueGrey.shade100,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(

                      child: FloatingActionButton(

                        backgroundColor: themeColor,
                        onPressed: () {},
                        child: Icon(Icons.shopping_cart),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Order PLaced",
                        style: constantFontStyle(
                          color: Colors.black,fontWeight: FontWeight.bold
                        ),
                      ))
                ],
              ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55.0),
                    child: Container(
                      width: 2,
                      height: MediaQuery.of(context).size.height/9,
                      color: trackColor==1?Colors.white70:themeColor,
                    ),
                  ),
              Row(
                children: [
                  Expanded(
                    child: FloatingActionButton(
                      backgroundColor:  trackColor==1?Colors.red.shade300:themeColor,
                      onPressed: () {},
                      child: Icon(CupertinoIcons.home),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Order Dispatched",
                        style: constantFontStyle(
                            color:trackColor==1?Colors.grey: Colors.black,fontWeight: FontWeight.bold
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: Container(
                  width: 2,
                  height: MediaQuery.of(context).size.height/9,
                  color: trackColor==1?Colors.white70:themeColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FloatingActionButton(
                      backgroundColor:  trackColor==1?Colors.red.shade300:themeColor,
                      onPressed: () {},
                      child: Icon(Icons.delivery_dining),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Out for Delivery",
                        style: constantFontStyle(
                            color: trackColor==1?Colors.grey: Colors.black,fontWeight: FontWeight.bold
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: Container(
                  width: 2,
                  height: MediaQuery.of(context).size.height/9,
                  color: trackColor==1?Colors.white70:themeColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FloatingActionButton(
                      backgroundColor:  trackColor==1?Colors.red.shade300:themeColor,
                      onPressed: () {},
                      child: Icon(Icons.assignment_outlined),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "SuccessFully Delivered",
                        style: constantFontStyle(
                            color: trackColor==1?Colors.grey: Colors.black,fontWeight: FontWeight.bold
                        ),
                      ))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
