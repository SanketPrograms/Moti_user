import 'dart:convert';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:big_basket/Widgets/drawer.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/screens/address/view_address.dart';
import 'package:big_basket/screens/categories_gridview/shop_by_categories.dart';
import 'package:big_basket/screens/homepage/home_data.dart';
import 'package:big_basket/screens/my_account/my_account.dart';
import 'package:big_basket/screens/product_details/product_details_api.dart';
import 'package:big_basket/screens/product_details/product_details_new.dart';
import 'package:big_basket/screens/search/search.dart';
import 'package:big_basket/screens/search/searchnavigation.dart';
import 'package:big_basket/services/fetch_homepage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List categoryName = [];

  List categoryDiscount = [];
  List BannerImageList = [];
  List BannerID = [];
  List categoryId = [];
  List categoryImage = [];
  String? addressName;


  var handleInternet;
  List<String> subImage = [
    "https://i1.wp.com/momobud.sg/wp-content/uploads/2015/01/Picture4-1537x500.png?resize=1090%2C355",
    "https://image.freepik.com/free-vector/hello-summer-tropic-fruits-banner_1268-11173.jpg",
    "https://i1.wp.com/momobud.sg/wp-content/uploads/2015/01/Picture4-1537x500.png?resize=1090%2C355"
  ];
  List<String> subImage1 = [
    "https://image.freepik.com/free-vector/hello-summer-tropic-fruits-banner_1268-11173.jpg",
    "https://i1.wp.com/momobud.sg/wp-content/uploads/2015/01/Picture4-1537x500.png?resize=1090%2C355"
  ];
  @override
  void initState() {
    // TODO: implement initState

    checkConnection();

    // FetchHomePage().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Singleton.handleBack(context);
      },
      child:
      Scaffold(
          drawer: drawer(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(140),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: themeColor,
                  elevation: 0.0,
                  title: addressName == null
                      ? Text(
                          applicationName,
                          //  maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cherrySwash(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        )
                      : Text(
                          addressName.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: constantFontStyle(
                              fontSize: Fontsize, color: Colors.white),
                        ),
                  actions: [
                    addressName != null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewAddress()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                "assets/images/bottom_navigation/location.png",
                                scale: 1.2,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(""),
                    IconButton(
                      icon: Icon(CupertinoIcons.person),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAccountDashboard()));
                      },
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchNavigation()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Card(
                          elevation: elevation_size,
                          child: Container(
                            height: 45,
                            child: Center(
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.black54,
                                      )),
                                  Text(
                                    "Search",
                                    style: constantFontStyle(
                                      fontSize: Fontsize,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: null, icon: Icon(Icons.mic)),
                                ],
                              ),
                            ),
                          ),
                        )

                        // TextField(
                        //   decoration: InputDecoration(
                        //       hintText: 'Search',
                        //       hintStyle:  constantFontStyle(fontSize: Fontsize,),
                        //       prefixIcon: Icon(Icons.search),
                        //       suffixIcon: Icon(Icons.mic),
                        //       border: OutlineInputBorder(
                        //           borderSide: BorderSide.none
                        //       ),
                        //       contentPadding: EdgeInsets.zero,
                        //       filled: true,
                        //       fillColor: Colors.white
                        //   ),
                        // ),
                        ),
                  ),
                ),
              ],
            ),
          ),
          body: isLoading == true
              ? Center(
                  child: Image.asset(
                  "assets/images/loading_page.gif",
                  scale: 3,
                ))
              : handleInternet == "1"
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: SizedBoxSize,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: SlidingImage(BannerImageList),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Container(
                                        child: dynamicGridView(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Container(
                            //   //   height:100,
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(vertical: 30),
                            //     child: SlidingImage(BannerImageList),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: HomeScroll(),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Card(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/no_internet.gif",
                          ),
                          Text(
                            "No Internet",
                            style: constantFontStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Make Sure You are connected To Internet",
                            style: constantFontStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )),
    );
  }

  Widget dynamicGridView() {
    // print("this is findword $findWord");
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("SHOP BY CATEGORY",
                          style: constantFontStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          )),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.white,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.8),
                  itemCount: categoryName.length,
                  //  itemCount: title.length,
                  shrinkWrap: true,
                  //  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(0, 2))
                      ]),
                      child: Material(
                        child: InkWell(
                          splashColor: themeColor,
                          hoverColor: themeColor,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShopByCategories(
                                        BannerImageList: BannerImageList,
                                        BannerID: BannerID,
                                        categoryid: categoryId[index],
                                        categoryName: categoryName[index])));
                          },
                          child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              // elevation: elevation_size,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              // margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  // subtitle: Text(description[index]),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Badge(
                                          position: BadgePosition.topStart(
                                              top: -9, start: -8),
                                          badgeColor: Colors.transparent,
                                          elevation: 100,
                                          showBadge: true,
                                          badgeContent: categoryDiscount[
                                                      index] !=
                                                  "0"
                                              ? Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          50))),
                                                  color: themeColor,
                                                  child: Text(
                                                    " Min ${categoryDiscount[index]}% OFF  ",
                                                    style: constantFontStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ))
                                              : null,
                                          child: Container(
                                              child: ClipRRect(
                                                  borderRadius: new BorderRadius
                                                          .only(
                                                      topRight:
                                                          Radius.circular(10.0),
                                                      topLeft: Radius.circular(
                                                          10.0)),
                                                  child: CachedNetworkImage(
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child: Image.asset(
                                                          "assets/images/image_loader.gif"),
                                                    ),
                                                    imageUrl:
                                                        categoryImage[index],
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.cover,
                                                  ))),
                                        )),
                                  ),

                                  // Expanded(
                                  //     flex: 4,
                                  //     child: Image.network(
                                  //         categoryImage[index],fit: BoxFit.fill,)),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          // border: Border.all(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Center(
                                            child: Text(
                                          categoryName[index],
                                          style: constantFontStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                      )),
                                ],
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(categoriesSublistApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      categoryName.clear();
      categoryImage.clear();
      categoryId.clear();
      categoryDiscount.clear();

      var s = [];

      for (int i = 0; i < data["result"].length; i++) {
        categoryName.add(data["result"][i]["name"]);
        categoryImage.add(data["result"][i]["imgpath"]);
        categoryId.add(data["result"][i]["id"]);
        categoryDiscount
            .add(data["result"][i]["discount"].toString().split(".").first);

        // for (int j = 0;
        // j < jsonResponse["data"][i]["sub_categories"].length;
        // j++) {
        //   s.add(jsonResponse["data"][i]["sub_categories"][j]
        //   ["sub_category_name"]
        //       .toString());
        // }
      }

      // subList = s;

      setState(() {
        addressName = prefs.getString('userAddress');
        isLoading = false;
      });
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
      // setState(() {
      for (int i = 0; i < data["result"].length; i++) {
        BannerImageList.add(data["result"][i]["imgpath"]);
        BannerID.add(data["result"][i]["product"]);
      }
      // });

      //   debugPrint(BannerImageList.toString() + "banner");
    } else {
      debugPrint("Error in the Api");
    }
  }

  Widget SlidingImage(BannerImage) {
    ValueNotifier current = ValueNotifier(0);

    final CarouselController _controller = CarouselController();
    List<int> imageLength = [];

    for (int i = 0; i < BannerImage.length; i++) {
      imageLength.add(i);
    }
    //   debugPrint("this is i $imageLength");
    return Column(
      children: [
        Container(
          // height: 80,
          child: CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9, //7/3

              onPageChanged: (index, reason) {
                // setState(() {
                  current.value = index;
                // });
              },


              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              // reverse: false,

              autoPlay: true,

              // autoPlayInterval: Duration(seconds: 10),
              //autoPlayAnimationDuration: Duration(milliseconds: 100),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              autoPlayAnimationDuration: Duration(seconds: 3),
              scrollDirection: Axis.horizontal,
            ),
            items: imageLength.map((i) {
              return Builder(
                builder: (BuildContext context) {
                 // debugPrint("thisssss isss iiii $i");
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsNew(
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageLength.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child:ValueListenableBuilder(
    valueListenable: current,
    builder: (context, value, child) {
            return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
                : Colors.black)
                .withOpacity(current.value == entry.key ? 0.9 : 0.4)),
            );
            }
              )
            );
          }).toList(),
        )
      ],
    );
  }

  checkConnection() async {
    bool con;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          con = true;
          debugPrint("Connected");
          BannerImageApi();

          getData();
          handleInternet = "1";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        con = false;
        debugPrint("Not Connected");
        isLoading = false;
        handleInternet = "0";
      });
    }
  }
}
