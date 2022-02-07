// import 'dart:convert';
//
// import 'package:big_basket/constants/apis.dart';
// import 'package:big_basket/constants/constant.dart';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// class RefineBy extends StatefulWidget {
//   const RefineBy({Key? key}) : super(key: key);
//
//   @override
//   _RefineByState createState() => _RefineByState();
// }
//
// class _RefineByState extends State<RefineBy> {
//   List<String> categoryName = [];
//   List<String> categoryImage = [];
//   List<String> fruitName = [];
//   List<String> fiterBy = ["Brand","Price","Discount","Pack Size","Food Preference"];
//
//   var subList = [];
//   bool filterValue = false;
//
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//   //  getData();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//     //   isLoading == true
//     //     ?
//     // const Center(child: CircularProgressIndicator())
//     //     :
//       SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const SizedBox(height: SizedBoxSize),
//                 SizedBox(
//                   // height: MediaQuery.of(context).size.height - 100,
//                   child: ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: _buildList,
//                     itemCount: fiterBy.length,
//                     shrinkWrap: true,
//                   ),
//                 ),
//                 Padding(
//
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Clear All",
//                             style: constantFontStyle(
//                                 color: blackColor, fontWeight: FontWeight.w600),
//                           )),
//                       ElevatedButton(
//                           style: ElevatedButton.styleFrom(primary: blackColor),
//                           onPressed: () {},
//                           child: Text("Done",
//                               style: constantFontStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold))),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
//
//   Widget _buildList(BuildContext context, int index) {
//     return ExpansionTile(
//         title: ListTile(
//           title: Text(fiterBy[index],
//               style: constantFontStyle(
//                   fontSize: TitleFontsize, fontWeight: FontWeight.w500)),
//           //  leading: Image.network(category_image[index]),
//         ),
//         children: [
//           ListView.builder(
//             shrinkWrap: true,
//             itemBuilder: _buildSublist,
//             itemCount: 3,
//           ),
//         ]);
//   }
//
//   Widget _buildSublist(BuildContext context, int index) {
//     return ListTile(
//       // dense: true,
//       // title: Text(roles[index]),
//       title: Column(
//         children: [
//
//
//           Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//
//               Expanded(
//                 flex: 3,
//                   child: Padding(
//                     padding:  const EdgeInsets.symmetric(horizontal: paddingAllHorizontal),
//                     child: Text(
//                       "categoryName[index]",
//                       style: constantFontStyle(fontSize: Fontsize),
//                     ),
//                   ),
//                 ),
//
//               Expanded(
//                 child: Checkbox(
//                   value: filterValue,
//                   onChanged: onChanged,
//                   fillColor: MaterialStateProperty.all(themeColor),
//                 ),
//               )
//             ],
//           ),
//           const  Divider(
//             // thickness: 1,
//
//           ),
//         ],
//       ),
//       onTap: () {},
//     );
//   }
//
//  // categoryName.length.toString()
//
//   void onChanged(bool? value) {
//     setState(() {});
//     filterValue = !filterValue;
//   }
//
//
// }
