// import 'dart:convert';
//
// import 'package:big_basket/Widgets/appbar.dart';
// import 'package:big_basket/constants/apis.dart';
// import 'package:big_basket/constants/constant.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:http/http.dart' as http;
//
// class ProductDetailsWithApi extends StatefulWidget {
//   final productId;
//
//   ProductDetailsWithApi({Key? key, this.productId}) : super(key: key);
//
//   @override
//   ProductDetailsWithApiState createState() => ProductDetailsWithApiState();
// }
//
// class ProductDetailsWithApiState extends State<ProductDetailsWithApi> {
//   int value = 0;
//   int num = 6;
//   int showSubImage = 0;
//   List<String> productName = [];
//   List<String> productVariant = [];
//   List<String> productPrice = [];
//   List<String> productDiscount = [];
//   List<String> productImage= [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     GetData();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: appBar(context),
//       body:  isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SafeArea(
//         child: Card(
//           child: Column(
//             children: [
//               ListTile(title: Text("${productName[0]} - ${productVariant[0]}",style: constantFontStyle(fontWeight: FontWeight.bold),),subtitle: Row(
//                 children: [
//                   Row(
//                     children: [
//                       Text("Rs ${productPrice[0]}",style: constantFontStyle(fontWeight: FontWeight.bold,fontSize: 14),),
//                       Card(color:Colors.redAccent.shade200,child: Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: Text("${productDiscount[0].split(".").first}% Off",style: constantFontStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
//                       )),
//                     ],
//                   ),
//                   SizedBox(width: 30,),
//                   // Text("MRP RS 250",style: constantFontStyle(fontWeight: FontWeight.w400,fontSize: 10),),
//                 ],
//               ),),
//               Expanded(
//                 flex: 3,
//                 child: Card(
//                     color: Colors.transparent,
//                     //elevation: elevation_size,
//                     // child: Image.network(subImage[showSubImage],scale: 2,
//                     child:
//                     CachedNetworkImage(
//                       color: Colors.white,
//                       fit: BoxFit.cover,
//                       imageUrl: productImage[showSubImage],
//                       imageBuilder: (context, imageProvider) => PhotoView(backgroundDecoration: BoxDecoration(color: Colors.white),
//
//                         imageProvider: imageProvider,
//                       ),
//                       placeholder: (context, url) =>
//                           Center(child: CircularProgressIndicator()),
//                       errorWidget: (context, url, error) =>
//                           Icon(Icons.error),
//                     )
//
//                 ),
//               ),
//
//               Expanded(flex:1,child: subImages()),
//               Row(
//                 children: [
//                   const  SizedBox(width: 20,),
//                   Text("Pack Sizes",style: constantFontStyle(fontWeight: FontWeight.w400,fontSize: 10),),
//                 ],
//               ),
//               // Expanded(
//               //   flex: 2,
//               //   child: Card(
//               //     elevation: elevation_size,
//               //     child: priceListDetails(),
//               //   ),
//               // ),
//               Expanded(
//                   child: Card(
//                     elevation: elevation_size,
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             bottomRight: Radius.circular(20))),
//                     color: Colors.white,
//                     child: Row(
//                       children: [
//                         Expanded(
//                             child: ElevatedButton(
//                                 style:
//                                 ElevatedButton.styleFrom(primary: Colors.black),
//                                 onPressed: () {},
//                                 child: Text(
//                                   "Save For Later",
//                                   style: constantFontStyle(color: Colors.white),
//                                 ))),
//                         Expanded(
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(primary: Colors.red),
//                               onPressed: () {},
//                               child: Text("Proceed To Pay",
//                                   style: constantFontStyle(color: Colors.white))),
//                         ),
//                       ],
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget priceListDetails() {
//   //   return ListView.builder(
//   //     itemCount: quantityList.length,
//   //     itemBuilder: (context, index) {
//   //       return Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //
//   //           Padding(
//   //             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//   //             child: Card(
//   //               borderOnForeground: true,
//   //               shape: const BeveledRectangleBorder(
//   //                 side: BorderSide(
//   //                   color: themeColor,
//   //                   width: 0.2,
//   //                 ),
//   //               ),
//   //               elevation: paddingAllTwo,
//   //               child: Row(
//   //                 mainAxisAlignment: MainAxisAlignment.end,
//   //                 children: [
//   //                   Expanded(
//   //                       flex: 3,
//   //                       child: Row(
//   //
//   //                         children: [
//   //                           const SizedBox(width: 5,),
//   //                           Text(quantityList[index],
//   //                               style: constantFontStyle()),
//   //                           const  SizedBox(width: 40,),
//   //                           Text(priceList[index]+"Rs",
//   //                               style: constantFontStyle(fontWeight: FontWeight.bold)),
//   //                         ],
//   //                       )),
//   //                   Expanded(
//   //                     child: RadioListTile<int>(
//   //                         activeColor: themeColor,
//   //                         value: index,
//   //                         groupValue: value,
//   //                         onChanged: (ind) {
//   //                           setState(() {
//   //                             value = ind!.toInt();
//   //                           });
//   //                         }),
//   //                   )
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
//   Widget subImages() {
//     return ListView.builder(
//       itemCount: productImage.length,
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: (){
//                 setState(() {
//                   showSubImage = index;
//                 });
//               },
//               child: Container(
//                 height: 60,
//                 width: 60,
//                 child: Card(
//                   child:
//                   Container(
//
//
//                       child: Image.network(productImage[index],scale: 0.2,)
//                   ),
//
//
//                 ),
//               ),
//             ),
//
//           ],
//         );
//       },
//     );
//   }
//
//   GetData() async {
//     var response = await http.get(Uri.parse("$productDetailsApi?product=${widget.productId}"));
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       debugPrint(data.toString() + "Data");
//       productName.clear();
//       productPrice.clear();
//       productVariant.clear();
//       productDiscount.clear();
//       setState(() {
//     //    for (int i = 0; i < data["result"].length; i++) {
//           productName.add(data["result"]["name"]);
//
//           productDiscount.add(data["result"]["discount"]);
//      //   }
//           for (int i = 0; i < data["result"]["imgs"].length; i++) {
//             productImage.add(data["result"]["imgs"][i]["imgpath"]);
//           }
//           for (int j = 0; j < data["result"]["opts"].length; j++) {
//             productPrice.add(data["result"]["opts"][j]["price"]);
//             productVariant.add(data["result"]["opts"][j]["variant_str"]);
//           }
//            isLoading = false;
//
//       });
//     } else {
//       setState(() {
//          isLoading = false;
//
//       });
//       debugPrint("Error in the Api");
//     }
//   }
//
// }
