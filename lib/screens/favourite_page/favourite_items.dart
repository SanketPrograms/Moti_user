import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/screens/product_details/product_details.dart';
import 'package:big_basket/screens/product_details/product_details_new.dart';
import 'package:big_basket/screens/user_login/login_sliding_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class FavouriteList extends StatefulWidget {
  FavouriteList({Key? key}) : super(key: key);

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
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
  var noProduct = "0";
  var userID;

  @override
  void initState() {
    // TODO: implement initState


    getData();
    // getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ?Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
        : noProduct == "1"?Center(
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),

              Image.asset("assets/images/show_empty_cart.gif",      fit: BoxFit.fill,



              height: MediaQuery.of(context).size.height / 3,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text("No Favourite Items Found",style: constantFontStyle(
                    fontSize: 14,
                    color: themeColor,
                    fontWeight: FontWeight.bold
                ),),
              ),
            ],
          ),
        ):Container(
      child:     Expanded(
        flex: 5,
        child: Container(
          child: dynamicListview(),
        ),
      ),
    );
  }

  Widget dynamicListview() {
    // print("this is findword $findWord");
    return ListView.builder(
      physics: BouncingScrollPhysics(),
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

                              InkWell(
                                onTap: (){
                                  RemoveFromFav(context,productId[index]);
                                },
                                child: Container(

                                  child: Row(
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.all(2.0),
                                      //   child: Image.asset(
                                      //     "assets/images/delivery_truck.png",
                                      //     color: Colors.grey,
                                      //     height: 18,
                                      //   ),
                                      // ),
                                  TextButton(
                                  style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty
                                      .all(Colors
                                      .white),
                                  foregroundColor:
                                  MaterialStateProperty
                                      .all(Colors.green),
                                ),
                                  onPressed: () {
                                    // List _tmpList = itemsNotifier.value;
                                    // _tmpList.add( categoryName[index]);
                                    // itemsNotifier.value = _tmpList;

                                    RemoveFromFav(context, productId[index]);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/fav_added2.png",height: 20
                                        ,color: Colors.redAccent.shade200,),
                                            SizedBox(width: 10,),
                                      Text(
                                        "Remove",
                                        style: constantFontStyle(
                                            fontSize: Fontsize,
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Colors.redAccent),
                                      ),
                                    ],
                                  )),

                                    ],
                                  ),
                                ),
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



  getData() async {
    final prefs = await SharedPreferences.getInstance();
    final StrCartLength = prefs.getString('cartLength') ?? "0";
    CartLength = StrCartLength;

    userID = prefs.getString('userId');
    var Api;
    if (userID != null) {
      Api = viewFavApi;
      // Api =
      // "$recommendationApi?userid=$userID}";
      debugPrint("login to view");
    }else{
      Api = viewFavApi;
    }
    debugPrint("this is Api $Api");
    var response = await http.get(Uri.parse("$Api?userid=$userID"));
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
      // debugPrint("this is sa ${sa[0]}");

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
        if (data["error"].toString() == "1"||data["message"].toString() == "Favorites Not Found") {
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
              ProductVariant.add(
                  data["result"][i]["opts"][j]["variants"].toString());
              strVariants.add(data["result"][i]["opts"][j]["variant_str"]
                  .toString()
                  .split(":")
                  .last);
            }
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
          debugPrint("this is AddedToCart $AddedToCart");


        }


        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }

  addtocart(context,productId,variant)  async{
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    final dataBody = {
      "userid":userID,
      "product":productId.toString(),
      "variants":variant.toString(),
      "qty":"1",
      //  "password":passwordController.text,
    };
    var response = await http.post(Uri.parse(addToCart),body:dataBody);
    var body = jsonDecode(response.body);
    debugPrint("added to cart"+body.toString());
    // debugPrint(body["status"].toString());
    if (response.statusCode == 200) {


      if(body["status"]=="200"){
        setState(() {


          prefs.setString('cartOid',body["result"]["oid"]);
        });
      }else {

        Singleton.showmsg(context, "Message", body["message"]);


      }

      debugPrint(body.toString());
    } else {
      Singleton.showmsg(context, "Message", body["error"]);

    }
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

  RemoveFromFav(context,productID) async {
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');


    final dataBody = {
      "userid": userID,
      "product": productID.toString(),
    };
    var response = await http.post(Uri.parse(removeFromFavApi), body: dataBody);
    var body = jsonDecode(response.body);
    debugPrint(body.toString());
    if (response.statusCode == 200) {
      if (body["status"] == "200") {
        setState(() {
          getData();
          // showInSnackBar("Removed From Your Favorite List");

        });
      } else {
        Singleton.showmsg(context, "Message", body["message"]);
      }

      debugPrint(body.toString());
    } else {
      Singleton.showmsg(context, "Message", body["error"]);
    }
  }
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


}
