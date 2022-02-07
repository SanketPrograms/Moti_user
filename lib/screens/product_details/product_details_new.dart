import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/main.dart';
import 'package:big_basket/screens/cart_items/cart_items.dart';
import 'package:big_basket/screens/delivery/delivery_option.dart';
import 'package:big_basket/screens/product_details/product_details_similarproduct.dart';
import 'package:big_basket/screens/product_details/view_image.dart';
import 'package:big_basket/screens/search/searchnavigation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsNew extends StatefulWidget {
  final productId;

  ProductDetailsNew({Key? key, this.productId}) : super(key: key);

  @override
  State<ProductDetailsNew> createState() => _ProductDetailsNewState();
}

class _ProductDetailsNewState extends State<ProductDetailsNew> {
  int value = 0;

  int num = 6;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int showSubImage = 0;

  List<String> productName = [];
  List<String> ProductVegNonveg = [];

  List<String> productVariant = [];
  List<String> discountprice = [];

  List<String> productPrice = [];

  List<String> productDiscount = [];
  List<String> InfavField = [];
  List<String> productDescription = [];

  List<String> productImage = [];
  List<String> productShopName = [];
  List<String> ProductVariant = [];
  bool visibleaddfav = true;
  bool visibleAddedfav = false;
  var favvisible = "1";
  var variant;
  var productTotal = 0;
  bool flag1 = true;
  bool flag2 = true;
  bool flag3 = true;
  String? Str_ScrollImage;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: themeColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchNavigation()));
                },
                icon: Icon(Icons.search)),
          ),
          // GestureDetector(
          //   onTap: (){
          //     Navigator.push(context, CupertinoPageRoute(builder: (context)=>CartItem()));
          //
          //   },
          //   child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 5),
          //       child: Badge(
          //         position:
          //         BadgePosition.topStart(top: 10, start: 10),
          //         //    animationDuration: Duration(milliseconds: 300),
          //         //    animationType: BadgeAnimationType.slide,
          //         badgeColor: Colors.redAccent,
          //         //   toAnimate: true,
          //         badgeContent:
          //
          //         ValueListenableBuilder(
          //           valueListenable: itemsNotifier,
          //           builder: (context, items, _) {
          //             return Text(
          //               itemsNotifier.value.toString(),
          //               style: const TextStyle(
          //                   fontSize: 8,
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold),
          //             );
          //           },
          //         ),
          //         child: Image.asset(
          //             "assets/images/bottom_navigation/shopping-basket.png",
          //             height: 20,
          //
          //             color:
          //                 Colors.white),
          //       )),
          // ),

          SizedBox(
            width: 5,
          )
        ],
      ),
       
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();

                              var userID = prefs.getString('userId');
                              if (userID == null) {
                                showInSnackBar(
                                    "PLease Login Before adding products");
                              } else {
                                addtocart(context);
                              }
                            },
                            child: Text(
                              "ADD TO CART",
                              style: constantFontStyle(color: Colors.white),
                            ))),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DeliveryOption(
                                        productPriceTotal: productTotal)));
                          },
                          child: Text("Proceed To Pay",
                              style: constantFontStyle(color: Colors.white))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: isLoading == true
          ? Center(
              child: Image.asset(
              "assets/images/loading_page.gif",
              scale: 3,
            ))
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        margin: const EdgeInsets.all(0.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: themeColor)),
                        child: Text(
                          "${productShopName[0]}",
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.green.shade300,
                              fontSize: 10),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "${productName[0].toString()} - ${productVariant[0].toString()}",
                        style: constantFontStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      productDiscount[0] != "0"
                                          ? Text(
                                              "₹" + discountprice[0],
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )
                                          : Text(
                                              "Rs ${productPrice[0]}",
                                              style: constantFontStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )
                                    ],
                                  ),
                                  productDiscount[0] != "0"?
                                  Text(
                                    " MRP",
                                    style: constantFontStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ):SizedBox(),
                                  productDiscount[0] != "0"
                                      ? Text(
                                          "₹" + productPrice[0],
                                          style: GoogleFonts.roboto(
                                              fontSize: 10,
                                              color: Colors.grey.shade400,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        )
                                      : SizedBox(),
                                  productDiscount[0] != "0"
                                      ? Card(
                                          color: Colors.redAccent.shade200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "${productDiscount[0].split(".").first}% Off",
                                              style: constantFontStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            ),
                                          ))
                                      : SizedBox()
                                ],
                              ),
                              Row(
                                children: [
                                  // InfavField[0]!="1"?
                                  Visibility(
                                    visible: visibleaddfav,
                                    child: InkWell(
                                      onTap: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();

                                        var userID = prefs.getString('userId');
                                        setState(() {
                                          if (userID == null) {
                                            showInSnackBar(
                                                "PLease Login First Before Adding To Favorite");
                                          } else {
                                            visibleaddfav = false;
                                            visibleAddedfav = true;

                                            addToFav(context);
                                          }
                                        });
                                      },
                                      child: Image.asset(
                                        "assets/images/fav_added1.png",
                                        height: 25,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: visibleAddedfav,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          visibleaddfav = true;
                                          visibleAddedfav = false;
                                          RemoveFromFav(context);
                                        });
                                      },
                                      child: Image.asset(
                                        "assets/images/fav_added2.png",
                                        height: 25,
                                        color: Colors.redAccent.shade200,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),

                                  GestureDetector(
                                    onTap: () async {
                                      // Share.shareFiles([productImage[0]], text: "Visit This Product\n$productDetailsApi?product=${widget.productId}");

                                      final urlImage = productImage[0];

                                      final url = Uri.parse(urlImage);

                                      final response = await http.get(url);

                                      final bytes = response.bodyBytes;

                                      final temp =
                                          await getTemporaryDirectory();
                                      final path = '${temp.path}/image.png';

                                      File(path).writeAsBytesSync(bytes);
                                      // $productDetailsApi?product=${widget.productId}
                                      await Share.shareFiles([path],
                                          text:
                                              "CheckOut This Product by\n$applicationName\nclick here to visit Product\nhttp://moticonf.adminapp.tech/site/product/${widget.productId}");
                                      //await Share.share( "CheckOut This Product by \n$applicationName URL Link");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Column(
                                        children: [
                                          // const SizedBox(height: 5,width: 5,),
                                          Image.asset(
                                            "assets/images/share.png",
                                            scale: 40,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Share",
                                            style: constantFontStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "(Inclusive of all Taxes)",
                                style: constantFontStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10),
                              ),
                            ],
                          ),

                          // Text("MRP RS 250",style: constantFontStyle(fontWeight: FontWeight.w400,fontSize: 10),),
                        ],
                      ),
                      // trailing:                   GestureDetector(
                      //   onTap: () async{
                      //     // Share.shareFiles([productImage[0]], text: "Visit This Product\n$productDetailsApi?product=${widget.productId}");
                      //
                      //     final urlImage = productImage[0];
                      //
                      //     final url = Uri.parse(urlImage);
                      //
                      //     final response = await http.get(url);
                      //
                      //     final bytes = response.bodyBytes;
                      //
                      //     final temp = await getTemporaryDirectory();
                      //     final path = '${temp.path}/image.png';
                      //
                      //      File(path).writeAsBytesSync(bytes);
                      //      // $productDetailsApi?product=${widget.productId}
                      //     await Share.shareFiles([path],text: "CheckOut This Product by\n$applicationName\nclick here to visit Product\nhttp://moticonf.adminapp.tech/site/product/${widget.productId}");
                      //     //await Share.share( "CheckOut This Product by \n$applicationName URL Link");
                      //
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //       children: [
                      //        const SizedBox(height: 5,width: 5,),
                      //          Image.asset("assets/images/share.png",height: 20,color: Colors.black,),
                      //          Text("Share",style: constantFontStyle(fontWeight: FontWeight.w500,fontSize: 10),),
                      //
                      //
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ),

                    Badge(
                      position: BadgePosition.bottomStart(start: 10, bottom: 5),
                      badgeColor: Colors.transparent,
                      elevation: 100,
                      showBadge: true,
                      badgeContent: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProductVegNonveg[0] == "2"
                              ? Card(
                                  shape: RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: Colors.redAccent, width: 1.0),
                                      borderRadius: BorderRadius.circular(4.0)),
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.redAccent,
                                      size: 10,
                                    ),
                                  ))
                              : Card(
                                  shape: RoundedRectangleBorder(
                                      side: new BorderSide(
                                          color: themeColor, width: 1.1),
                                      borderRadius: BorderRadius.circular(0.0)),
                                  elevation: 2,
                                  child: const Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: themeColor,
                                      size: 10,
                                    ),
                                  )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewImage(productId: widget.productId)));
                        },
                        child: Row(
                          children: [
                            Expanded(

                              child:
                        CarouselSlider(

                        options: CarouselOptions(
                          initialPage: showSubImage,
height: MediaQuery.of(context).size.height/2,

                          disableCenter: true,
                       viewportFraction: 1,

                       enlargeCenterPage: true,

                          // autoPlayInterval: Duration(seconds: 10),
                          //autoPlayAnimationDuration: Duration(milliseconds: 100),
                          // height:
                          // MediaQuery.of(context).size.height/2,


                        ),
                        items: productImage
                            .map((Str_ScrollImage) =>
                            Container(
                                color: Colors.transparent,
                                width:
                                double.maxFinite,
                                height:
                                MediaQuery.of(context).size.height/2,
                                child: CachedNetworkImage(
                                    imageUrl:Str_ScrollImage,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Image.network(
                                            "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
                                    placeholder: (context, url) => Center(
                                      child: Image.asset(
                                          "assets/images/image_loader.gif"),
                                    ))),
                        )
                            .toList(),
                      )
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(height: 70, child: subImages()),//todo:uncomment this if required
                    Card(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/delivery_truck.png",
                              height: 20,
                              color: Colors.black45,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Delivery In 1 day",
                              style: constantFontStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Pack Sizes",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          priceListDetails(),
                        ],
                      ),
                    ),

                    Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "About This Product",
                              style: constantFontStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "About the Product",
                                style: constantFontStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
                              ),
                              trailing: flag1
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          flag1 = !flag1;
                                        });
                                      },
                                      icon: Icon(Icons.add))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          flag1 = !flag1;
                                        });
                                      },
                                      icon: Icon(Icons.remove)),
                              subtitle: Column(
                                children: <Widget>[
                                  flag1
                                      ? Text(productDescription[0],
                                          maxLines: 2,
                                          style: constantFontStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10))
                                      : Text(productDescription[0],
                                          style: constantFontStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10)),
                                  InkWell(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          flag1 ? "show more" : "show less",
                                          style: constantFontStyle(
                                              color: Colors.blue, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        flag1 = !flag1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///////////////////////////////specification
                    // Card(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: ListTile(
                    //           title: Text(
                    //             "Specification",
                    //             style: constantFontStyle(
                    //                 color: Colors.grey,
                    //                 fontWeight: FontWeight.w700,
                    //                 fontSize: 12),
                    //           ),
                    //           trailing: flag2
                    //               ? IconButton(
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       flag2 = !flag2;
                    //                     });
                    //                   },
                    //                   icon: Icon(Icons.add))
                    //               : IconButton(
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       flag2 = !flag2;
                    //                     });
                    //                   },
                    //                   icon: Icon(Icons.remove)),
                    //           subtitle: Column(
                    //             children: <Widget>[
                    //               flag2
                    //                   ? Text(
                    //                       "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum ",
                    //                       maxLines: 2,
                    //                       style: constantFontStyle(
                    //                           color: Colors.grey,
                    //                           fontWeight: FontWeight.w500,
                    //                           fontSize: 10))
                    //                   : Text(
                    //                       "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                    //                       style: constantFontStyle(
                    //                           color: Colors.grey,
                    //                           fontWeight: FontWeight.w500,
                    //                           fontSize: 10)),
                    //               InkWell(
                    //                 child: Row(
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: <Widget>[
                    //                     Text(
                    //                       flag2 ? "show more" : "show less",
                    //                       style: constantFontStyle(
                    //                           color: Colors.blue, fontSize: 12),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 onTap: () {
                    //                   setState(() {
                    //                     flag2 = !flag2;
                    //                   });
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Card(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: ListTile(
                    //           title: Text(
                    //             "Benefits",
                    //             style: constantFontStyle(
                    //                 color: Colors.grey,
                    //                 fontWeight: FontWeight.w700,
                    //                 fontSize: 12),
                    //           ),
                    //           trailing: flag3
                    //               ? IconButton(
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       flag3 = !flag3;
                    //                     });
                    //                   },
                    //                   icon: Icon(Icons.add))
                    //               : IconButton(
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       flag3 = !flag3;
                    //                     });
                    //                   },
                    //                   icon: Icon(Icons.remove)),
                    //           subtitle: Column(
                    //             children: <Widget>[
                    //               flag3
                    //                   ? Text(
                    //                       "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum ",
                    //                       maxLines: 2,
                    //                       style: constantFontStyle(
                    //                           color: Colors.grey,
                    //                           fontWeight: FontWeight.w500,
                    //                           fontSize: 10))
                    //                   : Text(
                    //                       "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                    //                       style: constantFontStyle(
                    //                           color: Colors.grey,
                    //                           fontWeight: FontWeight.w500,
                    //                           fontSize: 10)),
                    //               InkWell(
                    //                 child: Row(
                    //                   mainAxisAlignment: MainAxisAlignment.end,
                    //                   children: <Widget>[
                    //                     Text(
                    //                       flag3 ? "show more" : "show less",
                    //                       style: constantFontStyle(
                    //                           color: Colors.blue, fontSize: 12),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 onTap: () {
                    //                   setState(() {
                    //                     flag3 = !flag3;
                    //                   });
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Card(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Similar Products",
                            style: constantFontStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        SimilarProduct(
                          product_id: widget.productId,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
    );
  }

  GetData() async {
    var response = await http
        .get(Uri.parse("$productDetailsApi?product=${widget.productId}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint(data.toString() + "Data");
      productName.clear();
      productPrice.clear();
      productVariant.clear();
      productDiscount.clear();
      discountprice.clear();
      ProductVegNonveg.clear();
      ProductVariant.clear();
      productDescription.clear();
      productShopName.clear();
      InfavField.clear();

      setState(() {
        //    for (int i = 0; i < data["result"].length; i++) {
        productName.add(data["result"]["name"]);

        productDiscount
            .add(data["result"]["discount"].toString().split(".").first);
        ProductVegNonveg.add(data["result"]["findicator"]);
        productDescription.add(data["result"]["description"]);
        productShopName.add(data["result"]["shop_name"]);
        InfavField.add(data["result"]["In_fav"]);

        //   }
        for (int i = 0; i < data["result"]["imgs"].length; i++) {
          productImage.add(data["result"]["imgs"][i]["imgpath"]);
        }
        for (int j = 0; j < data["result"]["opts"].length; j++) {
          productPrice.add(
              data["result"]["opts"][j]["price"].toString().split(".").first);
          discountprice.add(data["result"]["opts"][j]["dprice"]);
          productVariant.add(data["result"]["opts"][j]["variant_str"]
              .toString()
              .split(":")
              .last);

          ProductVariant.add(data["result"]["opts"][j]["variants"].toString());
        }
        if (InfavField[0] == "1") {
          setState(() {
            visibleaddfav = false;
            visibleAddedfav = true;
          });
        } else {
          setState(() {
            visibleaddfav = true;
            visibleAddedfav = false;
          });
        }

        variant = ProductVariant[0];
        productTotal = int.parse(productPrice[0]);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error in the Api");
    }
  }

  Widget subImages() {
    return ListView.builder(
      itemCount: productImage.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showSubImage = index;
                  Str_ScrollImage = productImage[0];
                });
              },
              child: Row(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: productImage[showSubImage] ==
                                      productImage[index]
                                  ? themeColor
                                  : Colors.grey.shade300,
                              width: productImage[showSubImage] ==
                                      productImage[index]
                                  ? 1
                                  : 1,
                            ),
                            borderRadius: BorderRadius.circular(4.0)),
                        elevation:
                            productImage[showSubImage] == productImage[index]
                                ? 10
                                : 0,
                        child: CachedNetworkImage(
                            imageUrl: productImage[index],
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Image.network(
                                "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
                            placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/image_loader.gif"),
                                ))),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget priceListDetails() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productPrice.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  value = index;
                  debugPrint(value.toString());
                  variant = ProductVariant[index];
                  productTotal = int.parse(productPrice[index]);
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Card(
                  borderOnForeground: true,
                  shape: BeveledRectangleBorder(
                      //    borderRadius: BorderRadiusGeometry.lerp(a, b, t),

                      side: BorderSide(
                        color: value == index ? Colors.green : themeColor,
                        width: value == index ? 1 : 0.3,
                      ),
                      borderRadius: BorderRadius.circular(4.0)),
                  elevation: value == index ? 5 : 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Text(productVariant[index],
                                  style: constantFontStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: [
                                  Text(discountprice[index] + "Rs",
                                      style: constantFontStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                        child: RadioListTile<int>(
                            activeColor: themeColor,
                            value: index,
                            groupValue: value,
                            onChanged: (ind) {
                              setState(() {
                                value = ind!.toInt();
                                debugPrint(value.toString());
                                variant = ProductVariant[index];
                                productTotal = int.parse(productPrice[index]);
                              });
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  addToFav(context) async {
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    final dataBody = {
      "userid": userID,
      "product": widget.productId.toString(),
    };
    var response = await http.post(Uri.parse(add2FavApi), body: dataBody);
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    if (response.statusCode == 200) {
      if (body["status"] == "200") {
        setState(() {
          // GetData();
          showInSnackBar("Added To Your Favorite List");
        });
      } else {
        Singleton.showmsg(context, "Message", body["message"]);
      }

      debugPrint(body.toString());
    } else {
      Singleton.showmsg(context, "Message", body["error"]);
    }
  }

  RemoveFromFav(context) async {
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    final dataBody = {
      "userid": userID,
      "product": widget.productId.toString(),
    };
    var response = await http.post(Uri.parse(removeFromFavApi), body: dataBody);
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    if (response.statusCode == 200) {
      if (body["status"] == "200") {
        setState(() {
          //  GetData();
          showInSnackBar("Removed From Your Favorite List");
        });
      } else {
        Singleton.showmsg(context, "Message", body["message"]);
      }

      debugPrint(body.toString());
    } else {
      Singleton.showmsg(context, "Message", body["error"]);
    }
  }

  addtocart(context) async {
    debugPrint(variant.toString() + "product Variant is this");
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    final dataBody = {
      "userid": userID,
      "product": widget.productId.toString(),
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
          showInSnackBar("Added To Cart");
          cartApi();
        });
      } else {
        Singleton.showmsg(context, "Message", body["message"]);
      }

      debugPrint(body.toString());
    } else {
      Singleton.showmsg(context, "Message", body["error"]);
    }
  }

  void showInSnackBar(String text) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          text,
          style: constantFontStyle(fontSize: 12),
        )));
  }

  cartApi() async {
    var userID;
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userId');
    final cartOid = prefs.getString('cartOid');
    var response =
        await http.get(Uri.parse("$viewCart?userid=$userID&oid=$cartOid"));
    //var response = await http.get(Uri.parse("$product?userid=$userID&vendor=5&subcategory=3&category=3}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint("this is data${data["result"]["items"].length.toString()}");

      String _tmpList = data["result"]["items"].length.toString();
      itemsNotifier.value = _tmpList;
      prefs.setString('cartLength', _tmpList);
    } else {
      debugPrint("Error in the Api");
    }
  }
}
