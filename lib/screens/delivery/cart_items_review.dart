// import 'dart:convert';
//
// import 'package:big_basket/constants/apis.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// class cart_items_review extends StatelessWidget {
//    cart_items_review({Key? key}) : super(key: key);
//   List<String> productname = [];
//   List<String> productprice = [];
//   @override
//   Widget build(BuildContext context) {
//       return  AlertDialog(
//       title: Text("Cart Products"),
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20))
//       ),
//       actions: <Widget>[
//         FlatButton(
//           child: const Text('CANCEL'),
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           textColor: Theme.of(context).accentColor,
//           onPressed: () {
//             // widget.onCancel();
//           },
//         ),
//         FlatButton(
//           child: const Text('OK'),
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           textColor: Theme.of(context).accentColor,
//           onPressed: () {
//             // widget.onOk();
//           },
//         ),
//       ],
//       content: Container(
//         width: double.maxFinite,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Divider(),
//             ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxHeight: MediaQuery.of(context).size.height*0.4,
//               ),
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: productname.length,
//                   itemBuilder: (BuildContext context, int index){
//                     return Text(productname[index]);
//                   }
//               ),
//             ),
//             Divider(),
//             TextField(
//               autofocus: false,
//               maxLines: 1,
//               style: TextStyle(fontSize: 18),
//               decoration: new InputDecoration(
//                 border: InputBorder.none,
//                 //    hintText: widget.hintText,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );;
//   }
//
//
//   getCartData() async {
//     var userID;
//     final prefs = await SharedPreferences.getInstance();
//     userID = prefs.getString('userId');
//     final cartOid = prefs.getString('cartOid');
//
//     if (userID == null) {
//       // Navigator.push(
//       //     context,
//       //     MaterialPageRoute(builder: (context) => Login_Sliding_image()));
//     } else {
//       debugPrint("this is userid ${cartOid == null}");
//       debugPrint("this is cartOid $cartOid");
//
//       var response =
//       await http.get(Uri.parse("$viewCart?userid=$userID&oid=$cartOid"));
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//
//         debugPrint("this is data${data.toString()}");
//
//         productname.clear();
//         productprice.clear();
//
//
//         if (data["result"]["items"].length != null ||
//             data["result"]["items"].length != 0) {
//           for (int i = 0; i < data["result"]["items"].length; i++) {
//             productname.add(data["result"]["items"][i]["pname"].toString());
//             productprice.add(data["result"]["items"][i]["price"].toString());
//             //   ProductVegNonveg.add(data["result"][i]["findicator"]);
//
//
//           }
//         }
//
//         // subList = s;
//
//
//       }
//     }
//   }
// }
