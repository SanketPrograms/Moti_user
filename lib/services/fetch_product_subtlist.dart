import 'dart:convert';

import 'package:big_basket/constants/apis.dart';
import 'package:http/http.dart' as http;


class FetchProductSublist{

  static List<String> fruitName = [];
  static var SublistitemCount;


   getData() async{




    var response = await http.get(Uri.parse(categoriesSublistApi));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);


      for(int i = 0; i < 1;i++){
        fruitName.add(jsonResponse["data"][i]["image_category"]);
      }





    } else {

    }
  }

}