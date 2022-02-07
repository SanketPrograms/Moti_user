import 'dart:convert';

import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/my_orders/view_orders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List<String> price = [];
  List<String> TotalProductPrice = [];
  List<String> productQUantity = [];
  List<String> userADDRESS = [];
  List<String> dateList = [];
  List<String> ProductPrice = [];
  List<String> ProductName = [];
  List<String> deliveryCharge = [];
  List<String> productWeight = [];
  List<String> timeList = [];
  List<String> TxnID = [];
  List<String> OID = [];
  List<String> SubTotal = [];
  List<String> productVariant = [];
  List<String> Total = [];
  List<String> userPhoneNo = [];
  List GetProductID = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: customAppBar("My Orders"),
            body: isLoading == true
                ?Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
                :ListView.builder(
                itemCount: TxnID.length,
                shrinkWrap: true,
                //  physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      List<String>pname = [];
                      List<String>price = [];
                      List<String>variant = [];
                      List<String>productWeight1 = [];
                      List<String>productQUantity1 = [];
                      List<String>deliveryCharges = [];
                      for(int i = 0; i <ProductName.length;i++){
                      if(GetProductID[i]["oid"].toString() == OID[index].toString()){
                          pname.add(ProductName[i]);
                          price.add(ProductPrice[i]);
                          variant.add(productVariant[i]);
                          productQUantity1.add(productQUantity[i]);
                          productWeight1.add(productWeight[i]);
                          deliveryCharges.add(deliveryCharge[i]);
                        }
                      }
                      saveProductItemData(pname,price,variant,productQUantity1,productWeight1,deliveryCharges);
                      debugPrint(pname.toString());
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewOrders(time:timeList[index],date:dateList[index],TxnID:TxnID[index],OID:OID[index],SubTotal:SubTotal[index],Total:Total[index],userPhoneNo:userPhoneNo[index],userADDRESS:userADDRESS[index],productQUantity:productQUantity[index],deliveryCharge:deliveryCharge[index].toString())));
                      // showAlert(context,ProductName[index].toString(),ProductPrice[index].toString(),TotalProductPrice[index].toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: elevation_size,
                        child: ListTile(
                          title: Column(
                            children: [
                              Text(
                                "Order ID: ${OID[index]}",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500, fontSize: 10),
                              ),
                            ],
                          ),
                          leading: CircleAvatar(
                            radius: 22.0,
                            backgroundImage: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/128/3649/3649583.png",),
                            backgroundColor: Colors.transparent,


                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                "Preparing..",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "View Items",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 13),
                              ),
                              Text(
                                "${dateList[index]} | ${timeList[index]}",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }));
  }

  getData() async {
    var userID;
    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');

    var response = await http.get(Uri.parse("$myOrdersApi?userid=$userID"));
    //var response = await http.get(Uri.parse("$product?userid=$userID&vendor=5&subcategory=3&category=3}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      debugPrint("this is data${data.toString()}");
      debugPrint("this is message${data["message"].toString()}");
      setState(() {
        if (data["message"].toString() == "Products Not Found") {
          // noProduct = "1";
        } else {
          // noProduct = "2";
          // categoryName.clear();
          // ProductImage.clear();
          // productId.clear();
          // productDescription.clear();
          dateList.clear();
          timeList.clear();
          TxnID.clear();
          OID.clear();
          ProductName.clear();
          TotalProductPrice.clear();
          ProductPrice.clear();
          SubTotal.clear();
         Total.clear();
          GetProductID.clear();
          productVariant.clear();
          userPhoneNo.clear();
          userADDRESS.clear();
          productWeight.clear();
          productQUantity.clear();
          deliveryCharge.clear();

          var s = [];

          for (int i = 0; i < data["result"].length; i++) {
            dateList.add(data["result"][i]["dt"].toString().split(" ").first);
            timeList.add(data["result"][i]["dt"].toString().split(" ").last);
            TxnID.add(data["result"][i]["txn_id"]);
            deliveryCharge.add(data["result"][i]["shipping"]);
            OID.add(data["result"][i]["id"]);

            SubTotal.add(data["result"][i]["subtotal"]);
            Total.add(data["result"][i]["total"]);
            userPhoneNo.add(
                data["result"][i]["uphone"].toString());

            userADDRESS.add(
                data["result"][i]["apartment"].toString()+","+"HouseNo:"+data["result"][i]["houe_no"].toString()+","+data["result"][i]["city"].toString()+" ,"+data["result"][i]["pin"].toString());

            for (int j = 0; j < data["result"][i]["items"].length; j++) {
              ProductName.add(
                  data["result"][i]["items"][j]["pname"].toString());

              GetProductID.add(data["result"][i]["items"][j]);
            ProductPrice.add(
                data["result"][i]["items"][j]["price"].toString());
              productVariant.add(data["result"][i]["items"][j]["variants"].toString());
              productWeight.add(data["result"][i]["items"][j]["variant_str"].toString().split(":").last);

              TotalProductPrice.add(
                  data["result"][i]["items"][j]["total"].toString());
              productQUantity.add(
                  data["result"][i]["items"][j]["qty"].toString());

          }
            //  for (int j = 0; j < data["result"][i]["opts"].length; j++) {
            //  price.add(data["result"][i]["opts"][j]["price"].toString());
            // discountprice.add(
            //     data["result"][i]["opts"][j]["dprice"].toString());
            // ProductVariant.add(
            //     data["result"][i]["opts"][j]["variants"].toString());
            //   }
          }
          debugPrint("this is date $productWeight");
          debugPrint("this is time $timeList");
        }

        // subList = s;

        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }


  saveProductItemData(pname,price,variant,productQUantity,productWeight,deliveryCharges) async{

    final prefs = await SharedPreferences.getInstance();
     prefs.setStringList('pname',pname);
     prefs.setStringList('price',price);
     prefs.setStringList('variant',variant);
     prefs.setStringList('quantity',productQUantity);
     prefs.setStringList('str_variant',productWeight);
     prefs.setStringList('deliveryCharges',deliveryCharges);
  }
}
