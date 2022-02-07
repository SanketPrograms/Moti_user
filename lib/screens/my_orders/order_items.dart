import 'package:big_basket/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderItems extends StatefulWidget {
  const OrderItems({Key? key}) : super(key: key);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  List<String>pname = [];
  List<String>price = [];
  List<String>quantity = [];
  List<String>Productweight = [];
  List<String>variant = [];


  @override
  void initState() {
    // TODO: implement initState
    getProductItemData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Container(
       color: Colors.blueGrey.shade100,
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListView.builder(
            itemCount: pname.length,
            //  itemCount: title.length,
            shrinkWrap: true,
            //  physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: Image.network("https://icons-for-free.com/iconfiles/png/512/cart-131964784999299812.png",scale: 10,color:Colors.blueGrey,),
                      title:   Text(
                       pname[index],
                        style: constantFontStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.blueGrey.shade600),
                      ),
                      subtitle: Text("Quantity: "+Productweight[index]+" x"+quantity[index],style: constantFontStyle(
                        fontSize: 12,
                          color: Colors.blueGrey.shade500
                      ),),
                      trailing: Text("Rs " + price[index],style: constantFontStyle(
                          fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color:Colors.blueGrey.shade500

                      ),),
                    ),
                  ),
                  Divider()
                ],
              );
            }),
       ),
     );
  }

  getProductItemData() async{

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pname = prefs.getStringList('pname')!;
      price = prefs.getStringList('price')!;
      variant = prefs.getStringList('variant')!;
      quantity = prefs.getStringList('quantity')!;
      Productweight = prefs.getStringList('str_variant')!;


    });
  }
}
