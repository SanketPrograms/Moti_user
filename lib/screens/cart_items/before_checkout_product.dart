import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/screens/product_details/product_details_new.dart';
import 'package:big_basket/screens/product_list/product_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BeforeCheckOutProduct extends StatefulWidget {
  BeforeCheckOutProduct({Key? key}) : super(key: key);

  @override
  State<BeforeCheckOutProduct> createState() => _BeforeCheckOutProductState();
}

class _BeforeCheckOutProductState extends State<BeforeCheckOutProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> Carditems = ["All", "Baby Care", "Beauty & Hygiene"];
  List<String> ProductName = [];
  List<String> ProductImage = [];
  List<String> productId = [];
  List<String> AddedToCart = [];
  List<String> strVariants = [];
  List<String> ProductVariant = [];
  List<String> discountprice  = [];
  List<String> price = [];
  List<String> ProductDiscount = [];

  List<bool> unhideAddToCart = [];
  List<bool> hideAddToCart = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
        : Card(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Before You CheckOut",
                style: constantFontStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ],
          ),
          Container(
            height: 300,
            child: IntrinsicHeight(
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [

                      Container(
                        height: 50,
                        width: 100,
                        color: Colors.grey.shade200,
                        child:    Center(
                          child: Text(
                            "Top Offers",
                            style: constantFontStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),

                        ),
                      ),

                      // Container(
                      //
                      //   height: 1.0,
                      //   color: Colors.black,
                      // ),
                      //
                      // Container(
                      //   height: 50,
                      //   width: 100,
                      //   color: Colors.grey.shade200,
                      //
                      //   child:   Center(
                      //     child: Text(
                      //       "Essentials",
                      //       style: constantFontStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w500,
                      //           color: Colors.black54),
                      //     ),
                      //
                      //   ),
                      // ),
                      // Container(
                      //
                      //   height: 1.0,
                      //   color: Colors.black,
                      // ),
                      // Container(
                      //   height: 50,
                      //   width: 100,
                      //   color: Colors.grey.shade200,
                      //
                      //   child:    Center(
                      //     child: Text(
                      //       "Quick Bites",
                      //       style: constantFontStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w500,
                      //           color: Colors.black54),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //
                      //   height: 1.0,
                      //   color: Colors.black,
                      // ),
                      // Container(
                      //   height: 50,
                      //   width: 100,
                      //   color: Colors.grey.shade200,
                      //
                      //   child:    Center(
                      //     child: Text(
                      //       "Best Deals",
                      //       style: constantFontStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w500,
                      //           color: Colors.black54),
                      //     ),
                      //   ),
                      // ),
                      Container(

                        height: 1.0,
                        color: Colors.redAccent,
                      ),

                    ],
                  ),
                  SizedBox(width: 5,),

                  Expanded(child: Center(child: dynamicHorizontalListview())),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dynamicHorizontalListview() {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: ProductName.length,
          //  itemCount: title.length,
          //     shrinkWrap: true,
          //  physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            unhideAddToCart.add(false);
            hideAddToCart.add(true);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailsNew(
                          productId: productId[index],
                        )));
              },
              child: Row(
                children: [
                  Container(
                    width: 160,
                    // height: MediaQuery.of(context).size.height/8,
                    child: Card(
                      // /       semanticContainer: true,
                      //   clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: elevation_size,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        // margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // subtitle: Text(description[index]),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(paddingAllTwo),
                                      child: Badge(

                                        position: BadgePosition.topStart(top: -9, start: -8),
                                        badgeColor:Colors.transparent ,
                                        elevation: 100,

                                        showBadge: true,


                                        badgeContent: ProductDiscount[index] !="0"? Card(
                                            shape:
                                            RoundedRectangleBorder(           borderRadius: BorderRadius.only(topRight: Radius.circular(0),bottomRight: Radius.circular(50))),

                                            color: themeColor,child: Text(
                                          " Min ${ProductDiscount[index]}% OFF  ",
                                          style: constantFontStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )):null,

                                        child: Container(
                                          // width: 150,
                                          // height: 90,
                                          child: ClipRRect(
                                              borderRadius: new BorderRadius.only(
                                                  topRight: Radius.circular(10.0),
                                                  topLeft: Radius.circular(10.0)),
                                              child: CachedNetworkImage(
                                                errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),

                                                placeholder: (context, url) =>
                                                    Center(
                                                      child: Image.asset("assets/images/image_loader.gif"),
                                                    ),
                                                imageUrl: ProductImage[index],
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Expanded(
                            //     flex: 4,
                            //     child: Image.network(
                            //         categoryImage[index],fit: BoxFit.fill,)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          //   color: Colors.black12,
                                          // border: Border.all(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child:  Text(
                                          ProductName[index],
                                          style: constantFontStyle(
                                              fontSize: Fontsize,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        )),
                                  ),

                                ],
                              ),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Container(height: 15,color:Colors.grey.shade200,child:
                                  Text(
                                    " ${strVariants[index]}",
                                    style: constantFontStyle(
                                        fontSize: SubTitleFontsize,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),),
                                ),
                              ],
                            ),

                            Row(

                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "₹ ${price[index]}",
                                    style: GoogleFonts.roboto(
                                        fontSize: Fontsize,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "₹" + discountprice[index],
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      color: Colors.grey.shade400,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                            Spacer(),



                            AddedToCart[index] == "1"
                                ? Visibility(
                              visible: true,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  Expanded(

                                    child: Container(
                                      height: 30,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty
                                                .all(Colors
                                                .redAccent),
                                            foregroundColor:
                                            MaterialStateProperty
                                                .all(
                                                Colors.green),
                                          ),
                                          onPressed: () {
                                            // List _tmpList = itemsNotifier.value;
                                            // _tmpList.add( categoryName[index]);
                                            // itemsNotifier.value = _tmpList;
                                          },
                                          child: Text(
                                            "ADDED To CART",
                                            style:
                                            constantFontStyle(
                                                fontSize:
                                                Fontsize,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                color:
                                                Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : Visibility(
                              visible: hideAddToCart[index],
                              child: Row(
                                children: [
                                  Expanded(

                                    child: Container(
                                      height: 30,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.redAccent),
                                            foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                          ),
                                          onPressed: () async {
                                            setState(() {
                                              hideAddToCart[index] = false;
                                              unhideAddToCart[index] = true;

                                              addtocart(
                                                  context,
                                                  productId[index],
                                                  ProductVariant[
                                                  index]);
                                            });

                                          },
                                          child: Text(
                                            "ADD",
                                            style: constantFontStyle(
                                                fontSize: Fontsize,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: unhideAddToCart[index],
                              child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(

                                    child: Container(
                                      height: 30,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.redAccent),
                                            foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                          ),
                                          onPressed: () {
                                            // List _tmpList = itemsNotifier.value;
                                            // _tmpList.add( categoryName[index]);
                                            // itemsNotifier.value = _tmpList;
                                          },
                                          child: Text(
                                            "ADDED To CART",
                                            style: constantFontStyle(
                                                fontSize: Fontsize,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
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

    var response = await http.get(Uri.parse("$offer_ProductApi?userid=$userID"));
    //var response = await http.get(Uri.parse("$product?userid=$userID&vendor=5&subcategory=3&category=3}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      debugPrint("this is data${data.toString()}");
      setState(() {
        ProductName.clear();
        ProductImage.clear();
        productId.clear();
        AddedToCart.clear();
        ProductVariant.clear();
        strVariants.clear();
        price.clear();
        discountprice.clear();
        ProductDiscount.clear();

        var s = [];

        for (int i = 0; i < data["result"].length; i++) {
          ProductName.add(data["result"][i]["name"]);

          productId.add(data["result"][i]["id"]);
          ProductDiscount.add(data["result"][i]["discount"].toString().split(".").first);

          AddedToCart.add(data["result"][i]["in_cart"]);

          if (data["result"][i]["imgs"].length <= 0) {
            ProductImage.add(
                "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png");
          }
          else {
            // for (int j = 0; j < data["result"][i]["imgs"].length; j++) {
              ProductImage.add(data["result"][i]["imgs"][0]["imgpath"]);

          //  }
          }
          for (int j = 0; j < data["result"][i]["opts"].length; j++) {
            price.add(data["result"][i]["opts"][j]["price"].toString());
            discountprice.add(data["result"][i]["opts"][j]["dprice"].toString());
            ProductVariant.add(data["result"][i]["opts"][j]["variants"].toString());
            strVariants.add(data["result"][i]["opts"][j]["variant_str"].toString().split(":").last);

          }
        }
        //  print("this is image $ProductImage");

        // subList = s;

        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }


  addtocart(context, productId, variant) async {
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    final dataBody = {
      "userid": userID,
      "product": productId.toString(),
      "variants": variant.toString(),
      "qty": "1",
      //  "password":passwordController.text,
    };
    var response = await http.post(Uri.parse(addToCart), body: dataBody);
    var body = jsonDecode(response.body);

    // debugPrint(body["status"].toString());
    if (response.statusCode == 200) {
      if (body["status"] == "200") {
        setState(() {
          prefs.setString('cartOid', body["result"]["oid"].toString());
          //   showInSnackBar();
          //    Singleton.showmsg(context, "Message", body["message"]);
        });
      } else {
        Singleton.showmsg(context, "Message", body["message"]);
      }

      debugPrint(body.toString());
    } else {
      Singleton.showmsg(context, "Message", body["error"]);
    }
  }

// void showInSnackBar() {
//   _scaffoldKey.currentState!
//       .showSnackBar(new SnackBar(content: new Text("ADDED To Cart")));
// }
}
