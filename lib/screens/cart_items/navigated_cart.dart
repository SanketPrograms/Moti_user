// import 'dart:convert';
//
// import 'package:badges/badges.dart';
// import 'package:big_basket/Widgets/drawer.dart';
// import 'package:big_basket/constants/apis.dart';
// import 'package:big_basket/constants/constant.dart';
// import 'package:big_basket/constants/singleton.dart';
// import 'package:big_basket/main.dart';
// import 'package:big_basket/model_class/cart_model_class.dart';
// import 'package:big_basket/screens/address/view_address.dart';
// import 'package:big_basket/screens/cart_items/before_checkout_product.dart';
// import 'package:big_basket/screens/delivery/delivery_option.dart';
// import 'package:big_basket/screens/search/search_horizontal_cards.dart';
// import 'package:big_basket/screens/search/searchnavigation.dart';
// import 'package:big_basket/screens/user_login/login_sliding_image.dart';
// import 'package:big_basket/screens/user_login/user_login.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class NavigatedCartItem extends StatefulWidget {
//   final NavigateFlag;
//   NavigatedCartItem({Key? key, this.NavigateFlag}) : super(key: key);
//
//   @override
//   State<NavigatedCartItem> createState() => _NavigatedCartItemState();
// }
//
// class _NavigatedCartItemState extends State<NavigatedCartItem> {
//   var Cart_products;
//   var dataLength;
//   List<int> productPriceTotal = [];
//   List numberOfItems = [];
//   List ProductImage = [];
//   List productname = [];
//   String? addressID;
//
//   List productprice = [];
//   List productWeight = [];
//   List productId = [];
//   List productOID = [];
//   List productDiscount = [];
//   List ProductVegNonveg = [];
//   bool isLoading = true;
//   num productTotal = 0;
//
//   @override
//   void initState() {
//     getData();
//
//     super.initState();
//
//     //  addItems();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading == true
//         ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
//         : Scaffold(
//       backgroundColor:dataLength == 0
//           ? Colors.black87:Colors.white,
//
//
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SearchNavigation()));
//                 },
//                 icon: const Icon(Icons.search)),
//           ),
//         ],
//         backgroundColor: themeColor,
//         title: Text(
//           "Review Basket",
//           style: constantFontStyle(
//             fontSize: 14,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       floatingActionButtonLocation:
//       FloatingActionButtonLocation.centerFloat,
//       bottomNavigationBar: productname.isEmpty
//           ? const Text("")
//           : Row(
//         children: [
//           Expanded(
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.black),
//                   onPressed: () {},
//                   child: Text(
//                     // "Total: ₹${ productPriceTotal.toString()}",
//                     "Total: ₹$productTotal",
//                     style: constantFontStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ))),
//           Expanded(
//             child: ElevatedButton(
//                 style:
//                 ElevatedButton.styleFrom(primary: Colors.red),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => DeliveryOption(
//                               productPriceTotal: productTotal)));
//                 },
//                 child: Text("Proceed To Pay",
//                     style: constantFontStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold))),
//           ),
//         ],
//       ),
//       body: dataLength == 0
//           ? SingleChildScrollView(
//         child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 50,),
//
//                 Image.asset(
//                   "assets/images/show_empty_cart.gif",
//                   fit: BoxFit.fill,
//
//
//
//                   height: MediaQuery.of(context).size.height / 3,
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 5),
//                   child: Text("Your basket is empty",style: constantFontStyle(
//                       fontSize: 14,
//                       color: themeColor,
//                       fontWeight: FontWeight.bold
//                   ),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 5
//                   ),
//                   child: Text("Don't Worry We Have Best Offers For You!",style: constantFontStyle(
//                       fontSize: 12,
//                       color: themeColor,
//                       fontWeight: FontWeight.w500
//                   ),),
//                 ),
//                 SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         color: Colors.transparent,
//                         child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 30, vertical: 14.0),
//                             child: ElevatedButton(
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                   MaterialStateProperty.all(
//                                       themeColor),
//                                   foregroundColor:
//                                   MaterialStateProperty.all(
//                                       Colors.green),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               MyApp()));
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(4.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       const Icon(
//                                         Icons.add_shopping_cart,
//                                         color: Colors.white,
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         "START SHOPPING",
//                                         style: constantFontStyle(
//                                             fontSize: Fontsize,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ))),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             )),
//       )
//           : SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 addressID != null?    GestureDetector(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAddress()));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(
//                       "assets/images/bottom_navigation/location.png",
//                       scale: 1.5,
//                       color: Colors.black,
//                     ),
//
//                   ),
//                 ):Text(""),
//                 addressID != null
//                     ? Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Center(
//                         child: Text(
//                           addressID.toString(),
//                           // maxLines: 2,
//                           //overflow: TextOverflow.ellipsis,
//                           style: constantFontStyle(
//                               fontSize: Fontsize,
//                               color: Colors.black),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 )
//                     :  Center(
//                   child: Text(
//                     applicationName,
//                     // maxLines: 2,
//                     //overflow: TextOverflow.ellipsis,
//                     style: constantFontStyle(
//                         fontSize: Fontsize,
//                         color: Colors.black),
//                   ),
//                 ),
//
//               ],
//             ),
//             Container(
//               color: Colors.blueGrey.shade100,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(paddingAll),
//                     child: Text(
//                       " Total ",
//                       style: constantFontStyle(
//                         fontSize: SubTitleFontsize,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(paddingAll),
//                     child: Text(
//                       " ${productname.length.toString()} items",
//                       style: constantFontStyle(
//                         fontSize: SubTitleFontsize,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             CartItemLists(),
//             BeforeCheckOutProduct(),
//             SizedBox(
//               height: 10,
//             )
//
//             // Container(
//             //     width:double.infinity,
//             //     height:200,
//             //     color: Colors.blueGrey.shade200,
//             //     child: Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //       children: [
//             //         Expanded(child: Center(child: dynamicHorizontalListview())),
//             //       ],
//             //     )),
//             //
//             // SizedBox(height: 100,),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget CartItemLists() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       itemCount: productname.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             // Navigator.push(context,
//             //     MaterialPageRoute(builder: (context) => ProductDetails(productId:productId)));
//           },
//
//           //    height: MediaQuery.of(context).size.height,
//           child:
//
//           //   elevation: elevation_size,
//           //      shape: RoundedRectangleBorder(
//           //        borderRadius: BorderRadius.circular(100.0),
//           //      ),
//           Column(
//             children: [
//               Container(
//                 //   decoration: const BoxDecoration(color: Colors.white),
//                 //  alignment: Alignment.center,
//                   child: Row(
//                     children: [
//                       // subtitle: Text(description[index]),
//                       Expanded(
//                         flex: 1,
//                         child: Center(
//                           child: Padding(
//                               padding: const EdgeInsets.all(0),
//                               child: Badge(
//                                 position:
//                                 BadgePosition.topStart(top: -6, start: -6),
//                                 badgeColor: Colors.transparent,
//                                 elevation: 100,
//                                 showBadge: true,
//                                 badgeContent: productDiscount[index] != "0"
//                                     ? Column(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.start,
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   children: [
//                                     Card(
//                                         shape: const RoundedRectangleBorder(
//                                             borderRadius:
//                                             BorderRadius.only(
//                                                 topRight:
//                                                 Radius.circular(
//                                                     0),
//                                                 bottomRight:
//                                                 Radius.circular(
//                                                     50))),
//                                         color: themeColor,
//                                         child: Padding(
//                                           padding:
//                                           const EdgeInsets.all(2.0),
//                                           child: Text(
//                                             " Min ${productDiscount[index]}% OFF  ",
//                                             style: constantFontStyle(
//                                                 fontSize: 10,
//                                                 fontWeight:
//                                                 FontWeight.bold,
//                                                 color: Colors.white),
//                                           ),
//                                         )),
//                                     const SizedBox(
//                                       height: 85,
//                                     ),
//
//                                   ],
//                                 )
//                                     : null,
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                   ),
//                                   elevation: 2,
//                                   child: CachedNetworkImage(
//                                     errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
//
//                                     placeholder: (context, url) => Center(
//                                       child: Image.asset("assets/images/image_loader.gif"),
//                                     ),
//                                     imageUrl: ProductImage[index],
//                                     width:
//                                     MediaQuery.of(context).size.width / 2.5,
//                                     height:
//                                     MediaQuery.of(context).size.width / 2.5,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               )),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Moti Confectionary",
//                                 style: constantFontStyle(
//                                     fontSize: SubTitleFontsize,
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                               Text(
//                                 productname[index],
//                                 style: constantFontStyle(
//                                     fontSize: TitleFontsize,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 productWeight[index]
//                                     .toString()
//                                     .split(":")
//                                     .last,
//                                 style: constantFontStyle(
//                                   fontSize: SubTitleFontsize,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 "₹"+productDiscount[index],
//                                 style: constantFontStyle(
//                                     fontSize: 10,
//                                     color: Colors.grey.shade400,
//                                     decoration: TextDecoration.lineThrough),
//                               ),
//                               // InkWell(
//                               //   onTap: () {
//                               //
//                               //   },
//                               //   child: Padding(
//                               //     padding: const EdgeInsets.symmetric(
//                               //         vertical: 0.1, horizontal: 4),
//                               //     child: Row(
//                               //       mainAxisAlignment:
//                               //       MainAxisAlignment.spaceBetween,
//                               //       children: [
//                               //         Text(
//                               //           productWeight[index].toString().split(":").last,
//                               //           style: constantFontStyle(
//                               //             fontSize: SubTitleFontsize,
//                               //           ),
//                               //         ),
//                               //         // Text(
//                               //         //   "Select Quantity",
//                               //         //   style: constantFontStyle(
//                               //         //       fontSize: Fontsize,
//                               //         //       color: Colors.cyan,
//                               //         //       fontWeight: FontWeight.bold),
//                               //         // ),
//                               //       ],
//                               //     ),
//                               //   ),
//                               // ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Expanded(
//
//                                     child: Text(
//                                       "₹" + productprice[index].toString().split(".").first,
//                                       style: constantFontStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//
//
//                                   /////To show the discount price unhide this
//
//                                   //           productDiscount[index]=="0"? Text(
//                                   //                       "",
//                                   //                       style: constantFontStyle(
//                                   //                           fontSize: Fontsize, color: Colors.grey),
//                                   //                     ): Text(productDiscount[index]
//                                   //   ,
//                                   //   style: constantFontStyle(
//                                   //       fontSize: Fontsize, color: Colors.grey),
//                                   // ),
//                                   Expanded(flex: 4,child: _shoppingItem(index))
//
//                                 ],
//                               ),
//                               SizedBox(height:20,)
//
//                             ],
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   )),
//               Divider(thickness: 2,)
//             ],
//           ),
//
//
//         );
//       },
//     );
//   }
//
//   Widget _shoppingItem(int itemIndex) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           // width: 200,
//           height: 35,
//           child: Padding(
//             padding: const EdgeInsets.all(2.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 // Image.asset("assets/flutter.png", width: 100),
//                 numberOfItems[itemIndex] == 1
//                     ? _deleteButton(itemIndex)
//                     : _decrementButton(itemIndex),
//                 Text(
//                   '${numberOfItems[itemIndex]}',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//                 _incrementButton(itemIndex),
//               ],
//             ),
//           ),
//
//         ),
//       ],
//     );
//   }
//
//   Widget _incrementButton(int index) {
//     return FloatingActionButton(
//       child: Icon(Icons.add, color: Colors.black87),
//       backgroundColor: Colors.white,
//       onPressed: () {
//         setState(() {
//           productTotal = 0;
//           numberOfItems[index]++;
//
//           // productPriceTotal.add(int.parse(productprice[index]
//           //     .toString()
//           //     .split(".")
//           //     .first));
//           productPriceTotal[index] =
//           (int.parse(productprice[index].toString().split(".").first) *
//               int.parse(numberOfItems[index].toString().split(".").first));
//
//           productPriceTotal.forEach((num e) {
//             productTotal += e;
//           });
//           debugPrint(productTotal.toString());
//         });
//       },
//     );
//   }
//
//   Widget _decrementButton(int index) {
//     return FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             productTotal = 0;
//             numberOfItems[index]--;
//
//             productPriceTotal[index] = (int.parse(
//                 productprice[index].toString().split(".").first) *
//                 int.parse(numberOfItems[index].toString().split(".").first));
//             debugPrint("this is product $productPriceTotal");
//             debugPrint("this is product $productprice");
//             debugPrint("this is product $numberOfItems");
//
//             productPriceTotal.forEach((num e) {
//               productTotal += e;
//             });
//             debugPrint(productTotal.toString());
//           });
//         },
//         // child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
//         child: Icon(
//           Icons.remove,
//           color: Colors.black,
//         ),
//         backgroundColor: Colors.white);
//   }
//
//   Widget _deleteButton(int index) {
//     return FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             productPriceTotal.clear();
//             // numberOfItems[index]--;
//             removefromcart(context, productId[index], productOID[index]);
//           });
//         },
//         // child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
//         child: Icon(
//           Icons.delete_outline,
//           color: Colors.red,
//         ),
//         backgroundColor: Colors.white);
//   }
//
//   getData() async {
//     var userID;
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//
//     });
//     addressID = prefs.getString('userAddress');
//
//     userID = prefs.getString('userId');
//     final cartOid = prefs.getString('cartOid');
//
//     if (userID == null) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Login_Sliding_image()));
//     } else {
//       debugPrint("this is userid ${cartOid == null}");
//       debugPrint("this is cartOid $cartOid");
//
//       var response =
//       await http.get(Uri.parse("$viewCart?userid=$userID&oid=$cartOid"));
//       //var response = await http.get(Uri.parse("$product?userid=$userID&vendor=5&subcategory=3&category=3}"));
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//
//         debugPrint("this is data${data.toString()}");
//
//         productname.clear();
//         productprice.clear();
//         productWeight.clear();
//         productOID.clear();
//         productId.clear();
//         ProductImage.clear();
//         ProductVegNonveg.clear();
//         productDiscount.clear();
//
//         if (data["message"] == "Order Not Found" || cartOid == null||data["result"]["items"].length<=0) {
//           debugPrint("noo");
//           setState(() {
//             dataLength = 0;
//
//             isLoading = false;
//           });
//         } else {
//           String _tmpList = data["result"]["items"].length.toString();
//           itemsNotifier.value = _tmpList;
//
//           debugPrint("this is cart item$_tmpList");
//           prefs.setString('cartLength',_tmpList);
//           if (data["result"]["items"].length != null ||
//               data["result"]["items"].length != 0) {
//             for (int i = 0; i < data["result"]["items"].length; i++) {
//               productname.add(data["result"]["items"][i]["pname"].toString());
//               productprice.add(data["result"]["items"][i]["price"].toString());
//               //   ProductVegNonveg.add(data["result"][i]["findicator"]);
//
//               productWeight
//                   .add(data["result"]["items"][i]["variants"].toString());
//               productId.add(data["result"]["items"][i]["id"].toString());
//               productOID.add(data["result"]["items"][i]["oid"].toString());
//               productDiscount.add(data["result"]["items"][i]["discount"]
//                   .toString()
//                   .split(".")
//                   .first);
//
//               productPriceTotal
//                   .add(int.parse(productprice[i].toString().split(".").first));
//
//               //  for (int j = 0; j < data["result"]["items"].length; j++) {
//               if (data["result"]["items"][i]["imgs"].length<=0) {
//                 debugPrint("this is empty");
//                 ProductImage.add("https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png");
//               } else {
//
//                 debugPrint("this is Not");
//                 ProductImage.add(data["result"]["items"][i]["imgs"][0]
//                 ["imgpath"]
//                     .toString());
//               }
//
//             }
//
//
//
//
//             debugPrint("noo $ProductImage");
//             numberOfItems.clear();
//             setState(() {
//               for (int i = 0; i < productprice.length; i++) {
//                 numberOfItems.add(1);
//                 productTotal = 0;
//
//                 debugPrint("this is product $productPriceTotal");
//                 debugPrint("this is product $productprice");
//                 debugPrint("this is product $numberOfItems");
//                 productPriceTotal[i] = (int.parse(
//                     productprice[i].toString().split(".").first) *
//                     int.parse(numberOfItems[i].toString().split(".").first));
//                 productPriceTotal.forEach((num e) {
//                   productTotal += e;
//                 });
//                 debugPrint(productTotal.toString());
//
//               }
//
//
//             });
//           } else {
//             dataLength = 0;
//             debugPrint("noo");
//           }
//         }
//
//         // subList = s;
//
//         setState(() {
//           isLoading = false;
//         });
//       } else {
//         debugPrint("Error in the Api");
//       }
//     }
//   }
//
//   removefromcart(context, productId, orderId) async {
//     debugPrint(productId);
//     debugPrint(orderId);
//     var userID;
//     final prefs = await SharedPreferences.getInstance();
//
//     userID = prefs.getString('userId');
//
//     final dataBody = {
//       "userid": userID,
//       "id": productId.toString(),
//       "oid": orderId.toString(),
//       //  "password":passwordController.text,
//     };
//     var response =
//     await http.post(Uri.parse(removeFromCartApi), body: dataBody);
//     var body = jsonDecode(response.body);
//     debugPrint(body.toString());
//     debugPrint(body["status"].toString());
//     if (response.statusCode == 200) {
//       setState(() {});
//       if (body["status"] == "200") {
//         setState(() {
//           getData();
//           // Singleton.showmsg(context, "Message", body["result"]["message"]);
//         });
//       } else {
//         Singleton.showmsg(context, "Message", body["message"]);
//       }
//
//       debugPrint(body.toString());
//     } else {
//       Singleton.showmsg(context, "Message", body["error"]);
//     }
//   }
// }
