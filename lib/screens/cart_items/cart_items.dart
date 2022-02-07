import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:big_basket/Widgets/drawer.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/main.dart';
import 'package:big_basket/model_class/cart_model_class.dart';
import 'package:big_basket/screens/address/view_address.dart';
import 'package:big_basket/screens/cart_items/before_checkout_product.dart';
import 'package:big_basket/screens/delivery/delivery_option.dart';
import 'package:big_basket/screens/search/search_horizontal_cards.dart';
import 'package:big_basket/screens/search/searchnavigation.dart';
import 'package:big_basket/screens/user_login/login_sliding_image.dart';
import 'package:big_basket/screens/user_login/user_login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartItem extends StatefulWidget {
  final NavigateFlag;
   CartItem({Key? key, this.NavigateFlag}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  var Cart_products;
  var dataLength;
  List<int> productPriceTotal = [];
  List numberOfItems = [];
  List ProductImage = [];
  List productname = [];
  String? addressID;

  List productprice = [];
  List productDiscountprice = [];
  List<String>productWeight = [];
  List<String>Variant = [];
  List<String>productId = [];
  List<String>ADD2CartproductId = [];
  List<String>productOID = [];
  List<String>productDiscount = [];
  List<String>ProductVegNonveg = [];
  List<String>product_Deliver_or_not = [];
  List<String>vendorName = [];
  bool isLoading = true;
  num productTotal = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getData();

    debugPrint("aaaaa");

    super.initState();

    //  addItems();
  }



  @override
  void didUpdateWidget(covariant CartItem oldWidget) {
    // TODO: implement didUpdateWidget

      didUpateMethod();


    super.didUpdateWidget(oldWidget);
  }

  didUpateMethod() async{
    final prefs = await SharedPreferences.getInstance();

    setState(() {

      var userID;
      userID = prefs.getString('userId');


      if(userID != null) {

        productPriceTotal.clear();

        getData();
      }
      else{
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("bbbbb");
   // productPriceTotal.clear();  /////////////////////if issue index comes remove this

    return isLoading == true
        ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
        : WillPopScope(
      onWillPop: ()async{
        return Singleton.handleBack(context);

      },
          child: Scaffold(
              key: _scaffoldKey,

              backgroundColor:dataLength == 0
            ? Colors.black87:Colors.white,

              drawer: drawer(),
              appBar: AppBar(
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

                  PopupMenuButton<String>(

                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context){
                      return Constants.choices.map((String choice){
                        return PopupMenuItem<String>(
height: 25,

                          value: choice,
                          child: Text(choice,style: constantFontStyle(fontSize: 12,color: Colors.black),),);
                      }).toList();

                    }
                    ,),
                ],
                backgroundColor: themeColor,
                title: Text(
                  "Review Basket",
                  style: constantFontStyle(
                    fontSize: 14,
                  ),
                ),
                centerTitle: true,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              bottomNavigationBar: productname.isEmpty
                  ? Text("")
                  : Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                onPressed: () {},
                                child: Text(
                                  // "Total: ₹${ productPriceTotal.toString()}",
                                  "Cart Total  ₹$productTotal",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,fontSize: 14),
                                ))),
                        Expanded(
                          child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                if(productTotal<500){
                                  showInSnackBar("Add More Products Can't Be Less Than 500Rs");

                                }else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DeliveryOption(
                                                  productPriceTotal: productTotal,numberOfItems:numberOfItems)));
                                }
                              },
                              child: Text("Proceed To Pay",
                                  style: constantFontStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
              body: dataLength == 0
                  ? SingleChildScrollView(
                    child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 50,),

                            Image.asset(
                              "assets/images/show_empty_cart.gif",
                              fit: BoxFit.fill,



                              height: MediaQuery.of(context).size.height / 3,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 5),
                              child: Text("Your basket is empty",style: constantFontStyle(
                                  fontSize: 14,
                                  color: themeColor,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 5
                              ),
                              child: Text("Don't Worry We Have Best Offers For You!",style: constantFontStyle(
                                fontSize: 12,
                                color: themeColor,
                                fontWeight: FontWeight.w500
                              ),),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 14.0),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      themeColor),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context)=>MyApp()));

                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.add_shopping_cart,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "START SHOPPING",
                                                    style: constantFontStyle(
                                                        fontSize: Fontsize,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ))),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  )
                  : SingleChildScrollView(
                physics: BouncingScrollPhysics(),

                child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              addressID != null?    GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAddress()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/images/bottom_navigation/location.png",
                                    scale: 1.5,
                                    color: Colors.black,
                                  ),

                                ),
                              ):Text(""),
                              addressID != null
                                  ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Center(
                                              child: Text(
                                                addressID.toString(),
                                                // maxLines: 2,
                                                //overflow: TextOverflow.ellipsis,
                                                style: constantFontStyle(
                                                    fontSize: Fontsize,
                                                    color: Colors.black),
                                              ),
                                            ),

                                      ],
                                    ),
                                  )
                                  :  Center(
                                        child: Text(
                                          applicationName,
                                          // maxLines: 2,
                                          //overflow: TextOverflow.ellipsis,
                                          style: constantFontStyle(
                                              fontSize: Fontsize,
                                              color: Colors.black),
                                        ),
                                      ),

                            ],
                          ),
                          Container(
                            color: Colors.blueGrey.shade100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(paddingAll),
                                  child: Text(
                                    " Total ",
                                    style: constantFontStyle(
                                      fontSize: SubTitleFontsize,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(paddingAll),
                                  child: Text(
                                    " ${productname.length.toString()} items",
                                    style: constantFontStyle(
                                      fontSize: SubTitleFontsize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          CartItemLists(),
                         BeforeCheckOutProduct(),
                          SizedBox(
                            height: 10,
                          )

                          // Container(
                          //     width:double.infinity,
                          //     height:200,
                          //     color: Colors.blueGrey.shade200,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         Expanded(child: Center(child: dynamicHorizontalListview())),
                          //       ],
                          //     )),
                          //
                          // SizedBox(height: 100,),
                        ],
                      ),
                  ),
            ),
        );
  }

  Widget CartItemLists() {
    return ListView.builder(
      shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: productname.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProductDetails(productId:productId)));
              },

            //    height: MediaQuery.of(context).size.height,
                child:

             //   elevation: elevation_size,
             //      shape: RoundedRectangleBorder(
             //        borderRadius: BorderRadius.circular(100.0),
             //      ),
                   Column(
                     children: [
                       Container(
                       //   decoration: const BoxDecoration(color: Colors.white),
                          //  alignment: Alignment.center,
                          child: Row(
                            children: [
                              // subtitle: Text(description[index]),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Badge(
                                        position:
                                        BadgePosition.topStart(top: -6, start: -6),
                                        badgeColor: Colors.transparent,
                                        elevation: 100,
                                        showBadge: true,
                                        badgeContent: productDiscount[index] != "0"
                                            ? Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                        topRight:
                                                        Radius.circular(
                                                            0),
                                                        bottomRight:
                                                        Radius.circular(
                                                            50))),
                                                color: themeColor,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    " Min ${productDiscount[index]}% OFF  ",
                                                    style: constantFontStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                            const SizedBox(
                                              height: 85,
                                            ),

                                          ],
                                        )
                                            : null,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          elevation: 2,
                                          child: CachedNetworkImage(
                                            errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),

                                            placeholder: (context, url) => Center(
                                              child: Image.asset("assets/images/image_loader.gif"),
                                            ),
                                            imageUrl: ProductImage[index],
                                            width:
                                            MediaQuery.of(context).size.width / 2.5,
                                            height:
                                            MediaQuery.of(context).size.width / 2.5,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vendorName[index],
                                        style: constantFontStyle(
                                            fontSize: SubTitleFontsize,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        productname[index],
                                        style: constantFontStyle(
                                            fontSize: TitleFontsize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                     const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        productWeight[index]
                                            .toString()
                                            .split(":")
                                            .last,
                                        style: constantFontStyle(
                                          fontSize: SubTitleFontsize,
                                        ),
                                      ),
                                      const  SizedBox(
                                        height: 5,
                                      ),
                                      productDiscount[index]!="0"?
                                      Visibility(
                                        visible: true,
                                        child: Text(
                                          "₹"+productprice[index].toString(),
                                          style: GoogleFonts.roboto(
                                              fontSize: 10,
                                              color: Colors.grey.shade400,
                                              decoration: TextDecoration.lineThrough),
                                        ),
                                      ):SizedBox(),


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(

                                            child: Text(

                                             // "₹" + productprice[index].toString().split(".").first,
                                              "₹" + productDiscountprice[index].toString().split(".").first,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),

                                          Expanded(flex: 4,child: _shoppingItem(index))

                                        ],
                                      ),
                                      const    SizedBox(height:20,),
                                      product_Deliver_or_not[index]=="0"? Text("Can't Delivery To Your Location",style: constantFontStyle(
                                       fontSize: 12,color: Colors.redAccent
                                     ),):
                                          SizedBox(height: 0,width: 0,)
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          )),
                       const  Divider(thickness: 2,)
                     ],
                   ),


            );
          },
    );
  }

  Widget _shoppingItem(int itemIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       SizedBox(
            // width: 200,
            height: 35,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Image.asset("assets/flutter.png", width: 100),
                  numberOfItems[itemIndex] <= 1
                      ? _deleteButton(itemIndex)
                      : _decrementButton(itemIndex),
                  Text(
                    '${numberOfItems[itemIndex]}',
                    style: TextStyle(fontSize: 15.0),
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
      child: Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          productTotal = 0;
          numberOfItems[index]++;

          // productPriceTotal.add(int.parse(productprice[index]
          //     .toString()
          //     .split(".")
          //     .first));
          productPriceTotal[index] =
              (int.parse(productDiscountprice[index].toString().split(".").first) *
                  int.parse(numberOfItems[index].toString().split(".").first));

          productPriceTotal.forEach((num e) {
            productTotal += e;
          });
          debugPrint(productTotal.toString());

          addtocart(context, ADD2CartproductId[index], Variant[index],numberOfItems[index].toString());

        });
      },
    );
  }

  Widget _decrementButton(int index) {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            productTotal = 0;
            numberOfItems[index]--;

            // productPriceTotal.add(int.parse(productprice[index]
            //     .toString()
            //     .split(".")
            //     .first));
            productPriceTotal[index] =
            (int.parse(productDiscountprice[index].toString().split(".").first) *
                int.parse(numberOfItems[index].toString().split(".").first));

            productPriceTotal.forEach((num e) {
              productTotal += e;
            });
            debugPrint(productTotal.toString());
          });
        },
        // child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
        child: const Icon(
          Icons.remove,
          color: Colors.black,
        ),
        backgroundColor: Colors.white);
  }

  Widget _deleteButton(int index) {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            productPriceTotal.clear();
            // numberOfItems[index]--;
            removefromcart(context, productId[index], productOID[index]);
          });
        },
        // child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
        child: Icon(
          Icons.delete_outline,
          color: Colors.red,
        ),
        backgroundColor: Colors.white);
  }

  getData() async {
    var userID;
    final prefs = await SharedPreferences.getInstance();
    setState(() {

    });
    addressID = prefs.getString('userAddress');

    userID = prefs.getString('userId');
    final cartOid = prefs.getString('cartOid');
    final userPincode = prefs.getString('userPincode');


    debugPrint("this is the Api $viewCart?userid=$userID&oid=$cartOid&pincode=$userPincode");
    if (userID == null) {
       isLoading = false;
      Navigator.of(context,rootNavigator: true).push(CupertinoPageRoute(builder: (context)=>Login_Sliding_image()));

    } else {

      var response =
          await http.get(Uri.parse("$viewCart?userid=$userID&oid=$cartOid&pincode=$userPincode"));
      //var response = await http.get(Uri.parse("$product?userid=$userID&vendor=5&subcategory=3&category=3}"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        debugPrint("this is data${data.toString()}");

        productname.clear();
        productprice.clear();
        productWeight.clear();
        productOID.clear();
        productId.clear();
        ProductImage.clear();
        ProductVegNonveg.clear();
        ADD2CartproductId.clear();
        productDiscount.clear();
        vendorName.clear();
        numberOfItems.clear();
        Variant.clear();
        productDiscountprice.clear();
        product_Deliver_or_not.clear();
        String _tmpList;
        if (data["message"] == "Order Not Found" || cartOid == null||data["result"]["items"].length<=0) {
          debugPrint("noo");
          setState(() {
            dataLength = 0;
            itemsNotifier.value = "0";
            isLoading = false;
          });
        } else {

          _tmpList   = data["result"]["items"].length.toString();
          itemsNotifier.value = _tmpList;

          debugPrint("this is cart item$_tmpList");
          prefs.setString('cartLength',_tmpList);
          if (data["result"]["items"].length != null ||
              data["result"]["items"].length != 0) {
            setState(() {
              dataLength = 1;

            });
            for (int i = 0; i < data["result"]["items"].length; i++) {
              productname.add(data["result"]["items"][i]["pname"].toString());

              productDiscount.add(data["result"]["items"][i]["discount"]
                  .toString()
                  .split(".")
                  .first);
              numberOfItems.add(int.parse(data["result"]["items"][i]["qty"]));
              ADD2CartproductId.add(data["result"]["items"][i]["product"]);
              product_Deliver_or_not.add(data["result"]["items"][i]["delivered"].toString());
              productDiscountprice.add(
                  int.parse(data["result"]["items"][i]["dprice"]
                      .toString()
                      .split(".")
                      .first) / int.parse(data["result"]["items"][i]["qty"]));
              productprice.add(data["result"]["items"][i]["price"]);

              // if(data["result"]["items"][i]["discount"]
              //     .toString()
              //     .split(".")
              //     .first != "0") {
              //   debugPrint("this is me2");
              //
              //   productDiscountprice.add(
              //       int.parse(data["result"]["items"][i]["dprice"]
              //           .toString()
              //           .split(".")
              //           .first) / int.parse(data["result"]["items"][i]["qty"]));
              //   productprice.add(data["result"]["items"][i]["price"]);
              //
              // }else{
              //   debugPrint("this is me");
              //   productprice.add(
              //       int.parse(data["result"]["items"][i]["dprice"]
              //           .toString()
              //           .split(".")
              //           .first) / int.parse(data["result"]["items"][i]["qty"]));
              //   productDiscountprice.add(int.parse(data["result"]["items"][i]["price"].toString()
              //       .split(".")
              //       .first));
              //
              // }
           //   ProductVegNonveg.add(data["result"][i]["findicator"]);

              productWeight
                  .add(data["result"]["items"][i]["variants_str"].toString());
              Variant.add(data["result"]["items"][i]["variants"].toString());
              productId.add(data["result"]["items"][i]["id"].toString());
              productOID.add(data["result"]["items"][i]["oid"].toString());
              vendorName.add(data["result"]["items"][i]["vendor_name"].toString());


              productPriceTotal
                  .add(int.parse(productDiscountprice[i].toString().split(".").first));

            //  for (int j = 0; j < data["result"]["items"].length; j++) {
                if (data["result"]["items"][i]["imgs"].length<=0) {
                    debugPrint("this is empty");
                  ProductImage.add("https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png");
                } else {

                  debugPrint("this is Not");
                  ProductImage.add(data["result"]["items"][i]["imgs"][0]
                          ["imgpath"]
                      .toString());
               }


            }




            setState(() {
              for (int i = 0; i < productDiscountprice.length; i++) {
                productTotal = 0;

                  debugPrint("this is product $productPriceTotal");
                  debugPrint("this is product $productprice");
                  debugPrint("this is product $numberOfItems");
                productPriceTotal[i] = (int.parse(
                    productDiscountprice[i].toString().split(".").first) *
                    int.parse(numberOfItems[i].toString().split(".").first));
                  productPriceTotal.forEach((num e) {
                    productTotal += e;
                  });
                  debugPrint(productTotal.toString());

              }


            });
          } else {
            dataLength = 0;
            debugPrint("noo");
          }
        }

        // subList = s;

        setState(() {
          isLoading = false;
        });
      } else {
        debugPrint("Error in the Api");
      }
    }
  }

  removefromcart(context, productId, orderId) async {
    debugPrint(productId + "this is product id to removed");
    debugPrint(orderId);
    var userID;
    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    final dataBody = {
      "userid": userID,
      "id": productId.toString(),
      "oid": orderId.toString(),
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

  emptycart() async {

    var userID;
    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');
    final cartOid = prefs.getString('cartOid');

    final dataBody = {
      "userid": userID,
      "oid": cartOid.toString(),
      //  "password":passwordController.text,
    };
    var response =
        await http.post(Uri.parse(emptyAllCartApi), body: dataBody);
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

  void choiceAction(String choice){
    if(choice == Constants.Empty_Cart){
      emptycart();
    }

  }

void showInSnackBar(_text) {

  _scaffoldKey.currentState!
      .showSnackBar(SnackBar(duration: const Duration(seconds:3),content: Text(_text,style: constantFontStyle(),)));
}

  addtocart(context, productId, variant,quantity) async {


    debugPrint("this is productId $productId");
    debugPrint("this is variant $variant");
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
class Constants{
  static const String Empty_Cart = 'Empty Cart';

  static const List<String> choices = <String>[
    Empty_Cart
  ];

}