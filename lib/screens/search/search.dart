import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:badges/badges.dart';
import 'package:big_basket/Widgets/drawer.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/main.dart';
import 'package:big_basket/screens/address/view_address.dart';
import 'package:big_basket/screens/product_details/product_details_new.dart';
import 'package:big_basket/screens/search/search_horizontal_cards.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
//Step 3
  _SearchScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = categoryName;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }


  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
//Step 1
  final TextEditingController _filter = TextEditingController();

  // for http requests
  String _searchText = "";
  List<String> recentSearch = [];
  bool searchfieldfocus = false;
  List names = []; // names we get from API
  List cartproductId = [];
  List categoryName = []; // names we get from API
  List filteredNames = []; // names filtered by search text
  Icon _searchIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget _appBarTitle = Text(
    'Search Products',
    style: constantFontStyle(color: Colors.black, fontSize: 10),
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<bool> hideAddToCart = [];
  List<bool> unhideAddToCart = [];
  List<String>? recentSearchData = [];
  String? addressID;

  //step 2.1

//Step 2.2
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(
          Icons.close,
          color: Colors.black,
        );
        this._appBarTitle = TextField(
          style: constantFontStyle(
            color: Colors.black,
          ),
          controller: _filter,
          onTap: () {
            debugPrint("yeeee");
          },
          onEditingComplete: () {
            setState(() {
              //  SaveRecentSearch();
            });
          },
          onSubmitted: (save) {
            setState(() {
              //SaveRecentSearch();
            });
          },
          onChanged: (text) {
            setState(() {
              //  getCartDetails();
              getData(text.toString());

              // debugPrint("this is text1 ${text.toString()}");
              // debugPrint("this is text2 ${_searchText.toString()}");
              // debugPrint("this is text3 ${_filter.text.toString()}");
            });
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              filled: true,
              hintStyle: constantFontStyle(
                color: Colors.black,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: 'Search...'),
        );
      } else {
        this._searchIcon = Icon(
          Icons.search,
          color: Colors.black,
        );
        this._appBarTitle = GestureDetector(
          onTap: () {
            setState(() {
              debugPrint("yeeee");
            });
            _searchPressed();
          },
          child: Text(
            'Search Product',
            style: constantFontStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        );
        filteredNames = categoryName;
        _filter.clear();
      }
    });
  }

  //Step 4
  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
      debugPrint(filteredNames.toString());
    }
    return _filter.text.isEmpty
        ? SingleChildScrollView(
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Recent Search",
                            style: constantFontStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RecentSearchGridview(),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orangeAccent.shade100),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                    ),
                                    onPressed: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories_subCat_List()));
                                    },
                                    child: Text(
                                      "TRENDING NOW",
                                      style: constantFontStyle(
                                          fontSize: Fontsize,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ))),
                          ),
                        ],
                      ),
                      SearchHorizontalCards()
                    ],
                  ),
                ),
              ),
            ),
          )
        : ListView.builder(
            itemCount: categoryName.isEmpty ? 0 : filteredNames.length,
            itemBuilder: (BuildContext context, int index) {
              // if (filteredNames[index]["id"].toString().contains(
              //     cartproductId.join(",").toString())&&cartproductId.isNotEmpty) {
              //
              hideAddToCart.add(true);
              unhideAddToCart.add(true);
              // }
              // else {
              //
              //   hideAddToCart.add(true);
              //   unhideAddToCart.add(false);
              // }

              return GestureDetector(
                onTap: () async{
                  final prefs =
                      await SharedPreferences
                      .getInstance();
                  setState(() {

                    List<String>recentSearch = [];

                    List<String>SaverecentSearch = [];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailsNew(
                              productId: filteredNames[index]["id"],
                            )));
                    if(_filter.text.isNotEmpty) {

                      recentSearch
                          .add(
                          _filter.text);

                      List<String>getrecentSearch =  prefs.getStringList("recentSearch")??[];
                      SaverecentSearch = (getrecentSearch + recentSearch);
                      prefs.setStringList("recentSearch", SaverecentSearch);

                    }
                  });
                  // Navigator.push(
                  //     context,
                  // MaterialPageRoute(
                  //     builder: (context) =>
                  //         ProductDetails(productId: productId)));
                },
                child: Card(
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
                              padding: const EdgeInsets.all(paddingAllTwo),
                              child: Badge(

                                position: BadgePosition.topStart(top: -9, start: -8),
                                badgeColor:Colors.transparent ,
                                elevation: 100,

                                showBadge: true,


                                badgeContent:filteredNames[index]["discount"].toString().split(".").first !="0"?Card(
                                    shape:
                                    RoundedRectangleBorder(           borderRadius: BorderRadius.only(topRight: Radius.circular(0),bottomRight: Radius.circular(50))),

                                    color: themeColor,child: Text(
                                  " Min ${filteredNames[index]["discount"].toString().split(".").first}% OFF  ",
                                  style: constantFontStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )):null,
                               child:
                               Card( shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                //    elevation: elevation_size,
                                child: filteredNames[index]["imgs"].length <= 0
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0)),
                                        child: CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),


                                          placeholder: (context, url) => Center(
                                            child: Image.asset("assets/images/image_loader.gif"),
                                          ),
                                          imageUrl:
                                              "https://www.ncenet.com/wp-content/uploads/2020/04/no-image-png-2.png",
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0)),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Center(
                                            child: Image.asset("assets/images/image_loader.gif"),
                                          ),
                                          imageUrl: filteredNames[index]["imgs"]
                                                  [0]["imgpath"]
                                              .toString(),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        )),
                              )
                              )
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
                                    filteredNames[index]["shop_name"],
                                    style: constantFontStyle(
                                        fontSize: SubTitleFontsize,
                                        color: themeColor,
                                        fontWeight: FontWeight.w400),
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          filteredNames[index]["name"],
                                          style: constantFontStyle(
                                              fontSize: TitleFontsize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // ProductVegNonveg[index]=="2"?  Expanded(child: Card(elevation: 2,child: Icon(Icons.circle,color: Colors.red.shade600,size: 17,))):
                                      // Expanded(child: Card(elevation: 2,child: Icon(Icons.circle,color: Colors.green.shade400,size: 17,))),
                                    ],
                                  ),
                                  // Text(
                                  //   filteredNames[index]["description"],
                                  //   style: constantFontStyle(
                                  //     fontSize: SubTitleFontsize,
                                  //   ),
                                  // ),

                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        filteredNames[index]["opts"][0]["dprice"]
                                            .toString(),
                                        style: constantFontStyle(
                                            fontSize: TitleFontsize,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      filteredNames[index]["opts"][0]
                                                      ["discount"]
                                                  .toString().split(".").first !=
                                              "0"
                                          ? Text(
                                              filteredNames[index]["opts"][0]
                                                      ["price"]
                                                  .toString(),
                                              style: constantFontStyle(
                                                  fontSize: Fontsize,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : SizedBox(
                                              height: 0.0,
                                            )
                                    ],
                                  ),
                                  ///////////////////////////////////////////////////////////////////////////Changes in this line////
                                  // productId[index].toString().contains(cartproductId.join(","))  ?
                                  filteredNames[index]["in_cart"] == "1"
                                      ? Visibility(
                                          visible: unhideAddToCart[index],
                                          //  visible: false,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .orangeAccent
                                                                  .shade200),
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
                                                      "ADDED TO Cart",
                                                      style:
                                                          constantFontStyle(
                                                              fontSize:
                                                                  Fontsize,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Visibility(
                                          //  visible: true,
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
                                                              .all(Colors
                                                                  .orangeAccent
                                                                  .shade200),
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.green),
                                                    ),
                                                    onPressed: () async {
                                                      final prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      setState(() {
                                                        // List<String>recentSearch = [];
                                                        // List<String>?getrecentSearch = [];
                                                        // List<String>?SaverecentSearch = [];
                                                        //
                                                        //
                                                        //    if(_filter.text.isNotEmpty) {
                                                        //      recentSearch.add(
                                                        //          _filter.text);
                                                        //      getrecentSearch =  prefs.getStringList("recentSearch");
                                                        //      SaverecentSearch = (recentSearch + getrecentSearch!);
                                                        //      prefs.setStringList("recentSearch", SaverecentSearch);
                                                        //s
                                                        //    }

                                                        hideAddToCart[index] =
                                                            false;
                                                        unhideAddToCart[index] =
                                                            true;
                                                      });

                                                      addtocart(
                                                          context,
                                                          filteredNames[index]
                                                              ["id"],
                                                          filteredNames[index]
                                                                  ["opts"][0]
                                                              ["variants"]);
                                                    },
                                                    child: Text(
                                                      "ADD",
                                                      style:
                                                          constantFontStyle(
                                                              fontSize:
                                                                  Fontsize,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
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
              );
            },
          );
  }

  //STep6
  PreferredSizeWidget _buildBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(140),
      child: Column(
        children: [
          AppBar(
            backgroundColor: themeColor,
            centerTitle: true,

            title: GestureDetector(
              onTap: () {
                setState(() {
                  _searchPressed();
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  addressID != null
                      ? Container(
                          width: 200,
                          child: Center(
                            child: Text(
                              addressID.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: constantFontStyle(
                                  fontSize: Fontsize, color: Colors.white),
                            ),
                          ),
                        )
                      : Container(
                          child: Text(
                            applicationName,
                            //  maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cherrySwash(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                  addressID != null
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
                      : Text("")
                ],
              ),
            ),

            // GestureDetector(onTap: (){setState(() {
            //   _searchPressed();
            // });},child: _appBarTitle),

            // leading: new IconButton(
            //   icon: _searchIcon,
            //   color: Colors.white,
            //   onPressed: _searchPressed,
            // ),
          ),
          Container(
              decoration: const BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Card(
                    elevation: elevation_size,
                    child: TextField(
                      style: constantFontStyle(
                        color: Colors.black,
                      ),
                      autofocus: searchfieldfocus,
                      controller: _filter,
                      onTap: () {
                        debugPrint("yeeee");
                      },
                      onEditingComplete: () {
                        setState(() {
                          //  SaveRecentSearch();
                        });
                      },
                      onSubmitted: (save) {
                        setState(() {
                          //SaveRecentSearch();
                        });
                      },
                      onChanged: (text) {
                        setState(() {
                          //  getCartDetails();
                          getData(text.toString());
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          suffixIcon:
                          AvatarGlow(
                            animate: _isListening,
                            glowColor: Theme.of(context).primaryColor,
                            endRadius: 15.0,

                            duration: const Duration(milliseconds: 2000),
                            repeatPauseDuration: const Duration(milliseconds: 100),
                            repeat: true,
                            showTwoGlows: true,
                            child: IconButton(
                              onPressed: _listen,
                              icon: Icon(_isListening ? Icons.mic : Icons.mic),
                            ),
                          ),
                          hintStyle: constantFontStyle(
                            color: Colors.black,
                            fontSize: 12
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Search'),
                    ),
                  )))
        ],
      ),
    );
  }

  @override
  void initState() {
    _speech = stt.SpeechToText();

    getCartDetails();
    //getRecentSearchData();
    // _getNames();
    // getData("a");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return Singleton.handleBack(context);

      },
      child: Scaffold(
        drawer: drawer(),
        key: _scaffoldKey,

        appBar: _buildBar(context),
        body: Container(
          child: _buildList(),
        ),
        resizeToAvoidBottomInset: false,
//      floatingActionButton: FloatingActionButton(
//        onPressed: _postName,
//        child: Icon(Icons.add),
//      ),
      ),
    );
  }

  // void _getNames() async {
  //   final response =
  //   await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  //   print(response.body);
  //   var body = [];
  //   body = jsonDecode(response.body);
  //   List tempList = [];
  //   for (int i = 0; i < body.length; i++) {
  //     tempList.add(body[i]);
  //   }
  //   setState(() {
  //     names = tempList;
  //     filteredNames = names;
  //
  //     debugPrint("this is filter $names");
  //   });
  // }

  Widget RecentSearchGridview() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4,
            mainAxisSpacing: 3,
            childAspectRatio: 2),
        itemCount:recentSearchData==null?0: recentSearchData!.length<=9?recentSearchData!.length:9,
        //  itemCount: title.length,s
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.grey)))),
                    onPressed: null,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset(
                            "assets/images/time_left.png",
                            scale: 1.9,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Text(
                            recentSearchData![index],

overflow: TextOverflow.ellipsis,
                            style: constantFontStyle(
                                fontWeight: FontWeight.w500, color: Colors.black54),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  getData(searchText) async {
    // getCartDetails();
    var userID;
    final prefs = await SharedPreferences.getInstance();
    recentSearchData = prefs.getStringList("recentSearch");
    debugPrint("this is recent search items $recentSearchData");
    userID = prefs.getString('userId');

    // debugPrint("this is userid $userID");

    var response =
        await http.get(Uri.parse("$productApi?search=1&terms=$searchText"));
    //var response = await http.get(Uri.parse("$product?userid=$userID&vendor=5&subcategory=3&category=3}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      setState(() {});

      categoryName.clear();

      var s = [];

      for (int i = 0; i < data["result"].length; i++) {
        categoryName.add(data["result"][i]);
      }
      // debugPrint("this is result ${data[i]}");
      filteredNames = categoryName;
    }
  }

  getCartDetails() async {
    var userID;
    final prefs = await SharedPreferences.getInstance();
    addressID = prefs.getString('userAddress')!;

    userID = prefs.getString('userId');
    var cartOid = prefs.getString('cartOid');

    // debugPrint("this is userid $userID");
    //  debugPrint("this is cartOid $cartOid");

    var response =
        await http.get(Uri.parse("$viewCart?userid=$userID&oid=$cartOid"));
    //var response = await http.get(Uri.parse("$product?userid=$userID&vendor=5&subcategory=3&category=3}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      debugPrint("this is data${data.toString()}");

      cartproductId.clear();

      if (data["result"]["items"].length != 0) {
        for (int i = 0; i < data["result"]["items"].length; i++) {
          cartproductId.add(data["result"]["items"][i]["product"].toString());
        }

        debugPrint("this is cart ${cartproductId.join(",").toString()}");
        setState(() {
          //  isLoading = false;
        });
      } else {
        debugPrint("noo");
      }

      // subList = s;

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
    debugPrint("added to cart" + body.toString());
    // debugPrint(body["status"].toString());
    if (response.statusCode == 200) {
      if (body["status"] == "200") {
        setState(() {
          showInSnackBar();
          cartApi();
          prefs.setString('cartOid', body["result"]["oid"]);
        });
      } else {
        Singleton.showmsg(context, "Message", body["message"]);
      }

      debugPrint(body.toString());
    } else {
      Singleton.showmsg(context, "Message", body["error"]);
    }
  }
// SaveRecentSearch() async{
//   final prefs = await SharedPreferences.getInstance();
//   recentSearch  = prefs.getStringList('recentSearch')!;
//
//   List<String> recentSearchSave = [];
//   if(_filter.text.length>3) {
//     recentSearchSave.add(recentSearch.toString() + _filter.text);
//     debugPrint("saved");
//   }
//
//
//   prefs.setStringList('recentSearch',recentSearchSave + recentSearch);
// }
//
// getRecentSearchData() async{
//
//   final prefs = await SharedPreferences.getInstance();
//   var recentSearch  = prefs.getStringList('recentSearch')!;
//   debugPrint("this is recent search $recentSearch");
//
// }

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
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          debugPrint('onStatus: $val');
          setState(() {
            _filter.text = _text;
            _searchText = _filter.text;
            getData(_text.toString());

            searchfieldfocus = true;
          });
          if(val=="notListening"){
            debugPrint("USer is not tell");
            _speech.stop();
           setState(() {
             _filter.text = _text;
             _searchText = _filter.text;
             getData(_text.toString());

             searchfieldfocus = true;

            });
          }
        },
        onError: (val) => debugPrint('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 80) {
              _confidence = val.confidence;
              _speech.stop();
            }

            _filter.text = _text;
            _searchText = _filter.text;
            getData(_text.toString());

            searchfieldfocus = true;
          }),
        );
      }
    } else {
      setState(() {

      _isListening = false;
      _speech.stop();
      debugPrint("USer has stopped listening");
      getData(_text.toString());

      _filter.text = _text;
      _searchText = _filter.text;

      searchfieldfocus = true;
      });

    }
  }
}
