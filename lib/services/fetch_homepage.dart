import 'dart:convert';

import 'package:big_basket/constants/apis.dart';
import 'package:http/http.dart' as http;


class FetchHomePage{

  static List<String> fruitName = [];
  static var itemCount;


  getData() async{
     itemCount = "2";
    // var url = 'https://www.googleapis.com/books/v1/volumes?q={http}';
    // var response = await http.get(Uri.parse(url));
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);
    //
    //
    //
    // } else {
    //
    // }
  }

}