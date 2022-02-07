import 'package:big_basket/constants/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopCards extends StatelessWidget {

  List<String> Carditems = ["All","Baby Care","Beauty & Hygiene"];
   TopCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    SafeArea(
      child: Container(
            width:double.infinity,
            height: 80,
            color: Colors.blueGrey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Container(height:50,child: Center(child: dynamicHorizontalListview()))),
              ],
            )),

    );
  }

  Widget dynamicHorizontalListview() {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Carditems.length,
          //  itemCount: title.length,
          shrinkWrap: true,
          //  physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return   
                Container(
                   // height: 50,
                     width: MediaQuery.of(context).size.width/Carditems.length,
                    child: Card(
                                  color: Colors.white,
                                  //borderOnForeground: true,
                                  elevation: elevation_size,
                                  child: Padding(
                                    padding: const EdgeInsets.all(paddingAllTwo),
                                    child: Center(
                                      child: Text(
                                        Carditems[index],
                                        style: constantFontStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color:Carditems[index] == "All"?Colors.redAccent:Colors.black
                                        ),
                                      ),
                                    ),
                                  ),


                      ),



            );
          });
    });
  }
}
