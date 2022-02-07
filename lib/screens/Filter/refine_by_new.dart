import 'dart:convert';

import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/Filter/filtereddata.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RefineBy extends StatefulWidget {
  const RefineBy({Key? key}) : super(key: key);

  @override
  _RefineByState createState() => _RefineByState();
}

class _RefineByState extends State<RefineBy> {

  List<String> BrandName = [];
  List<String> VariantName = [];
  List<String> BrandId = [];
  List<String> VariantId = [];
  List<String> Price = ["Low to Higher","Higher to Lower"];
  List<String> Discount = ["Higher Discount","Lower Discount"];
  List<String> foodPreference = ["Vegetarian","Non-Vegetarian"];
  int? priceRadioBtn;
  int? discountRadioBtn;
  int? food_preferenceRadioBtn;
  var sendBrandID;
  var sendPrice;
  var sendDiscount;
  var sendFoodPreference;
  var sendVariant = [];


  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    //  getData();

    getBrand();
    getVariants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BrandWidget (),
            PriceWidget (),
            DiscountWidget (),
            FoodPreferenceWidget (),
            VariantsWidget(),
            Padding(

              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // OutlinedButton(
                  //   style: ButtonStyle(
                  //     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0))),
                  //   ),
                  //     onPressed: () {
                  //
                  //     setState(() {
                  //       for(int i = 0; i <variantCheckBox.length ; i++) {
                  //         variantCheckBox.add(false);
                  //       }
                  //     //   brandCheckBox.clear();
                  //     //    discountCheckBox.clear();
                  //     //  foodPreferenceCheckBox.clear();
                  //     // priceCheckBox.clear();
                  //     });
                  //     },
                  //     child: Text(
                  //       "Clear All",
                  //       style: constantFontStyle(
                  //           color: blackColor, fontWeight: FontWeight.w600),
                  //     ),),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: blackColor),
                      onPressed: () {
                        sendJsonData();
                      },
                      child: Text("  Done  ",
                          style: constantFontStyle(
                                 fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
      );
  }


  Widget BrandWidget () {

    return ExpansionTile(title: Text("Brand",style: constantFontStyle(
      fontSize: 13,fontWeight: FontWeight.bold
    ),),children: [
      ListView.builder(
            shrinkWrap: true,
            itemBuilder:  (BuildContext context, int index) {
              return       Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: paddingAllHorizontal),
                          child: Text(
                            BrandName[index],
                            style: constantFontStyle(fontSize: Fontsize),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child:
                        Checkbox(activeColor: themeColor,
                          //title: Text(_texts[index]),
                          value: brandCheckBox[index],

                          onChanged: (val) {
                            setState(
                                  () {
                                    brandCheckBox[index] = val!;
                                    sendBrandID =   BrandId[index];
                              },
                            );
                          },
                        )
                      )
                    ],
                  ),

                ],



              );
    },
            itemCount: BrandName.length,
          ),
    ],);
  }
  Widget PriceWidget () {

    return ExpansionTile(title: Text("Price",style: constantFontStyle(
      fontSize: 13,fontWeight: FontWeight.bold
    ),),children: [
      ListView.builder(
            shrinkWrap: true,
            itemBuilder:  (BuildContext context, int index) {
              return       Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: paddingAllHorizontal),
                          child: Text(
                            Price[index],
                            style: constantFontStyle(fontSize: Fontsize),
                          ),
                        ),
                      ),

                      Expanded(
                        child:
                        RadioListTile<int>(
                            activeColor: themeColor,
                            value: index,
                            groupValue: priceRadioBtn,
                            onChanged: (ind) { setState(() {

                              priceRadioBtn = ind!.toInt();

                              debugPrint(priceRadioBtn.toString());
                              if(priceRadioBtn == 0){
                                sendPrice = "asc";
                              }else{
                                sendPrice = "desc";
                              }

                            });
                            }

                        ),
                      )
                    ],
                  ),

                ],



              );
    },
            itemCount: Price.length,
          ),
    ],);
  }
  Widget DiscountWidget () {

    return ExpansionTile(title: Text("Discount",style: constantFontStyle(
      fontSize: 13,fontWeight: FontWeight.bold
    ),),children: [
      ListView.builder(
            shrinkWrap: true,
            itemBuilder:  (BuildContext context, int index) {
              return       Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: paddingAllHorizontal),
                          child: Text(
                            Discount[index],
                            style: constantFontStyle(fontSize: Fontsize),
                          ),
                        ),
                      ),

                      Expanded(
                        child: RadioListTile<int>(
                            activeColor: themeColor,
                            value: index,
                            groupValue: discountRadioBtn,
                            onChanged: (ind) { setState(() {

                              discountRadioBtn = ind!.toInt();

                              if(discountRadioBtn == 1){
                                sendDiscount   = "asc";
                              }else{
                                sendDiscount = "desc";
                              }
                            });
                            }

                        ),
                      )
                    ],
                  ),

                ],



              );
    },
            itemCount: Discount.length,
          ),
    ],);
  }
  Widget FoodPreferenceWidget () {

    return ExpansionTile(title: Text("Food Preference",style: constantFontStyle(
      fontSize: 13,fontWeight: FontWeight.bold
    ),),children: [
      ListView.builder(
            shrinkWrap: true,
            itemBuilder:  (BuildContext context, int index) {
              return       Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: paddingAllHorizontal),
                          child: Text(
                            foodPreference[index],
                            style: constantFontStyle(fontSize: Fontsize),
                          ),
                        ),
                      ),

                      Expanded(
                        child: RadioListTile<int>(
                            activeColor: themeColor,

                            value: index,
                            groupValue: food_preferenceRadioBtn,
                            onChanged: (ind) { setState(() {

                              food_preferenceRadioBtn = ind!.toInt();
                              if(discountRadioBtn == 1){
                                sendFoodPreference   = "1";
                              }else{
                                sendFoodPreference = "2";
                              }

                            });
                            }

                        ),
                      )
                    ],
                  ),

                ],



              );
    },
            itemCount: foodPreference.length,
          ),
    ],);
  }
  Widget VariantsWidget() {

    return ExpansionTile(title: Text("Select Variants",style: constantFontStyle(
      fontSize: 13,fontWeight: FontWeight.bold
    ),),children: [
      ListView.builder(
        physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder:  (BuildContext context, int index) {
              return       Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: paddingAllHorizontal),
                          child: Text(
                            VariantName[index],
                            style: constantFontStyle(fontSize: Fontsize),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Checkbox(
                          //title: Text(_texts[index]),
                          activeColor: themeColor,
                          value: variantCheckBox[index],
                          onChanged: (val) {
                            setState(
                                  () {
                                    variantCheckBox[index] = val!;

                                  },
                            );
                          },
                        )
                      )
                    ],
                  ),

                ],



              );
    },
            itemCount: VariantName.length,
          ),
    ],);
  }



  getBrand() async {

    var response = await http.get(Uri.parse("$brandsApi"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      debugPrint(data.toString());

      BrandName.clear();
      BrandId.clear();
      brandCheckBox.clear();


      for (int i = 0; i < data["result"].length; i++) {
        BrandName.add(data["result"][i]["name"]);
        BrandId.add(data["result"][i]["id"]);

        brandCheckBox.add(false);
      }
      discountCheckBox.clear();
      foodPreferenceCheckBox.clear();
      priceCheckBox.clear();
      for(int j = 0; j < 2; j++){

      discountCheckBox.add(false);
        foodPreferenceCheckBox.add(false);
       priceCheckBox.add(false);
      }

      setState(() {
       // SubcategoryLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }
  getVariants() async {

    var response = await http.get(Uri.parse(variantApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      debugPrint(data.toString());

      VariantName.clear();
      VariantId.clear();
      variantCheckBox.clear();

      var s = [];

      for (int i = 0; i < data["result"].length; i++) {
        VariantName.add(data["result"][i]["name"]);
        VariantId.add(data["result"][i]["id"]);
        variantCheckBox.add(false);

      }

      setState(() {
       // SubcategoryLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }

  void onChanged(bool? value) {
    setState(() {});
    filterValue = !filterValue;
  }

  sendJsonData() async{
    sendVariant.clear();
    for(int i = 0; i < variantCheckBox.length; i++) {
      if (variantCheckBox[i] == true) {
        sendVariant.add(VariantId[i]);
      }
    }
    String sendFilteredData =
        '{"brand": $sendBrandID, "price": $sendPrice,"discount":$sendDiscount,"food_preference":$sendFoodPreference,"variants":$sendVariant}';



    Navigator.push(context, MaterialPageRoute(builder: (context)=>filteredData(filterdata: sendFilteredData,)));


  }
  bool filterValue = false;
  List<bool> variantCheckBox = [];
  List<bool> brandCheckBox = [];
  List<bool> discountCheckBox = [];
  List<bool> foodPreferenceCheckBox = [];
  List<bool> priceCheckBox = [];

}
