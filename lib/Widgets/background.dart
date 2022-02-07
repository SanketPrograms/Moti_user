import 'package:big_basket/constants/constant.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/top1.png",
                color: themeColor,
                width: size.width
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(

                "assets/images/top2.png",
                color: themeColor,
                width: size.width

            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Image.asset(
                "assets/images/main.png",

                width: size.width * 0.35
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom1.png",
                color: themeColor,
                width: size.width
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom2.png",
                color: themeColor,
                width: size.width
            ),
          ),
          child
        ],
      ),
    );
  }
}