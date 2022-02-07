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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductList extends StatefulWidget {
  final category;
  final subcategory;
  final BannerImageList;
  final BannerID;
  final categoryName;
  ProductList(
      {Key? key,
      this.category,
      this.subcategory,
      this.BannerImageList,
      this.BannerID, this.categoryName})
      : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
  List<String> ProductVariantList = [];
  List<String> AddedToCart = [];
  List<String> ProductVegNonveg = [];
  List<String> cartproductId = [];
  List<String> discountPercent = [];
  List<String> strVariants = [];
  List<String> cartProductName = [];
  List ProductVariantID = [];
  List ProductImagesSend = [];
  List<String> cartProductID = [];
  List<bool> addBtnLoader = [];
  var noProduct = "0";
  var userID;
  var newStrVariant = [];
  var newPrice = [];
  var newDiscountPrice = [];
  var newVariant;
  @override
  void initState() {
    // TODO: implement initState

    getData();
    super.initState();
  }


  @override
  void didUpdateWidget(covariant ProductList oldWidget) {
    // TODO: implement didUpdateWidget
    UpdategetData();
    super.didUpdateWidget(oldWidget);
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
                    Text(widget.categoryName, style: constantFontStyle(

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
                   color: Colors.pinkAccent.shade200,
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/404_not_found.png",scale: 3,),

                            Text("No Product Available!",style: constantFontStyle(
                             fontWeight: FontWeight.bold,color: Colors.white,
                           ),),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 10),
                            //   child: Text("We Are Working Hard To Make All Products Available!"
                            //       ,style: constantFontStyle(
                            //         fontWeight: FontWeight.w500,color: Colors.white,
                            //       )),
                            // )
                          ],
                        )))
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Container(
                        //     height: 50,
                        //     color: Colors.blueGrey.shade200,
                        //     child: dynamicHorizontalListview()),

                        Container(
                          color: Colors.blueGrey.shade100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(paddingAll),
                                child: Text(
                                  " ${categoryName.length.toString()} items",
                                  style: constantFontStyle(
                                    fontSize: SubTitleFontsize,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      height: 45,
                                      child: Row(
                                        children: [
                                          // SizedBox(
                                          //   height: 40,
                                          //   child: Card(
                                          //       elevation: elevation_size,
                                          //       child: Padding(
                                          //         padding: const EdgeInsets.all(
                                          //             paddingAllTwo),
                                          //         child: Row(
                                          //           children: [
                                          //             Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                           .all(
                                          //                       paddingAll),
                                          //               child: Image.asset(
                                          //                   "assets/images/motorbike.png"),
                                          //             ),
                                          //             Text(
                                          //               "Express ",
                                          //               style:
                                          //                   constantFontStyle(
                                          //                 fontSize:
                                          //                     SubTitleFontsize,
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       )),
                                          // ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FilterMainScreen()));
                                            },
                                            child: SizedBox(
                                              height: 40,
                                              child: Card(
                                               //   elevation: elevation_size,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            paddingAllTwo),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .all(
                                                                  paddingAll),
                                                          child: Image.asset(
                                                              "assets/images/filter.png"),
                                                        ),
                                                        Text(
                                                          "Filter  ",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize:
                                                                SubTitleFontsize,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: SlidingImage(
                              widget.BannerImageList, widget.BannerID),
                        ),

                        // Padding(
                        //     padding: const EdgeInsets.all(1.0),
                        //     child: ElevatedButton(
                        //         style: ButtonStyle(
                        //           backgroundColor:
                        //           MaterialStateProperty.all(Colors.orangeAccent.shade200),
                        //           foregroundColor: MaterialStateProperty.all(Colors.green),
                        //         ),
                        //         onPressed: () {},
                        //         child: Text(
                        //           "Shop By Categories",
                        //           style: constantFontStyle(
                        //               fontSize: Fontsize,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.black),
                        //         ))),
                        Card(
                          child: dynamicListview(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: SlidingImage(
                              widget.BannerImageList, widget.BannerID),
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

          return GestureDetector(
            onTap: () {
             //      List s = [];
             //
             //      debugPrint(ProductVariantID[0][index]["product"].toString() + "ssssssssss");
             // for(int i = 0; i<4;i++){
             //   if(productId[index]==ProductVariantID[i]["product"]){
             //     s.add(ProductVariantID[i]["variant_str"]);
             //   }
             // }
             // debugPrint(s.toString() +
             //     "this is Sending image details");
              // for(int i = 0; i < ProductVariantID[])
              // if(productId[index]==ProductVariantID[i]){
              //
              // }
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
              // Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context)=>ProductDetailsNew(
              //   productId: productId[index],
              // )));

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ProductDetailsNew(
              //               productId: productId[index],
              //             )));
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
            child: Padding(
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
                                elevation: 0,
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
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context)=>ProductDetailsNew(
                                      productId: productId[index],
                                    )));
                                  },
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
                                const SizedBox(height: 2,),

                  GestureDetector(
                    onTap: (){
                               debugPrint("this is index $index");
                      GetProductDetails(productId[index],categoryName[index],index);
                    },
                    child: Container(
                      height: 20,
                      color: Colors.grey.shade200,
                      child:Row(
                                    children: [
                                    Expanded(
                                        child: Text(
                                          newStrVariant[index] != "0"?  newStrVariant[index]:  " ${strVariants[index]}",
                                            style: constantFontStyle(
                                                fontSize: SubTitleFontsize,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),

                                      Image.asset("assets/images/arrow_down.png",color: Colors.black45,)
                                    ],
                                  ),
                    ),
                  ),
                                const SizedBox(height: 10,),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    discountPercent[index] != "0"
                                        ?  newDiscountPrice[index] != "0"?   Text(
                                      "₹" +  newDiscountPrice[index],
                                      style: GoogleFonts.roboto(
                                          fontSize: TitleFontsize,
                                          fontWeight: FontWeight.bold),
                                    ):Text(
                                      "₹" +  discountprice[index],
                                      style: GoogleFonts.roboto(
                                          fontSize: TitleFontsize,
                                          fontWeight: FontWeight.bold),
                                    )
                                        :
                                    newPrice[index] != "0"? Text(
                                      "₹" + newPrice[index] ,
                                      style: GoogleFonts.roboto(
                                          fontSize: TitleFontsize,
                                          fontWeight: FontWeight.bold),
                                    ):    Text(
                                      "₹" + price[index],
                                      style: GoogleFonts.roboto(
                                          fontSize: TitleFontsize,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    const SizedBox(
                                      width: 8,
                                    ),
                                    discountPercent[index] != "0"
                                        ?
                                    Text(
                                      "₹" + newPrice[index] != "0"?  newPrice[index]: price[index],
                                      style: GoogleFonts.roboto(
                                          fontSize: 10,
                                          color: Colors.grey.shade400,
                                          decoration:
                                          TextDecoration.lineThrough),
                                    )
                                        :SizedBox()
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ///////////////////////////////////////////////////////////////////////////Changes in this line////
                                // productId[index].toString().contains(cartproductId.join(","))  ?
                                // AddedToCart[index] == "1"
                                //     ? Visibility(
                                //         visible: true,
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.end,
                                //           children: [
                                //             Expanded(
                                //               // width: 150,
                                //               child: ElevatedButton(
                                //                   style: ButtonStyle(
                                //                     backgroundColor:
                                //                         MaterialStateProperty
                                //                             .all(Colors
                                //                                 .redAccent),
                                //                     foregroundColor:
                                //                         MaterialStateProperty
                                //                             .all(Colors.green),
                                //                   ),
                                //                   onPressed: () {
                                //                     // List _tmpList = itemsNotifier.value;
                                //                     // _tmpList.add( categoryName[index]);
                                //                     // itemsNotifier.value = _tmpList;
                                //                   },
                                //                   child: Text(
                                //                     "ADDED TO Cart",
                                //                     style: constantFontStyle(
                                //                         fontSize: Fontsize,
                                //                         fontWeight:
                                //                             FontWeight.bold,
                                //                         color: Colors.white),
                                //                   )),
                                //             ),
                                //           ],
                                //         ),
                                //       )
                                 numberOfItems[index] == 0||userID == null?
                                // Visibility(
                                //         visible: hideAddToCart[index],
                                //         child:
                                 Row(
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
                                                      addBtnLoader[index] = true;

                                                      numberOfItems[index]++;
                                                      debugPrint(ProductVariant.toString() + "this is variant");
                                                      debugPrint(ProductVariant[index].toString() + "this is variant");

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
                                                            ProductVariant[index],"1",index);
                                                      }
                                                    });
                                                  },
                                                  child: addBtnLoader[index]?Center(child: SizedBox(
                                                    height: 25,width: 25,                                  child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.2,),
                                                  ),):  Text(
                                                    "ADD",
                                                    style: constantFontStyle(
                                                        fontSize: Fontsize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ],
                                       // ),
                                      ):
                                // Visibility(
                                //   visible: unhideAddToCart[index],
                                //   child:
                                 addBtnLoader[index]?Center(child: SizedBox(
                                   height: 25,width: 25,                                  child: CircularProgressIndicator(color:themeColor,strokeWidth: 1.2,),
                                 ),):   Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                     _shoppingItem(index,productId[index],ProductVariant[index]),

                                    ],
                                  ),
                              //  )
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
          );
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

  Widget _shoppingItem(int itemIndex,productID,productVariant) {
    debugPrint(productID);
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

                     _decrementButton(itemIndex,productID,productVariant),
                Text(
                  '${numberOfItems[itemIndex].toString()}',
                  style: constantFontStyle(fontSize: 15.0),
                ),
                _incrementButton(itemIndex,productID,productVariant),
              ],
            ),
          ),

        ),
      ],
    );
  }
  Widget _incrementButton(int index,productID,productVariant) {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.black),
      backgroundColor: Colors.white70,
      onPressed: () {
        setState(() {
          addBtnLoader[index] = true;


       //   productTotal = 0;
          numberOfItems[index]++;
          addtocart(context, productID, productVariant,numberOfItems[index].toString(),index);

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


  Widget _decrementButton(int index,productID, productVariant) {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            addBtnLoader[index] = true;

            numberOfItems[index]--;

            if(numberOfItems[index] == 0){
              cartApi();
              for(int i = 0; i < cartProductName.length;i++) {
                if (categoryName[index] == cartProductName[i]) {
                  removefromcart(context, cartProductID[i]);

                }
              }

            }

            else{

              addtocart(context, productID, productVariant,
                  numberOfItems[index].toString(),index);
            }
          });
        },
        // child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
        child: const Icon(
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
    var Api;
    if (userID != null) {
      Api =
          "$productApi?userid=$userID&subcategory=${widget.subcategory.toString()}&category=${widget.category.toString()}";
    }else{
       Api =
          "$productApi?subcategory=${widget.subcategory.toString()}&category=${widget.category.toString()}";
    }
    debugPrint("this is Api $Api");
    var response = await http.get(Uri.parse(Api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      //
      // List sa = [];
      // for(int i = 0; i < productModel.result!.length; i++) {
      //
      //
      //   for(int j = 0; j < productModel.result![i].imgs!.length; j++) {
      //
      //     sa.add(productModel.result![j].imgs![j].imgpath.toString());
      //   }
      // }
       debugPrint("this is sa ${data.toString()}");

      // List<List<String>> imagesList = [];
      // List<Map<String, dynamic>> outer =
      // productModel.result! as List<Map<String, dynamic>>;
      // for (Map<String, dynamic> data in outer) {
      //   List<Img> inner = productModel.result![outer].imgs![0];
      //   List<String> images = [];
      //
      //   for (Map<String, dynamic> value in inner) {
      //     images.add(value["imgpath"]);
      //   }
      //   imagesList.add(images);
      // }

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
          ProductVariant.clear();
          shopName.clear();
          addBtnLoader.clear();


          ProductVegNonveg.clear();
          AddedToCart.clear();
          ProductImagesSend.clear();
          discountPercent.clear();
          strVariants.clear();
          ProductVariantID.clear();
          numberOfItems.clear();
          newStrVariant.clear();
          newDiscountPrice.clear();
          newPrice.clear();

          List s = [];
          List imageProduct = [];


          for (int i = 0; i < data["result"].length; i++) {
            ProductVariantID.add(data["result"][i]["opts"].toString().replaceAll("[", "").replaceAll("]", ""));

          }
          for (int i = 0; i < data["result"].length; i++) {
          //  numberOfItems.add(1);

            categoryName.add(data["result"][i]["name"]);
            addBtnLoader.add(false);

            productId.add(data["result"][i]["id"]);
            productDescription.add(data["result"][i]["description"]);
            numberOfItems.add(int.parse(data["result"][i]["in_cart_qty"]));
            shopName.add(data["result"][i]["shop_name"]);
            AddedToCart.add(data["result"][i]["in_cart"]);
            discountPercent
                .add(data["result"][i]["discount"].toString().split(".").first);
            ProductVegNonveg.add(data["result"][i]["findicator"]);

            for (int j = 0; j < data["result"][i]["opts"].length; j++) {
              price.add(data["result"][i]["opts"][0]["price"]
                  .toString()
                  .split(".")
                  .first);
              discountprice.add(data["result"][i]["opts"][0]["dprice"]
                  .toString()
                  .split(".")
                  .first);

            }
            newStrVariant.add("0");
            newDiscountPrice.add("0");
            newPrice.add("0");

            strVariants.add(data["result"][i]["opts"][0]["variant_str"]
                .toString()
                .split(":")
                .last);
            ProductVariant.add(data["result"][i]["opts"][0]["variants"].toString());

            if (data["result"][i]["imgs"].length <= 0) {
              ProductImage.add(
                  "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png");
            } else {
            //  for (int j = 0; j < data["result"][i]["imgs"].length; j++) {
                ProductImage.add(data["result"][i]["imgs"][0]["imgpath"]);
                ProductImagesSend.add(data["result"][i]["imgs"][0]);
           //   }
            }
          }
          debugPrint("this is strVariantsList $ProductVariantID");


        }


        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }
  UpdategetData() async {
    final prefs = await SharedPreferences.getInstance();
    final StrCartLength = prefs.getString('cartLength') ?? "0";
    CartLength = StrCartLength;

    userID = prefs.getString('userId');
    var Api;
    if (userID != null) {
      Api =
          "$productApi?userid=$userID&subcategory=${widget.subcategory.toString()}&category=${widget.category.toString()}";
    }else{
       Api =
          "$productApi?subcategory=${widget.subcategory.toString()}&category=${widget.category.toString()}";
       debugPrint("$productApi?subcategory=${widget.subcategory.toString()}&category=${widget.category.toString()}");

    }
    var response = await http.get(Uri.parse(Api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      //
      // List sa = [];
      // for(int i = 0; i < productModel.result!.length; i++) {
      //
      //
      //   for(int j = 0; j < productModel.result![i].imgs!.length; j++) {
      //
      //     sa.add(productModel.result![j].imgs![j].imgpath.toString());
      //   }
      // }
       debugPrint("this is sa ${data.toString()}");

      // List<List<String>> imagesList = [];
      // List<Map<String, dynamic>> outer =
      // productModel.result! as List<Map<String, dynamic>>;
      // for (Map<String, dynamic> data in outer) {
      //   List<Img> inner = productModel.result![outer].imgs![0];
      //   List<String> images = [];
      //
      //   for (Map<String, dynamic> value in inner) {
      //     images.add(value["imgpath"]);
      //   }
      //   imagesList.add(images);
      // }

      setState(() {
        if (data["message"].toString() == "Products Not Found") {
          noProduct = "1";
        } else {
          noProduct = "2";
          categoryName.clear();
          ProductImage.clear();
          productId.clear();
          addBtnLoader.clear();
          productDescription.clear();
          price.clear();
          discountprice.clear();
          productDescription.clear();
          ProductVariant.clear();
          shopName.clear();
          ProductVegNonveg.clear();
          AddedToCart.clear();
          ProductImagesSend.clear();
          discountPercent.clear();
          strVariants.clear();
          ProductVariantID.clear();
          numberOfItems.clear();


          List s = [];
          List imageProduct = [];


          for (int i = 0; i < data["result"].length; i++) {
            ProductVariantID.add(data["result"][i]["opts"].toString().replaceAll("[", "").replaceAll("]", ""));

          }
          for (int i = 0; i < data["result"].length; i++) {
          //  numberOfItems.add(1);

            categoryName.add(data["result"][i]["name"]);
            addBtnLoader.add(false);
            productId.add(data["result"][i]["id"]);
            productDescription.add(data["result"][i]["description"]);
            numberOfItems.add(int.parse(data["result"][i]["in_cart_qty"]));
            shopName.add(data["result"][i]["shop_name"]);
            AddedToCart.add(data["result"][i]["in_cart"]);
            discountPercent
                .add(data["result"][i]["discount"].toString().split(".").first);
            ProductVegNonveg.add(data["result"][i]["findicator"]);

            for (int j = 0; j < data["result"][i]["opts"].length; j++) {
              price.add(data["result"][i]["opts"][0]["price"]
                  .toString()
                  .split(".")
                  .first);
              discountprice.add(data["result"][i]["opts"][0]["dprice"]
                  .toString()
                  .split(".")
                  .first);

            }

            strVariants.add(data["result"][i]["opts"][0]["variant_str"]
                .toString()
                .split(":")
                .last);
            ProductVariant.add(data["result"][i]["opts"][0]["variants"].toString());

            if (data["result"][i]["imgs"].length <= 0) {
              ProductImage.add(
                  "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png");
            } else {
            //  for (int j = 0; j < data["result"][i]["imgs"].length; j++) {
                ProductImage.add(data["result"][i]["imgs"][0]["imgpath"]);
                ProductImagesSend.add(data["result"][i]["imgs"][0]);
           //   }
            }
          }
          debugPrint("this is strVariantsList $ProductVariantID");


        }


        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }

  addtocart(context, productId, variant,quantity,index) async {


    debugPrint("this is quantity $quantity");
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    final dataBody = {
      "userid": userID,
      "product": productId.toString(),
      "variants": newVariant??variant.toString(),
      "qty": quantity,
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
          addBtnLoader[index] = false;
        });
      } else {
        setState(() {
          addBtnLoader[index] = false;

        });
        Singleton.showmsg(context, "Message", body["message"]);
      }

      debugPrint(body.toString());
    } else {
      setState(() {

      });
      addBtnLoader[index] = false;

      Singleton.showmsg(context, "Message", body["error"]);
    }
  }

  void showInSnackBar() {
    _scaffoldKey.currentState!
        .showSnackBar(SnackBar(duration: const Duration(seconds:1),content: Text("ADDED To Cart",style: constantFontStyle(fontSize: 14),)));
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
      cartProductName.clear();
      cartProductID.clear();
      for(int i = 0 ; i < data["result"]["items"].length; i++) {
        cartProductName.add(data["result"]["items"][i]["pname"].toString());
        cartProductID.add(data["result"]["items"][i]["id"].toString());

      }

      String _tmpList = data["result"]["items"].length.toString();
      itemsNotifier.value = _tmpList;
      prefs.setString('cartLength', _tmpList);
    } else {
      debugPrint("Error in the Api");
    }
  }
  removefromcart(context, productId) async {
    debugPrint(productId + "this is product id to removed");
    var userID;
    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');
    final cartOid = prefs.getString('cartOid');
    debugPrint(cartOid.toString() + "this is Order id to removed");

    final dataBody = {
      "userid": userID,
      "id": productId.toString(),
      "oid": cartOid,
      //  "password":passwordController.text,
    };
    var response =
    await http.post(Uri.parse(removeFromCartApi), body: dataBody);
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    debugPrint(body["status"].toString());
    if (response.statusCode == 200) {
      setState(() {});
      if (body["status"] == "200") {
        setState(() {
          getData();
          // Singleton.showmsg(context, "Message", body["result"]["message"]);
        });
      } else {
        Singleton.showmsg(context, "Message", body["message"]);
      }

      debugPrint(body.toString());
    } else {
      Singleton.showmsg(context, "Message", body["error"]);
    }
  }

  GetProductDetails(productID,productName,productIndex) async {
    var response = await http
        .get(Uri.parse("$productDetailsApi?product=${productID}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<String> productDetailsPrice = [];
      List<String> productDetailsStrVariant = [];
      List<String> productDetailsVariant = [];
      List<String> productDetailsDiscountPrice = [];
      setState(() {

        for (int j = 0; j < data["result"]["opts"].length; j++) {
          productDetailsPrice.add(
              data["result"]["opts"][j]["price"].toString().split(".").first);
          productDetailsDiscountPrice.add(data["result"]["opts"][j]["dprice"]);
          productDetailsStrVariant.add(data["result"]["opts"][j]["variant_str"]
              .toString()
              .split(":")
              .last);

          productDetailsVariant.add(data["result"]["opts"][j]["variants"].toString());
        }
      //  ShowDilaogbox();
          ShowDilaogbox(context,productName,productDetailsStrVariant,productDetailsDiscountPrice,productIndex,productDetailsPrice,productDetailsVariant);

        debugPrint("this is str Variant $productDetailsStrVariant");
      //  _showMyDialog(context,productName,productDetailsStrVariant,productDetailsDiscountPrice,productIndex,productDetailsPrice,productDetailsVariant);
      });
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error in the Api");
    }
  }
  // _showMyDialog(context,productName,productDetailsStrVariant,productDetailsDiscountPrice,productIndex,productDetailsPrice,productDetailsVariant) async {
  //   return showDialog<void>(
  //     context: context,
  // //    barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Center(
  //           child: Column(
  //             children: [
  //               Text(
  //                 'Available Quantity For ',
  //                 style: constantFontStyle(
  //                     fontSize: TitleFontsize, fontWeight: FontWeight.w500),
  //               ),
  //               const Divider(thickness: 1),
  //               Text(
  //                 productName,
  //                 style: constantFontStyle(
  //                     fontSize: TitleFontsize, fontWeight: FontWeight.bold),
  //               ),
  //             ],
  //           ),
  //         ),
  //         content: SingleChildScrollView(
  //             child: SizedBox(
  //               height: 200,
  //               child: ListView.builder(
  //
  //                   itemCount: productDetailsStrVariant.length,
  //                   //  itemCount: title.length,
  //                   shrinkWrap: true,
  //                   //  physics: const ScrollPhysics(),
  //                   itemBuilder: (context, index) {
  //                     return  GestureDetector(
  //                       onTap: (){
  //
  //                          newStrVariant[productIndex] = productDetailsStrVariant[index];
  //                          newDiscountPrice[productIndex] = productDetailsDiscountPrice[index];
  //                          newPrice[productIndex] = productDetailsPrice[index];
  //
  //                          newVariant = productDetailsVariant[index];
  //
  //                          debugPrint(productDetailsStrVariant[index].toString() + "this is productDetailsStrVariant");
  //                          debugPrint(newStrVariant.toString() + "this is strVariants");
  //
  //                          // newStrVariant.clear();
  //                          // strVariants.clear();
  //                          // try{}catch(e) {
  //                          //   for (int i = 0; i < strVariants.length; i++) {
  //                          //     strVariants[i] == productDetailsStrVariant[index];
  //                          //   }
  //                          //
  //                             Navigator.pop(context);
  //                        //  }
  //
  //
  //                       },
  //                       child: Column(
  //                         children: [
  //                           Container(
  //                             color: Colors.blueGrey.shade50,
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(8.0),
  //                                   child: Text(
  //                                     productDetailsStrVariant[index],
  //                                     style: constantFontStyle(
  //                                         fontSize: SubTitleFontsize,
  //                                         fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.all(8.0),
  //                                   child: Text(
  //                                     productDetailsDiscountPrice[index],
  //                                     style: constantFontStyle(
  //                                       fontSize: SubTitleFontsize,
  //                                     ),
  //                                   ),
  //                                 ),
  //
  //                               ],
  //                             ),
  //                           ),
  //                           Divider()
  //                         ],
  //                       ),
  //                     );
  //                   }),
  //             )
  //         ),
  //       );
  //     },
  //   );
  // }

ShowDilaogbox(context,productName,productDetailsStrVariant,productDetailsDiscountPrice,productIndex,productDetailsPrice,productDetailsVariant) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                Text(
                  'Available Quantity For ',
                  style: constantFontStyle(
                      fontSize: TitleFontsize, fontWeight: FontWeight.w500),
                ),
                const Divider(thickness: 1),
                Text(
                  productName,
                  style: constantFontStyle(
                      fontSize: TitleFontsize, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          content: Container(
            width: double.maxFinite,
             height: 50*double.parse(productDetailsStrVariant.length.toString()),
            child: Column(
                mainAxisSize: MainAxisSize.min,

                children: <Widget>[
                  Expanded(
                      child: ListView.builder(

                          itemCount: productDetailsStrVariant.length,
                          //  itemCount: title.length,
                          shrinkWrap: true,
                          //  physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return  GestureDetector(
                              onTap: (){

                                newStrVariant[productIndex] = productDetailsStrVariant[index];
                                newDiscountPrice[productIndex] = productDetailsDiscountPrice[index];
                                newPrice[productIndex] = productDetailsPrice[index];

                                newVariant = productDetailsVariant[index];

                                debugPrint(productDetailsStrVariant[index].toString() + "this is productDetailsStrVariant");
                                debugPrint(newStrVariant.toString() + "this is strVariants");

                                // newStrVariant.clear();
                                // strVariants.clear();
                                // try{}catch(e) {
                                //   for (int i = 0; i < strVariants.length; i++) {
                                //     strVariants[i] == productDetailsStrVariant[index];
                                //   }
                                //
                                Navigator.pop(context);
                                //  }


                              },
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.blueGrey.shade50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            productDetailsStrVariant[index],
                                            style: constantFontStyle(
                                                fontSize: SubTitleFontsize,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            productDetailsDiscountPrice[index],
                                            style: constantFontStyle(
                                              fontSize: SubTitleFontsize,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            );
                          }),
                  )
                ]
            ),
          ),
        );
      }
  );
}

}
