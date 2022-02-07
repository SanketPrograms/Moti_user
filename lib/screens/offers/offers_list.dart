import 'dart:convert';
import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/Widgets/sliding_image.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/main.dart';
import 'package:big_basket/model_class/cart_model_class.dart';
import 'package:big_basket/screens/Filter/filter_mainscreen.dart';
import 'package:big_basket/screens/cart_items/cart_items.dart';
import 'package:big_basket/screens/cart_items/navigated_cart.dart';
import 'package:big_basket/screens/product_details/product_details.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/product_details/product_details_new.dart';
import 'package:big_basket/screens/product_list/product_modalclass.dart';
import 'package:big_basket/screens/user_login/login_sliding_image.dart';
import 'package:big_basket/screens/user_login/user_login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OfferList extends StatefulWidget {
  final category;
  final subcategory;
  final BannerImageList;
  final BannerID;
  OfferList(
      {Key? key,
        this.category,
        this.subcategory,
        this.BannerImageList,
        this.BannerID})
      : super(key: key);

  @override
  State<OfferList> createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading = true;
  List categoryName = [];
  List numberOfItems = [];
  var CartLength;
  List ProductImage = [];
  List productId = [];
  List productDescription = [];
  List<bool> hideAddToCart = [];
  List<bool> unhideAddToCart = [];
  List<String> products = [];
  List<String> price = [];
  List<String> discountprice = [];
  List<String> shopName = [];
  List<String> ProductVariant = [];
  List<String> AddedToCart = [];
  List<String> ProductVegNonveg = [];
  List<String> cartproductId = [];
  List<String> discountPercent = [];
  List<String> strVariants = [];
  List ProductImagesSend = [];
  List BannerImageList = [];
  List BannerID = [];
  var noProduct = "0";
  var userID;

  @override
  void initState() {
    // TODO: implement initState
    BannerImageApi();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          centerTitle: true,
          actions:  [

            // GestureDetector(
            //   onTap: (){
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => NavigatedCartItem()));
            //   },
            //   child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 10),
            //       child: Badge(
            //         position: BadgePosition.topEnd(top: 10, end: -6),
            //         //    animationDuration: Duration(milliseconds: 300),
            //         //    animationType: BadgeAnimationType.slide,
            //         badgeColor: Colors.redAccent,
            //         //   toAnimate: true,
            //         badgeContent: itemsNotifier.value.toString() == "[]"
            //             ? Text(
            //           CartLength ?? "0",
            //           style: TextStyle(
            //               fontSize: 10,
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold),
            //         )
            //             : ValueListenableBuilder(
            //           valueListenable: itemsNotifier,
            //           builder: (context, items, _) {
            //             return Text(
            //               itemsNotifier.value.toString(),
            //               style: TextStyle(
            //                   fontSize: 8,
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold),
            //             );
            //           },
            //         ),
            //         child: Image.asset(
            //             "assets/images/bottom_navigation/shopping-basket.png",
            //             scale: 1.5,
            //             color:  Colors.white),
            //       )),
            // ),
          ],

          title: Row(
            children: [
              Text("Best Offers", style: constantFontStyle(

                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white
              )),

            ],
          ),
          backgroundColor: themeColor
      ),
      body: isLoading
          ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
          :noProduct == "1"
          ? Card(

          child: Center(
              child: Image.asset("assets/images/404_not_found.png",scale: 1.7)))
          : SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [

           SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: SlidingImage(
                  BannerImageList),
            ),


            Card(
              child: dynamicListview(),
            ),



          ],
        ),
      ),
    );
  }

  Widget dynamicListview() {
    // print("this is findword $findWord");
    return LayoutBuilder(builder: (context, constraints) {
      // for (int i = 0; i < categoryName.length; i++) {
      //
      //    hideAddToCart.add(false);

      //   unhideAddToCart.add(false);

      // if (productId[i].toString().contains(
      //     cartproductId.join(",").toString())&&cartproductId.isNotEmpty) {
      //   debugPrint("hkkkhhshsh $productId");
      //   hideAddToCart.add(false);
      //   unhideAddToCart.add(true);
      // }
      // else {
      //   debugPrint("hhhhh$productId");
      //
      //   hideAddToCart.add(true);
      //   unhideAddToCart.add(false);
      // }
      //   }
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        //  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 3,
        //       crossAxisSpacing: paddingAll,
        //       mainAxisSpacing: paddingAll,
        //       childAspectRatio: 1),
        itemCount: categoryName.length,
        //  itemCount: title.length,
        shrinkWrap: true,
        //  physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          List s = [];

          unhideAddToCart.add(false);
          hideAddToCart.add(true);

          return discountPercent[index] != "0"
              ? GestureDetector(
            onTap: () {
              debugPrint(productId[index].toString() +
                  "this is Sending image details");

              // List imageProduct = [];
              // for (int i = 0; i < ProductImage.length; i++) {
              //   if (ProductImagesSend[i]["product"] == productId[index]) {
              //     debugPrint(ProductImage[i].toString() + "this is a");
              //     debugPrint(
              //         ProductImagesSend[i].length.toString() + "this is a");
              //
              //     imageProduct.add(ProductImagesSend[i]["imgpath"]);
              //   }
              // }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsNew(
                        productId: productId[index],
                      )));
              //             Navigator.push(
              // context,
              // MaterialPageRoute(
              //     builder: (context) =>
              //         ProductDetails(
              //             productId: productId,
              //             productname: categoryName[index],
              //             price: price[index],
              //             ProductVariant: ProductVariant[index],
              //             productimage: imageProduct)));
            },
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                // color: Colors.white,
                // elevation: elevation_size,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    //  alignment: Alignment.center,
                    child: Row(
                      children: [
                        // subtitle: Text(description[index]),
                        Expanded(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Badge(
                                position:
                                BadgePosition.topStart(top: -6, start: 6),
                                badgeColor: Colors.transparent,
                                elevation: 100,
                                showBadge: true,
                                badgeContent: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    discountPercent[index] != "0"
                                        ? Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight:
                                                Radius.circular(0),
                                                bottomRight:
                                                Radius.circular(50))),
                                        color: themeColor,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(2.0),
                                          child: Text(
                                            " Min ${discountPercent[index]}% OFF  ",
                                            style: constantFontStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ))
                                        : Container(height: 30,),
                                    SizedBox(
                                      height: 70,
                                    ),
                                    ProductVegNonveg[index] == "2"
                                        ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              side: new BorderSide(
                                                  color: Colors.redAccent,
                                                  width: 1.0),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  4.0)),
                                          elevation: 2,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.circle,
                                              color: Colors.redAccent,
                                              size: 10,
                                            ),
                                          )),
                                    )
                                        : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              side: new BorderSide(
                                                  color: themeColor,
                                                  width: 1.1),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  0.0)),
                                          elevation: 2,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.circle,
                                              color: themeColor,
                                              size: 10,
                                            ),
                                          )),
                                    ),

                                    // SizedBox(width: 70,),
                                  ],
                                ),
                                child: Card(
                                  elevation: 2,
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Center(
                                      child: Image.asset("assets/images/image_loader.gif"),
                                    ),
                                    imageUrl: ProductImage[index],
                                    width:
                                    MediaQuery.of(context).size.width / 2.8,
                                    height:
                                    MediaQuery.of(context).size.width / 2.8,
                                    errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),

                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        shopName[index],
                                        style: constantFontStyle(
                                            fontSize: SubTitleFontsize,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Card(
                                      //   elevation: elevation_size,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Image.asset(
                                              "assets/images/delivery_truck.png",
                                              color: Colors.grey,
                                              height: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Text(
                                              "1 day",
                                              style: constantFontStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        categoryName[index],
                                        style: constantFontStyle(
                                            fontSize: TitleFontsize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                // Text(
                                //   productDescription[index],
                                //   style: constantFontStyle(
                                //     fontSize: SubTitleFontsize,
                                //   ),
                                // ),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //
                                //     Expanded(
                                //       child: GestureDetector(onTap: () {
                                //         _showMyDialog(
                                //             context, categoryName[index]);
                                //       }, child: Card(
                                //         color: Colors.grey.shade100,
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(3.0),
                                //           child: Text(
                                //             ProductVariant[index],
                                //             style: constantFontStyle(
                                //                 fontSize: SubTitleFontsize,
                                //                 fontWeight: FontWeight.bold
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 15,
                                        color: Colors.grey.shade200,
                                        child: Text(
                                          " ${strVariants[index]}",
                                          style: constantFontStyle(
                                              fontSize: SubTitleFontsize,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    discountPercent[index] != "0"
                                        ?   Text(
                                      "₹" + discountprice[index],
                                      style: GoogleFonts.roboto(
                                          fontSize: TitleFontsize,
                                          fontWeight: FontWeight.bold),
                                    ):Text(
                                      "₹" + price[index],
                                      style: GoogleFonts.roboto(
                                          fontSize: TitleFontsize,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    const SizedBox(
                                      width: 8,
                                    ),
                                    discountPercent[index] != "0"
                                        ?Text(
                                      "₹" + price[index],
                                      style: GoogleFonts.roboto(
                                          fontSize: 10,
                                          color: Colors.grey.shade400,
                                          decoration:
                                          TextDecoration.lineThrough),
                                    ): Text(
                                      "₹" + discountprice[index],
                                      style: GoogleFonts.roboto(
                                          fontSize: 10,
                                          color: Colors.grey.shade400,
                                          decoration:
                                          TextDecoration.lineThrough),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ///////////////////////////////////////////////////////////////////////////Changes in this line////
                                // productId[index].toString().contains(cartproductId.join(","))  ?
                                AddedToCart[index] == "1"
                                    ? Visibility(
                                  visible: true,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        // width: 150,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty
                                                  .all(Colors
                                                  .redAccent),
                                              foregroundColor:
                                              MaterialStateProperty
                                                  .all(Colors.green),
                                            ),
                                            onPressed: () {
                                              // List _tmpList = itemsNotifier.value;
                                              // _tmpList.add( categoryName[index]);
                                              // itemsNotifier.value = _tmpList;
                                            },
                                            child: Text(
                                              "ADDED TO Cart",
                                              style: constantFontStyle(
                                                  fontSize: Fontsize,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                                    : Visibility(
                                  visible: hideAddToCart[index],
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty
                                                  .all(Color(
                                                  0xffF82D2D)),
                                              foregroundColor:
                                              MaterialStateProperty
                                                  .all(Colors.green),
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                if (userID == null) {
                                                  Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context)=>Login_Sliding_image()));

                                                } else {
                                                  hideAddToCart[index] =
                                                  false;
                                                  unhideAddToCart[index] =
                                                  true;
                                                  addtocart(
                                                      context,
                                                      productId[index],
                                                      ProductVariant[
                                                      index]);
                                                }
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
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: unhideAddToCart[index],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      _shoppingItem(index),

                                    ],
                                  ),
                                )
                                // Visibility(
                                //   visible:true,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //
                                //       SizedBox(
                                //         width: 110,
                                //         child: Row(
                                //           children: [
                                //
                                //               IconButton(icon: const Icon(Icons.add_box_outlined,),onPressed: (){},),
                                //
                                //             Container(color: Colors.red,child: Text("0",style: constantFontStyle(fontWeight: FontWeight.w500,fontSize: 18),)),
                                //             IconButton(onPressed: (){},icon: const Icon(Icons.indeterminate_check_box_outlined)),
                                //
                                //           ],
                                //         ),
                                //
                                //       ),
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ):SizedBox(height: 0,width: 0,);
        },
      );
    });
  }

  Widget dynamicHorizontalListview() {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 9,
          //  itemCount: title.length,
          shrinkWrap: true,
          //  physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 100,
              child: Center(
                  child: Card(
                    color: Colors.white,
                    borderOnForeground: true,
                    elevation: elevation_size,
                    child: Padding(
                      padding: const EdgeInsets.all(paddingAllTwo),
                      child: Text(
                        "Potato,Onion & Tomato",
                        style: constantFontStyle(
                          fontSize: SubTitleFontsize,
                        ),
                      ),
                    ),
                  )),
            );
          });
    });
  }

  _showMyDialog(context, itemName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                Text(
                  'Available Quantity For',
                  style: constantFontStyle(
                      fontSize: TitleFontsize, fontWeight: FontWeight.w500),
                ),
                Divider(thickness: 1),
                Text(
                  '$itemName',
                  style: constantFontStyle(
                      fontSize: TitleFontsize, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Divider(thickness: 1),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: Colors.blueGrey.shade100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '1 KG',
                              style: constantFontStyle(
                                  fontSize: SubTitleFontsize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '30₹',
                              style: GoogleFonts.roboto(
                                fontSize: SubTitleFontsize,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '30₹',
                              style: GoogleFonts.roboto(
                                  fontSize: SubTitleFontsize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: Colors.blueGrey.shade100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '2 KG',
                              style: constantFontStyle(
                                  fontSize: SubTitleFontsize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '50₹',
                              style: GoogleFonts.roboto(
                                fontSize: SubTitleFontsize,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '50₹',
                              style: GoogleFonts.roboto(
                                  fontSize: SubTitleFontsize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _shoppingItem(int itemIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // width: 200,
          height: 30,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                // numberOfItems[itemIndex] == 1
                //     ? _deleteButton(itemIndex)
                //     :
                _decrementButton(itemIndex),
                Text(
                  '${numberOfItems[itemIndex]}',
                  style: constantFontStyle(fontSize: 15.0),
                ),
                _incrementButton(itemIndex),
              ],
            ),
          ),

        ),
      ],
    );
  }
  Widget _incrementButton(int index) {
    return FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white70,
        onPressed: () {
          setState(() {
            //   productTotal = 0;
            numberOfItems[index]++;


            // productPriceTotal[index] =
            // (int.parse(productprice[index].toString().split(".").first) *
            //     int.parse(numberOfItems[index].toString().split(".").first));
            //
            // productPriceTotal.forEach((num e) {
            //   productTotal += e;
          });
          //     debugPrint(productTotal.toString());
        });
  }
  // );


  Widget _decrementButton(int index) {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            // productTotal = 0;
            numberOfItems[index]--;

            // productPriceTotal[index] = (int.parse(
            //     productprice[index].toString().split(".").first) *
            //     int.parse(numberOfItems[index].toString().split(".").first));
            // debugPrint("this is product $productPriceTotal");
            // debugPrint("this is product $productprice");
            // debugPrint("this is product $numberOfItems");
            //
            // productPriceTotal.forEach((num e) {
            //   productTotal += e;
            // });
            // debugPrint(productTotal.toString());
          });
        },
        // child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
        child: Icon(
          Icons.remove,
          color: Colors.black,
        ),
        backgroundColor: Colors.white70);
  }


  getData() async {
    final prefs = await SharedPreferences.getInstance();
    final StrCartLength = prefs.getString('cartLength') ?? "0";
    CartLength = StrCartLength;

    userID = prefs.getString('userId');

    var response = await http.get(Uri.parse(productApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      setState(() {
        if (data["message"].toString() == "Products Not Found") {
          noProduct = "1";
        } else {
          noProduct = "2";
          categoryName.clear();
          ProductImage.clear();
          productId.clear();
          productDescription.clear();
          price.clear();
          discountprice.clear();
          productDescription.clear();
          shopName.clear();
          ProductVegNonveg.clear();
          AddedToCart.clear();
          ProductImagesSend.clear();
          discountPercent.clear();
          strVariants.clear();

          List s = [];
          List imageProduct = [];

          for (int i = 0; i < data["result"].length; i++) {
            numberOfItems.add(1);

            categoryName.add(data["result"][i]["name"]);

            productId.add(data["result"][i]["id"]);
            productDescription.add(data["result"][i]["description"]);
            shopName.add(data["result"][i]["shop_name"]);
            AddedToCart.add(data["result"][i]["in_cart"]);
            discountPercent
                .add(data["result"][i]["discount"].toString().split(".").first);
            ProductVegNonveg.add(data["result"][i]["findicator"]);

            for (int j = 0; j < data["result"][i]["opts"].length; j++) {
              price.add(data["result"][i]["opts"][j]["price"]
                  .toString()
                  .split(".")
                  .first);
              discountprice.add(data["result"][i]["opts"][j]["dprice"]
                  .toString()
                  .split(".")
                  .first);

            }
            ProductVariant.add(
                data["result"][i]["opts"][0]["variants"].toString());
            strVariants.add(data["result"][i]["opts"][0]["variant_str"]
                .toString()
                .split(":")
                .last);
            if (data["result"][i]["imgs"].length <= 0) {
              ProductImage.add(
                  "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png");
            } else {
              for (int j = 0; j < data["result"][i]["imgs"].length; j++) {
                ProductImage.add(data["result"][i]["imgs"][j]["imgpath"]);
                ProductImagesSend.add(data["result"][i]["imgs"][j]);
              }
            }
          }
          debugPrint("this is AddedToCart $AddedToCart");


        }


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
      "qty": "2",
      //  "password":passwordController.text,
    };
    var response = await http.post(Uri.parse(addToCart), body: dataBody);
    var body = jsonDecode(response.body);

    // debugPrint(body["status"].toString());
    if (response.statusCode == 200) {
      if (body["status"] == "200") {
        setState(() {
          prefs.setString('cartOid', body["result"]["oid"].toString());
          showInSnackBar();
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

  void showInSnackBar() {
    _scaffoldKey.currentState!
        .showSnackBar(SnackBar(content: Text("ADDED To Cart")));
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

  BannerImageApi() async {
    var response = await http.get(Uri.parse("$BannerImageApis"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      //   debugPrint(data.toString() + "banner");

      BannerImageList.clear();
      BannerID.clear();

      var s = [];
      setState(() {
        for (int i = 0; i < data["result"].length; i++) {
          BannerImageList.add(data["result"][i]["imgpath"]);
          BannerID.add(data["result"][i]["product"]);
        }
      });

      //   debugPrint(BannerImageList.toString() + "banner");
    } else {
      debugPrint("Error in the Api");
    }
  }

  Widget SlidingImage(BannerImage) {
    List<int> imageLength = [];
    for (int i = 0; i < BannerImage.length; i++) {
      imageLength.add(i);
    }
    //   debugPrint("this is i $imageLength");
    return Container(
      // height: 80,
      child: CarouselSlider(
        options: CarouselOptions(

          // height: 200,
          aspectRatio: 10 / 3,

          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,

          autoPlay: true,
          // autoPlayInterval: Duration(seconds: 10),
          //autoPlayAnimationDuration: Duration(milliseconds: 100),
          autoPlayCurve: Curves.easeInOutCubicEmphasized,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: imageLength.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(

                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsNew(
                                productId: BannerID[i],
                              )));

                },
                //  height:90,



                child: Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(),
                  child: Container(
                    // height: 100,
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(BannerImage[i]),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
