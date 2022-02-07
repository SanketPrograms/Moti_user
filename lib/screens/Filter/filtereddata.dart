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

class filteredData extends StatefulWidget {

  final filterdata;
  filteredData(
      {Key? key, this.filterdata})
      : super(key: key);

  @override
  State<filteredData> createState() => _filteredDataState();
}

class _filteredDataState extends State<filteredData> {
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
  List BannerImageList = [];
  List BannerID = [];
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
  var noProduct = "0";
  var userID;

  @override
  void initState() {
    // TODO: implement initState
    // BannerImageApi();
    debugPrint(widget.filterdata + "this is filtered data");
    getData();
    super.initState();
  }



  @override
  void didUpdateWidget(covariant filteredData oldWidget) {
    // TODO: implement
    setState(() {
      getData();

    });
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return   isLoading
        ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))

        :




    Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text("Filtered Data",style: constantFontStyle(
          fontSize: 14
        ),),
      ),
      body: Card(
        child: dynamicListview(),
      ),
    );



  }

  Widget dynamicListview() {
    // print("this is findword $findWord");


    return ListView.builder(
      physics: BouncingScrollPhysics(),

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

            Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context)=>ProductDetailsNew(
              productId: productId[index],
            )));

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
                              const SizedBox(height: 2,),

                              GestureDetector(
                                onTap: (){

                                  //if userid = userid add variants
                                  // _showMyDialog(context, categoryName[index],strVariants[index],discountprice[index]);
                                  _showMyDialog(context);
                                },
                                child: Container(
                                  height: 20,
                                  color: Colors.grey.shade200,
                                  child:Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          " ${strVariants[index]}",
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
                                  ):SizedBox()
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
                              numberOfItems[index] == 0?
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
                                                  ProductVariant[index],"1");
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
                                // ),
                              ):
                              // Visibility(
                              //   visible: unhideAddToCart[index],
                              //   child:
                              Row(
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


            //   productTotal = 0;
            numberOfItems[index]++;
            addtocart(context, productID, productVariant,numberOfItems[index].toString());

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
                  numberOfItems[index].toString());
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


  _showMyDialog(context) async {
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
                  '1kG',
                  style: constantFontStyle(
                      fontSize: TitleFontsize, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  //  itemCount: title.length,
                  shrinkWrap: true,
                  //  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return  Row(
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
                            "50rs",
                            style: constantFontStyle(
                              fontSize: SubTitleFontsize,
                            ),
                          ),
                        ),

                      ],
                    );
                  })
          ),
        );
      },
    );
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    final StrCartLength = prefs.getString('cartLength') ?? "0";
    CartLength = StrCartLength;

    userID = prefs.getString('userId');

    var response = await http.post(Uri.parse(productApi),
        body: {
      "filters" :widget.filterdata
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint("this is data $data");

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
            ProductVariantID.add(data["result"][i]["opts"]);

          }
          for (int i = 0; i < data["result"].length; i++) {
            //  numberOfItems.add(1);

            categoryName.add(data["result"][i]["name"]);

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

  addtocart(context, productId, variant,quantity) async {

    debugPrint("this is quantity $quantity");
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    final dataBody = {
      "userid": userID,
      "product": productId.toString(),
      "variants": variant.toString(),
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




}
