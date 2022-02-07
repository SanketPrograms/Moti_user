// import 'dart:convert';
//
// import 'package:big_basket/Widgets/appbar.dart';
// import 'package:big_basket/constants/constant.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:photo_view/photo_view.dart';
//
// class ProductDetails extends StatefulWidget {
//   final productId;
//   final productname;
//   final price;
//   final ProductVariant;
//   final productimage;
//   ProductDetails({Key? key, this.productId, this.productname, this.price, this.ProductVariant, this.productimage}) : super(key: key);
//
//   @override
//   ProductDetailsState createState() => ProductDetailsState();
// }
//
// class ProductDetailsState extends State<ProductDetails> {
//   int value = 0;
//   int num = 6;
//   int showSubImage = 0;
//   List<String> priceList = [
//     "120",
//     "150",
//     "180",
//     "190",
//   ];
//   List<String> quantityList = [
//     "5KG",
//     "10KG",
//     "15KG",
//     "25KG",
//   ];
//
//   List<String> sortTypeList = [
//     "Popularity",
//     "Price - Low to High",
//     "Price - High to Low",
//     "Alphabetical",
//     "Rupee Saving - Low to High",
//     "% Off - High to Low"
//   ];
//
//   List<String> subImage = [
//     "https://m.media-amazon.com/images/I/71G2ZJO50+L._SL1500_.jpg",
//     "https://m.media-amazon.com/images/I/81p4sgrCfzL._SX466_.jpg",
//     "https://m.media-amazon.com/images/I/413PiCvZevL._AC_SS450_.jpg"
//
//
//   ];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     debugPrint("this is image ${widget.productimage.length.toString()}");
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context),
//       body: SafeArea(
//         child: Card(
//           child: Column(
//             children: [
//               ListTile(title: Text("${widget.productname.toString()} - ${widget.ProductVariant.toString()}",style: constantFontStyle(fontWeight: FontWeight.bold),),subtitle: Row(
//                 children: [
//                   Row(
//                     children: [
//                       Text("Rs ${widget.price}",style: constantFontStyle(fontWeight: FontWeight.bold,fontSize: 14),),
//                       Card(color:Colors.redAccent.shade200,child: Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: Text("20% Off",style: constantFontStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),),
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
//                       imageUrl: widget.productimage[showSubImage],
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
//               Expanded(
//                 flex: 2,
//                 child: Card(
//                   elevation: elevation_size,
//                   child: priceListDetails(),
//                 ),
//               ),
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
//   Widget priceListDetails() {
//     return ListView.builder(
//       itemCount: quantityList.length,
//       itemBuilder: (context, index) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//               child: Card(
//                 borderOnForeground: true,
//                 shape: const BeveledRectangleBorder(
//                   side: BorderSide(
//                     color: themeColor,
//                     width: 0.2,
//                   ),
//                 ),
//                 elevation: paddingAllTwo,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Expanded(
//                         flex: 3,
//                         child: Row(
//
//                           children: [
//                             const SizedBox(width: 5,),
//                             Text(quantityList[index],
//                                 style: constantFontStyle()),
//                             const  SizedBox(width: 40,),
//                             Text(priceList[index]+"Rs",
//                                 style: constantFontStyle(fontWeight: FontWeight.bold)),
//                           ],
//                         )),
//                     Expanded(
//                       child: RadioListTile<int>(
//                           activeColor: themeColor,
//                           value: index,
//                           groupValue: value,
//                           onChanged: (ind) {
//                             setState(() {
//                               value = ind!.toInt();
//                             });
//                           }),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   Widget subImages() {
//     return ListView.builder(
//       itemCount: widget.productimage.length,
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
//                       child: Image.network(widget.productimage[index],scale: 0.2,)
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
// // getData()  async{
// //   var response = await http.post(Uri.parse(userProfileApi),body: {"userid":"1"});
// //   if (response.statusCode == 200) {
// //     var body = jsonDecode(response.body);
// //     debugPrint(body.toString() + "this is user data");
// //   } else {
// //
// //   }
// // }
//
// }
