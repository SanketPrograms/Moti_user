import 'dart:convert';

import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/product_details/product_details_new.dart';
import 'package:big_basket/screens/product_list/product_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class SearchHorizontalCards extends StatefulWidget {


  SearchHorizontalCards({Key? key}) : super(key: key);

  @override
  State<SearchHorizontalCards> createState() => _SearchHorizontalCardsState();
}

class _SearchHorizontalCardsState extends State<SearchHorizontalCards> {
  List<String> Carditems = ["All","Baby Care","Beauty & Hygiene"];
  List<String>  ProductName = [];
  List<String>  ProductImage = [];
  List<String>  productId = [];
  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ?Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
        :  Container(
      height: 150,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Center(child: dynamicHorizontalListview())),
              ],


    ),
        );
  }

  Widget dynamicHorizontalListview() {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ProductName.length,
          //  itemCount: title.length,
     //     shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return
              GestureDetector(
                onTap: (){

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailsNew(
                            productId: productId[index],
                          )));
     //             Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductList(BannerImageList:widget.BannerImageList,category:widget.categoryid,subcategory:SubcategoryId[index])));
                },
                child: Container(
                  width:MediaQuery.of(context).size.width/3,
                  height: MediaQuery.of(context).size.height,
                  child: Card(
               // /       semanticContainer: true,
                   //   clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      // margin: EdgeInsets.all(10),
                      child: Column(
                        children: [

                          // subtitle: Text(description[index]),
                          Padding(
                            padding: const EdgeInsets.all(paddingAllTwo),
                            child: Container(
                              width:100,
                              height: 100,
                              child:
                            ClipRRect(
                                borderRadius: new BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0)),
                                child: CachedNetworkImage(
                                  errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),

                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),),
                                  imageUrl: ProductImage[index],

                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )),

                            ),
                          ),

                          // Expanded(
                          //     flex: 4,
                          //     child: Image.network(
                          //         categoryImage[index],fit: BoxFit.fill,)),
                          Container(
                            decoration: BoxDecoration(
                              //   color: Colors.black12,
                              // border: Border.all(),
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                                child: Text(
                                  ProductName[index],
                                  style: constantFontStyle(
                                      fontSize: Fontsize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )),
                          )
                        ],
                      )),
                ),
              );
          });
    });
  }

  getData() async {
    var userID;
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userId');
    debugPrint("this is userid $userID");
    var response = await http.get(Uri.parse(
        "$recommendationApi?userid=$userID"));
    //var response = await http.get(Uri.parse("$product?userid=$userID&vendor=5&subcategory=3&category=3}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      debugPrint("this is data${data.toString()}");
      setState(() {
        ProductName.clear();
        ProductImage.clear();
        productId.clear();


        var s = [];

        for (int i = 0; i < data["result"].length; i++) {
          ProductName.add(data["result"][i]["name"]);

          productId.add(data["result"][i]["id"]);
         // productDescription.add(data["result"][i]["description"]);


            if (data["result"][i]["imgs"].length <= 0) {
              ProductImage.add(
                  "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png");
            } else {
              // for (int j = 0; j < data["result"][i]["imgs"].length; j++) {
                ProductImage.add(data["result"][i]["imgs"][0]["imgpath"]);
              //}


          }
          // for (int j = 0; j < data["result"][i]["opts"].length; j++) {
          //   price.add(data["result"][i]["opts"][j]["price"].toString());
          //   discountprice.add(data["result"][i]["opts"][j]["dprice"].toString());
          //   ProductVariant.add(data["result"][i]["opts"][j]["variants"].toString());
          // }
        }
      //  print("this is image $ProductImage");


        // subList = s;


        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }
}
