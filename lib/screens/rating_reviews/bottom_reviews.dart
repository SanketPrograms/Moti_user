import 'package:flutter/material.dart';

class bottom_reviews extends StatelessWidget {
  const bottom_reviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Product Reviews"),
        dynamicListview()

      ], 
    );
  }


  Widget dynamicListview() {
    // print("this is findword $findWord");
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
          itemCount: 9,
          //  itemCount: title.length,
          shrinkWrap: true,
          //  physics: const ScrollPhysics(),
          itemBuilder: (context, index)
      {
        return Container(child: Text(""));
      }
      );});}
      }
