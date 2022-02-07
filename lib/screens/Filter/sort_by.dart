import 'package:big_basket/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RadioListBuilder extends StatefulWidget {


 const  RadioListBuilder({Key? key}) : super(key: key);

  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
   int value = 0;
  int num = 6;
  List<String> sortTypeList = ["Popularity","Price - Low to High","Price - High to Low","Alphabetical","Rupee Saving - Low to High","% Off - High to Low"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: sortTypeList.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Expanded(flex:3,child: Text(sortTypeList[index],style: constantFontStyle())),
                        Expanded(child:
                        RadioListTile<int>(
                          activeColor: Colors.black87,
                          value: index,
                          groupValue: value,
                          onChanged: (ind) { setState(() {

                            value = ind!.toInt();


                          });
                          }

                        ),
                        )
                      ],
                    ),
                  ),

                ],
              );
            },

          ),
        ),
        const Divider(thickness: 1,),
        ElevatedButton(style:ElevatedButton.styleFrom(primary: blackColor),onPressed: (){}, child: Text("Done",style: constantFontStyle(color: Colors.white,fontWeight: FontWeight.bold))),
        SizedBox(height: 30,)
      ],
    );
  }
}