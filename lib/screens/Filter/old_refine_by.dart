// import 'dart:convert';
//
// import 'package:big_basket/Widgets/drawer.dart';
// import 'package:big_basket/constants/apis.dart';
// import 'package:big_basket/constants/constant.dart';
// import 'package:big_basket/constants/singleton.dart';
// import 'package:big_basket/screens/address/view_address.dart';
// import 'package:big_basket/screens/product_list/product_list.dart';
// import 'package:big_basket/screens/search/searchnavigation.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class NewRefineBy extends StatefulWidget {
//   const NewRefineBy({Key? key}) : super(key: key);
//
//   @override
//   State<NewRefineBy> createState() => _NewRefineByState();
// }
//
// class _NewRefineByState extends State<NewRefineBy> {
//   bool expand = false;
//   bool SubcategoryLoading = true;
//
//   int? tapped;
//   List<String> CategoryfiterBy = ["Brand","Price","Discount","Pack Size","Food Preference"];
//
//   List<String> BannerImageList = [];
//   List<String> subcategoryName = [];
//   List<String> fruitName = [];
//   List<String> SubcategoryId = [];
//   var sendcategoryId;
//   var subList = [];
//   String? addressID;
//
//   bool isLoading = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//         // key: secondTabNavKey,
//
//         backgroundColor: Colors.white,
//         child: isLoading == true
//             ? Center(
//             child: Image.asset(
//               "assets/images/loading_page.gif",
//               scale: 3,
//             ))
//             : Scaffold(
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                        //   sendcategoryId = categoryId[index];
//                           SubcategoryLoading = true;
//                          // debugPrint(categoryId[index] + "this is id");
//
//                           /// XOR operand returns when either or both conditions are true
//                           /// `tapped == null` on initial app start, [tapped] is null
//                           /// `index == tapped` initiate action only on tapped item
//                           /// `!expand` should check previous expand action
//                           getsubcategoryData(CategoryfiterBy[index]);
//                           expand =
//                           ((tapped == null) || ((index == tapped) || !expand))
//                               ? !expand
//                               : expand;
//
//                           /// This tracks which index was tapped
//                           tapped = index;
//                           debugPrint('current expand state: $expand');
//                         });
//                       },
//
//                       /// We set ExpandableListView to be a Widget
//                       /// for Home StatefulWidget to be able to manage
//                       /// ExpandableListView expand/retract actions
//                       child: expandableListView(
//                         index,
//                         CategoryfiterBy[index],
//                         index == tapped ? expand : false,
//                       ),
//                       // child: ExpandableListView(
//                       //   title: "Title $index",
//                       //   isExpanded: expand,
//                       // ),
//                     );
//                   },
//                   itemCount: CategoryfiterBy.length,
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//     );
//   }
//
//   Widget expandableListView(int index, String title, bool isExpanded) {
//     debugPrint('List item build $index $isExpanded');
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 1.0),
//       child: Column(
//         children: <Widget>[
//           Container(
//             color: Colors.white,
//             padding: EdgeInsets.symmetric(horizontal: 5.0),
//             child: Row(
//               children: [
//                 // Expanded(
//                 //   flex: 1,
//                 //   child: Padding(
//                 //     padding: const EdgeInsets.all(paddingAllTwo),
//                 //     child: Card(
//                 //       //elevation: elevation_size,
//                 //       child: Container(
//                 //           height: 60,
//                 //           child: ClipRRect(
//                 //               borderRadius: new BorderRadius.only(
//                 //                   topRight: Radius.circular(00.0),
//                 //                   topLeft: Radius.circular(10.0)),
//                 //               child: CachedNetworkImage(
//                 //                 errorWidget: (context, url, error) => Image.network(
//                 //                     "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
//                 //
//                 //                 placeholder: (context, url) => Center(
//                 //                   child: Image.asset(
//                 //                       "assets/images/image_loader.gif"),
//                 //                 ),
//                 //                 imageUrl: categoryImage[index],
//                 //
//                 //                 // width: MediaQuery.of(context).size.width/1.9,
//                 //                 fit: BoxFit.fitHeight,
//                 //               ))),
//                 //     ),
//                 //   ),
//                 // ),
//                 Expanded(
//                   flex: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(title,
//                         style: constantFontStyle(
//                             fontSize: TitleFontsize,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//                 IconButton(
//                     icon: Container(
//                       height: 50.0,
//                       width: 50.0,
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Icon(
//                           isExpanded
//                               ? Icons.keyboard_arrow_up
//                               : Icons.keyboard_arrow_down,
//                           color: Colors.black,
//                           size: 18.0,
//                         ),
//                       ),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         //   expandFlag = !expandFlag;
//
//                       //  sendcategoryId = categoryId[index];
//                         SubcategoryLoading = true;
//                      //   debugPrint(categoryId[index] + "this is id");
//
//                         /// XOR operand returns when either or both conditions are true
//                         /// `tapped == null` on initial app start, [tapped] is null
//                         /// `index == tapped` initiate action only on tapped item
//                         /// `!expand` should check previous expand action
//                         getsubcategoryData(CategoryfiterBy[index]);
//                         expand =
//                         ((tapped == null) || ((index == tapped) || !expand))
//                             ? !expand
//                             : expand;
//
//                         /// This tracks which index was tapped
//                         tapped = index;
//                         debugPrint('current expand state: $expand');
//                       });
//                     }),
//               ],
//             ),
//           ),
//           SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: ExpandableContainer(
//               expanded: isExpanded,
//               expandedHeight:  53.5*subcategoryName.length,
//               child:  ListView.builder(
//                 //   shrinkWrap: true,
//                 physics: BouncingScrollPhysics(),
//                 shrinkWrap: true,
//
//                 //  scrollDirection: Axis.vertical,
//                 itemBuilder: (BuildContext context, int index) {
//                   return SubcategoryLoading == true
//                       ? const Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.purple,
//                         strokeWidth: 1,
//                       ))
//                       : Container(
//                     decoration: BoxDecoration(
//                         border:
//                         Border.all(width: 1.0, color: Colors.white),
//                         color: Colors.white),
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             debugPrint(sendcategoryId.toString());
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ProductList(
//                                         categoryName: subcategoryName[index].toString(),
//                                         BannerImageList: BannerImageList,
//                                         category: sendcategoryId.toString(),
//                                         subcategory:
//                                         SubcategoryId[index])));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               subcategoryName[index].toString(),
//                               style: constantFontStyle(
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black,
//                                   fontSize: 12),
//                             ),
//                           ),
//                           // leading: Icon(
//                           //   Icons.local_pizza,
//                           //   color: Colors.black,
//                           // ),
//
//                           // leading: Padding(
//                           //   padding: const EdgeInsets.all(8.0),
//                           //   child: Text("       "),
//                           // ),
//
//
//                         ),
//                         Divider(),
//                       ],
//                     ),
//                   );
//                 },
//                 itemCount: subcategoryName.length,
//               ),
//             ),
//           ),
//
//
//         ],
//       ),
//     );
//   }
//
//   // getCategoryData() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //
//   //   var response = await http.get(Uri.parse(categoriesSublistApi));
//   //   if (response.statusCode == 200) {
//   //     var data = jsonDecode(response.body);
//   //
//   //     categoryName.clear();
//   //     categoryImage.clear();
//   //     categoryId.clear();
//   //
//   //     var s = [];
//   //
//   //     for (int i = 0; i < data["result"].length; i++) {
//   //       categoryName.add(data["result"][i]["name"]);
//   //       categoryImage.add(data["result"][i]["imgpath"]);
//   //       categoryId.add(data["result"][i]["id"]);
//   //
//   //       // for (int j = 0;
//   //       // j < jsonResponse["data"][i]["sub_categories"].length;
//   //       // j++) {
//   //       //   s.add(jsonResponse["data"][i]["sub_categories"][j]
//   //       //   ["sub_category_name"]
//   //       //       .toString());
//   //       // }
//   //     }
//   //
//   //     // subList = s;
//   //
//   //     setState(() {
//   //       addressID = prefs.getString('userAddress');
//   //
//   //       isLoading = false;
//   //     });
//   //   } else {
//   //     debugPrint("Error in the Api");
//   //   }
//   // }
//
//   getsubcategoryData(category) async {
//     debugPrint("this is category $brandsApi");
//     String? Api;
//     if(category == "Brand"){
//       Api = brandsApi;
//     }
//     var response = await http.get(Uri.parse("$Api"));
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//
//       debugPrint(data.toString());
//
//       // categoryName.clear();
//       // categoryImage.clear();
//       subcategoryName.clear();
//       SubcategoryId.clear();
//
//       var s = [];
//
//       for (int i = 0; i < data["result"].length; i++) {
//         subcategoryName.add(data["result"][i]["name"]);
//         //  subcategoryImage.add(data["result"][i]["imgpath"]);
//         SubcategoryId.add(data["result"][i]["id"]);
//
//         // for (int j = 0;
//         // j < jsonResponse["data"][i]["sub_categories"].length;
//         // j++) {
//         //   s.add(jsonResponse["data"][i]["sub_categories"][j]
//         //   ["sub_category_name"]
//         //       .toString());
//         // }
//       }
//
//       // subList = s;
//
//       setState(() {
//         SubcategoryLoading = false;
//       });
//     } else {
//       debugPrint("Error in the Api");
//     }
//   }
//
//
// }
//
// class ExpandableContainer extends StatelessWidget {
//   final bool expanded;
//   final double collapsedHeight;
//   final double expandedHeight;
//   final Widget child;
//
//   ExpandableContainer({
//     required this.child,
//     this.collapsedHeight = 0.0,
//     this.expandedHeight = 200.0,
//     this.expanded = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       width: screenWidth,
//       height: expanded ? expandedHeight : collapsedHeight,
//       child: Container(
//         child: child,
//         decoration: BoxDecoration(
//             border: Border.all(width: 1.0, color: Colors.transparent)),
//       ),
//     );
//   }
// }
