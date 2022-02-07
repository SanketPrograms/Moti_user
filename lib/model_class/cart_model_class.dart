import 'package:big_basket/constants/apis.dart';
import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier{

  List<String> _ProductName = [];
  List<String> _Product = [];


  List<String> get getproduct => _ProductName;
  List<String> get getproductPrice => _ProductName;


  void addData(String value){
    _ProductName.add(value);
    notifyListeners();
  }

}