import 'package:big_basket/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationText extends StatelessWidget {
  const RecommendationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.blueGrey.shade100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Text(
                  "Our Recommendation For You",
                  style: constantFontStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
                Text("Best On What Customer  Like We Have Bought",
                    style: constantFontStyle(fontWeight: FontWeight.w500,fontSize: 12)),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
