import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/screens/homepage/home_modalclass.dart';
import 'package:big_basket/screens/product_details/product_details_new.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class HomeScroll extends StatefulWidget {
  HomeScroll({Key? key}) : super(key: key);

  @override
  State<HomeScroll> createState() => _HomeScrollState();
}

class _HomeScrollState extends State<HomeScroll> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> Carditems = ["All", "Baby Care", "Beauty & Hygiene"];
  List<String> ProductName = [];
  List<String> BannerImageList = [];
  List<String> BannerID = [];
  List<String> ProductImage = [];
  List<String> productId = [];
  List<String> AddedToCart = [];
  List<String> strVariants = [];
  List<String> ProductVariant = [];
  List<String> discountprice = [];
  List<String> price = [];
  List<String> ProductDiscount = [];
  List<bool> unhideAddToCart = [];
  List<bool> hideAddToCart = [];
  var homeDataModalClass;
  List<String> CategoryNames = [];
  bool isLoading = true;
  var userID;
  List<bool> addBtnLoader = [];

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  void didUpdateWidget(covariant HomeScroll oldWidget) {
    // TODO: implement didUpdateWidget
    getData();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Image.asset(
            "assets/images/loading_page.gif",
            scale: 3,
          ))
        : Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryListView(),
              ],
            ),
          );
  }

  Widget CategoryListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: CategoryNames.length,
        itemBuilder: (context, index) {
          unhideAddToCart.add(false);
          hideAddToCart.add(true);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlidingImage(index),
              SizedBox(
                height: 15,
              ),
              Text(
                CategoryNames[index],
                style: constantFontStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 300,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child:
                              Center(child: dynamicHorizontalListview(index))),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget dynamicHorizontalListview(i) {

    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: homeDataModalClass.result![i].products.length,
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
                  SizedBox(
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
                                        position: BadgePosition.topStart(
                                            top: -9, start: -8),
                                        badgeColor: Colors.transparent,
                                        elevation: 100,
                                        showBadge: true,
                                        badgeContent: ProductDiscount[index] !=
                                                "0"
                                            ? Card(
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    50))),
                                                color: themeColor,
                                                child: Text(
                                                  " Min ${ProductDiscount[index]}% OFF  ",
                                                  style: constantFontStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ))
                                            : null,
                                        child: Container(
                                          // width: 150,
                                          // height: 90,
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10.0),
                                                      topLeft: Radius.circular(
                                                          10.0)),
                                              child: CachedNetworkImage(
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.network(
                                                        "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: Image.asset(
                                                      "assets/images/image_loader.gif"),
                                                ),
                                                imageUrl: homeDataModalClass
                                                        .result![i]
                                                        .products[index]
                                                        .imgs[0]
                                                        .imgpath ??
                                                    "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg",
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
                                        decoration: const BoxDecoration(
                                          //   color: Colors.black12,
                                          // border: Border.all(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Text(
                                          homeDataModalClass
                                              .result![i].products[index].name,
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
                                  child: Container(
                                    height: 15,
                                    decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
               Colors.grey.shade200,
               Colors.grey.shade50,
            ],
            )
                                    ),
                                    child: Text(
                                      " ${homeDataModalClass.result![i].products[index].opts[0].variantStr}",
                                      style: constantFontStyle(
                                          fontSize: SubTitleFontsize,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProductDiscount[index] != "0"
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "₹ ${homeDataModalClass.result![i].products[index].opts[0].dprice}",
                                          style: GoogleFonts.roboto(
                                              fontSize: Fontsize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "₹ ${homeDataModalClass.result![i].products[index].opts[0].price}",
                                          style: GoogleFonts.roboto(
                                              fontSize: Fontsize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                ProductDiscount[index] != "0"
                                    ? Text(
                                        "₹" +
                                            homeDataModalClass.result![i]
                                                .products[index].opts[0].dprice,
                                        style: GoogleFonts.roboto(
                                            fontSize: 10,
                                            color: Colors.grey.shade400,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    : Text(""),
                                homeDataModalClass.result[i].products[index]
                                            .findicator ==
                                        "2"
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                                side: new BorderSide(
                                                    color: Colors.redAccent,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
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
                                                    BorderRadius.circular(0.0)),
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
                                      )
                              ],
                            ),
                            const Spacer(),

                            homeDataModalClass
                                        .result[i].products[index].inCartQty !="0"&&userID!=null ?

                        Visibility(
                                    visible: true,
                                    child: Container(
                                      height:30,
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    addBtnLoader[index] = true;
                                                  });
                                                  addtocart(
                                                      context,
                                                      productId[index],
                                                      homeDataModalClass
                                                          .result[i]
                                                          .products[index]
                                                          .opts[0]
                                                          .variants,int.parse(homeDataModalClass
                                                      .result[i].products[index].inCartQty) - 1,index);
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.red.shade600,
                                                  size: 16,
                                                )),
                                          ),
                                          Expanded(
                                            child:addBtnLoader[index]?Center(child:  SizedBox(height: 25,width:25,child: CircularProgressIndicator(color: themeColor,strokeWidth: 1.2,)),
                                            ): Container(

                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Colors.red),
                                              child:       Center(child:Text(
                                                homeDataModalClass.result[i].products[index].inCartQty,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                              )
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  // setState(() {
                                                  setState(() {
                                                    addBtnLoader[index] = true;
                                                  });

                                                    addtocart(
                                                        context,
                                                        productId[index],
                                                        homeDataModalClass
                                                            .result[i]
                                                            .products[index]
                                                            .opts[0]
                                                            .variants,int.parse(homeDataModalClass
                                                        .result[i].products[index].inCartQty)+1,index);
                                                // });
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.red,
                                                  size: 16,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : addBtnLoader[index]?Center(child: SizedBox(
height: 25,width: 25,                                  child: CircularProgressIndicator(color: themeColor,strokeWidth: 1.2,),
                                ),):Visibility(
                                    visible:true,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
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
                                                    addBtnLoader[index] = true;
                                                  });


                                                    addtocart(
                                                        context,
                                                        productId[index],
                                                        homeDataModalClass
                                                            .result[i]
                                                            .products[index]
                                                            .opts[0]
                                                            .variants,"1",index);

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
    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    debugPrint("this is userid $userID");

    var response = await http.get(Uri.parse("$homeDataApi?userid=$userID"));
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
        CategoryNames.clear();
        addBtnLoader.clear();

        for (int j = 0; j < data["result"].length; j++) {
          CategoryNames.add(data["result"][j]["name"]);
          for (int i = 0; i < data["result"][0]["products"].length; i++) {
            ProductName.add(data["result"][0]["products"][i]["name"]);
            addBtnLoader.add(false);

            productId.add(data["result"][0]["products"][i]["id"]);
            ProductDiscount.add(data["result"][0]["products"][i]["discount"]
                .toString()
                .split(".")
                .first);

            AddedToCart.add(data["result"][0]["products"][i]["in_cart"]);

            if (data["result"][0]["products"][i]["imgs"].length <= 0) {
              ProductImage.add(
                  "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png");
            } else {
              // for (int j = 0; j < data["result"][i]["imgs"].length; j++) {
              ProductImage.add(
                  data["result"][0]["products"][i]["imgs"][0]["imgpath"]);

              //  }
            }
            for (int j = 0;
                j < data["result"][0]["products"][i]["opts"].length;
                j++) {
              price.add(data["result"][0]["products"][i]["opts"][j]["price"]
                  .toString());
              discountprice.add(data["result"][0]["products"][i]["opts"][j]
                      ["dprice"]
                  .toString());
              ProductVariant.add(data["result"][0]["products"][i]["opts"][j]
                      ["variants"]
                  .toString());
              strVariants.add(data["result"][0]["products"][i]["opts"][j]
                      ["variant_str"]
                  .toString()
                  .split(":")
                  .last);
            }
          }
        }
            setState(() {
              homeDataModalClass = homeDataModalClassFromJson(response.body);





            });

        //  print("this is image $ProductImage");

        // subList = s;

        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }

  addtocart(context, productId, variant,quantity,index) async {
    var userID;

    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    if(userID == null){
      Singleton.showInSnackBar(context, "Please Login Before Adding");
      setState(() {

        addBtnLoader[index] = false;
      });

    }else {
      final dataBody = {
        "userid": userID,
        "product": productId.toString(),
        "variants": variant.toString(),
        "qty": quantity.toString(),
        //  "password":passwordController.text,
      };
      var response = await http.post(Uri.parse(addToCart), body: dataBody);
      var body = jsonDecode(response.body);

      debugPrint(body.toString() + "this is data");
      if (response.statusCode == 200) {
        if (body["status"] == "200") {
          prefs.setString('cartOid', body["result"]["oid"].toString());
          //   showInSnackBar();
          //    Singleton.showmsg(context, "Message", body["message"]);
          getData();
          cartApi();
        }else {
          Singleton.showmsg(context, "Message", body["message"]);
        }

      } else {
        Singleton.showmsg(context, "Message", body["error"]);
      }


      debugPrint(body.toString());

  }
  }

  Widget SlidingImage(index) {
    List<int> imageLength = [];
    for (int i = 0; i < homeDataModalClass.result[index].imgs.length; i++) {
      imageLength.add(i);
    }

    if (homeDataModalClass.result[index].imgs.length == 0) {
      debugPrint("ccccccccccccccccccccccccccccccc");
    }
    debugPrint("this is i $imageLength");
    return homeDataModalClass.result[index].imgs.length == 0
        ? Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 2.0),
            decoration: BoxDecoration(),
            child: Container(
              // height: 100,
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(
                      "http://moticonf.adminapp.tech/upload/moti-confectionery-pvt.-ltd.-2.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        : Container(
            // height: 80,
            child: CarouselSlider(
              options: CarouselOptions(
                // height: 200,
                aspectRatio: 8 / 3,

                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                // reverse: false,
                autoPlay: true,
                // autoPlayInterval: Duration(seconds: 10),
                //autoPlayAnimationDuration: Duration(milliseconds: 100),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                autoPlayAnimationDuration: const Duration(seconds: 3),
                scrollDirection: Axis.horizontal,
              ),
              items: imageLength.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      //
                      // onTap: (){
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>
                      //               ProductDetailsNew(
                      //                 productId: BannerID[i],
                      //               )));
                      //
                      // },
                      // //  height:90,

                      child: Container(
                        // height: 100,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(),
                        child: Container(
                          // height: 100,
                          margin: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(homeDataModalClass
                                  .result[index].imgs[i].imgpath),
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
