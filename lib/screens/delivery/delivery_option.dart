import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/constants/singleton.dart';
import 'package:big_basket/dashboard_new.dart';
import 'package:big_basket/screens/address/view_address.dart';
import 'package:big_basket/screens/dashboard.dart';
import 'package:big_basket/screens/delivery/pincode_modalclass.dart';
import 'package:big_basket/screens/user_login/login_sliding_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class DeliveryOption extends StatefulWidget {
  final productPriceTotal;
  final numberOfItems;
  DeliveryOption({Key? key, this.productPriceTotal, this.numberOfItems}) : super(key: key);

  @override
  State<DeliveryOption> createState() => _DeliveryOptionState();
}

class _DeliveryOptionState extends State<DeliveryOption> {
  bool visibleMessage = false;
  bool isLoading = true;
  var contactNo = "";
  var userEmail = "";
  var address = "";
  double grandPrice = 0.0;
  List<String> paymentType = ["Cash On Delivery","Online"];

  Razorpay? razorpay;
  TextEditingController textEditingController = new TextEditingController();
  FocusNode textFocusController = FocusNode();
 var deliveryCharge = "0";
 // String deliveryCharge = 50;
  List<String> productname = [];
  List<String> productprice = [];
  List<String> productWeight= [];

  var msg;
  var userAid;
  int? selectPaymentMethod;

  @override
  void initState() {
    // TODO: implement initState
    // getPincodeData()
    getCartData();
    getSharedData();
    razorpay = new Razorpay();

    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "Delivery Option",
          style: constantFontStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
          : SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Card(
            elevation: elevation_size,
            child: Column(
              children: [

                top(context),
                selectPayementMethod(),
                Container(
                  height: 5,
                  color: Colors.blueGrey.shade100,
                ),
                GiftMessage(context),
                // Container(
                //   height: 15,
                //   color: Colors.blueGrey.shade200,
                // ),
                ProccedTopay()
              ],
            ),
          ),
        ),
      ),
    );
  }

  getSharedData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      address = prefs.getString('userAddress') ?? "";
      contactNo = prefs.getString('phone') ?? "";
      userEmail = prefs.getString('userEmail') ?? "";
    });
  }

  Widget top(context) {
    return Card(
      child: Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ListTile(
            title: Text(
              "Deliver To home",
              style: constantFontStyle(
                  fontWeight: FontWeight.bold, fontSize: TitleFontsize),
            ),
            leading: Icon(Icons.location_on_outlined),
            trailing: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.black,
                      width: 0.8,
                      style: BorderStyle.solid,
                    ))),
              ),
              child: Text(
                "Change",
                style: constantFontStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewAddress()));
              },
            ),
            subtitle: Text(address.toString(),
                style: constantFontStyle(
                    fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ),
      ),
    );
  }

  Widget GiftMessage(context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.card_giftcard),
          title: Text(
            'Is this a gift order?',
            style: constantFontStyle(
                fontWeight: FontWeight.bold, fontSize: TitleFontsize),
          ),
          trailing: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: Colors.black,
                      width: 0.5,
                      style: BorderStyle.solid))),
            ),
            child: Text(
              "Add Message",
              style: constantFontStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            onPressed: () {
              (context as Element).markNeedsBuild();
              visibleMessage = !visibleMessage;
            },
          ),
        ),
        Visibility(
          visible: visibleMessage,
          child: TextFormField(
            minLines: 2,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: 'Message',
              labelText: 'Message',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget ProccedTopay() {
    return Card(
      elevation: elevation_size,
      color: Colors.blueGrey.shade100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Default Delivery Option",
                    style: constantFontStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Delivery Charge Rs$deliveryCharge",
                    style: constantFontStyle(
                        fontWeight: FontWeight.w500, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                'Shipment 1: Express Delivery',
                style: constantFontStyle(
                    fontWeight: FontWeight.w500, fontSize: TitleFontsize),
              ),
              trailing: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                          style: BorderStyle.solid))),
                ),
                child: Text(
                  "View Item",
                  style: constantFontStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                onPressed: () {
                  setState(() {
                    _showMyDialog(context);
                  });
                },
              ),
            ),
          ),
          Container(
            height: 40,
            child: Card(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(Icons.watch_later),
                    ),
                    Expanded(
                        child: Text(
                          "Between 09:00am - 10:00pm",
                          style: constantFontStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "",
                    style: constantFontStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Total Item price Rs ${widget.productPriceTotal
                            .toString()}",
                        style: constantFontStyle(
                            fontWeight: FontWeight.w500, fontSize: 10),
                      ),
                      Text(
                        "Delivery Charge Rs $deliveryCharge",
                        style: constantFontStyle(
                            fontWeight: FontWeight.w500, fontSize: 10),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Text(
                        "Grand Total: Rs ${grandPrice.toString()}",
                        style: constantFontStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 4.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.red.shade400),
                          foregroundColor:
                          MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>Razor()));
                          if(selectPaymentMethod == 0){
                            placeOrder("cod","cod");

                          }
                          else if(selectPaymentMethod == 1){
                            openCheckout();
                          }
                          else if(userAid == null){
                            Singleton.showmsg(context, "Message", "Please Select Address");

                          }
                          else{
                            Singleton.showmsg(context, "Message", "Please Select Payment Mode");
                          }
                        },
                        child: Text(
                          "Proceed to Pay",
                          style: constantFontStyle(
                              fontSize: Fontsize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ))),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget selectPayementMethod() {

    return Card(
      child: ExpansionTile(title: Text("Select Payment Method",style: constantFontStyle(
          fontSize: 13,fontWeight: FontWeight.bold
      ),),children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder:  (BuildContext context, int index) {
            return       Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: paddingAllHorizontal),
                        child: Text(
                          paymentType[index],
                          style: constantFontStyle(fontSize: Fontsize),
                        ),
                      ),
                    ),

                    Expanded(
                      child: RadioListTile<int>(
                          activeColor: themeColor,

                          value: index,
                          groupValue: selectPaymentMethod,
                          onChanged: (ind) {
                            setState(() {

                            selectPaymentMethod = ind!.toInt();

                            debugPrint(selectPaymentMethod.toString());

                          });
                          }

                      ),
                    )
                  ],
                ),

              ],



            );
          },
          itemCount: paymentType.length,
        ),
      ],),
    );
  }

  void openCheckout() {
   // var amount = grandPrice * 100;
    var amount =  1*100;
    var options = {
      'key': 'rzp_live_ybfigfWj1W9zlC',
      'amount': amount.toString(),
      'name': 'Moti Confectionery',
      "image": "https://is2-ssl.mzstatic.com/image/thumb/Purple113/v4/3c/4c/9f/3c4c9f0b-85d7-5b4a-a2fe-59d6c0679aaf/source/512x512bb.jpg",

      'description': 'All In One Shop',
      'theme.color': '#00AC4C',
      'prefill': {
        'contact': contactNo.toString(),
        'email': userEmail.toString()
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay!.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Pament success");
    msg = "SUCCESS: " + response.paymentId.toString();
    showToast(msg);
    placeOrder(response.paymentId.toString(),"online");
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    msg = "ERROR: " +
        response.code.toString() +
        " - " +
        jsonDecode(response.message.toString())['error']['description'];
    showToast(msg);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    msg = "EXTERNAL_WALLET: " + response.walletName.toString();
    showToast(msg);
  }

  showToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.withOpacity(0.1),
      textColor: Colors.black54,
    );
  }

  placeOrder(txn_id,paymentType) async {
    var userID;
    final prefs = await SharedPreferences.getInstance();

    userID = prefs.getString('userId');
    var cartOid = prefs.getString('cartOid');
    final addressId = prefs.getString("addressId");
    if (addressId == null) {
      Singleton.showmsg(context, "Message", "Please Select Address");
    } else {
      debugPrint("this is order id$cartOid");
      debugPrint("this is order id$addressId");


      final dataBody = {
        "userid": userID,
        "oid": cartOid.toString(),
        "pmode": paymentType,
        "txn_id": txn_id, ////change the trx id
        "aid": addressId, ////change the trx id
        "wallet_amt": grandPrice.toString(), ////change the trx id
        //  "password":passwordController.text,
      };
      var response = await http.post(Uri.parse(placeOrderApi), body: dataBody);
      var body = jsonDecode(response.body);
      debugPrint(body.toString());
      debugPrint(body["status"].toString());
      if (response.statusCode == 200) {
        // Singleton.showmsg(context, "Message", body["result"]["message"]);

        setState(() {});
        if (body["status"] == "200") {
          Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                  builder: (BuildContext context) => DashBoardNew()));
          Singleton.showmsg(context, "Message", body["result"]["message"]);
        } else {
          Singleton.showmsg(context, "Message", body["message"]);
        }

        debugPrint(body.toString());
      } else {
        Singleton.showmsg(context, "Message", body["error"]);
      }
    }
  }

  getCartData() async {
    var userID;
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userId');
    final cartOid = prefs.getString('cartOid');
     userAid = prefs.getString('addressId');

    if (userID == null) {
      Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(builder: (context) => Login_Sliding_image()));
    } else {
      debugPrint("this is userid ${"$viewCart?userid=$userID&oid=$cartOid&aid=$userAid"}");
        String Api ;
       if(userAid==null){
         deliveryCharge = "0";
         Api = "$viewCart?userid=$userID&oid=$cartOid";
       }
       else{
         Api = "$viewCart?userid=$userID&oid=$cartOid&aid=$userAid";
       }
      var response =
      await http.get(Uri.parse(Api));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        debugPrint("this is data${data.toString()}");

        productname.clear();
        productprice.clear();
        productWeight.clear();


        if (data["result"]["items"].length != null ||
            data["result"]["items"].length != 0) {
          deliveryCharge = data["result"]["shipping"].toString();

          debugPrint("this is delivery Charge $deliveryCharge");
          for (int i = 0; i < data["result"]["items"].length; i++) {
            productname.add(data["result"]["items"][i]["pname"].toString());
            productprice.add(data["result"]["items"][i]["price"].toString());
            productWeight.add(data["result"]["items"][i]["variants_str"].toString());


            //   ProductVegNonveg.add(data["result"][i]["findicator"]);


          }
          grandPrice = widget.productPriceTotal + double.parse(deliveryCharge);
        }

        // subList = s;


      }
    }
    setState(() {
      isLoading = false;
    });
  }


  _showMyDialog(context) async {
    debugPrint("this is ");
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(

            title: Text(
              'Products In Your Cart!',
              style: constantFontStyle(
                  fontSize: TitleFontsize, fontWeight: FontWeight.bold),
            ),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(

                    children: <Widget>[
                      const Divider(thickness: 1),
                      dynamicListview(),
                      const Divider(thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(decoration: BoxDecoration(
                                color: themeColor),
                                width: 80,
                                height: 30,
                                child: Center(
                                  child: Text("Ok", style: constantFontStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),


          );
        });
  }

  Widget dynamicListview() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),

      itemCount: productname.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text(productname[index], style: constantFontStyle(
                  fontSize: 12, fontWeight: FontWeight.w500),),
              trailing: Text(
                "Rs ${productprice[index]} x ${widget.numberOfItems[index]}",
                style: constantFontStyle(
                    fontSize: 12, fontWeight: FontWeight.w500),),
              subtitle:Text(productWeight[index], style: constantFontStyle(
                  fontSize: 12, fontWeight: FontWeight.w500),),
            ),



          ],
        );
      },
    );
  }

  // getPincodeData() async {
  //   var userPincode;
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   userPincode = prefs.getString('userPincode');
  //
  //   debugPrint("this is userPincode $userPincode");
  //
  //   var response = await http.get(Uri.parse("$pinCodeApi"));
  //
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     setState(() {
  //     final pincodeModalclass = pincodeModalclassFromJson(response.body);
  //     for(int i = 0; i < pincodeModalclass.length;i++) {
  //       debugPrint(pincodeModalclass[i].pincode);
  //
  //       if(pincodeModalclass[i].pincode!.toString() == userPincode){
  //         deliveryCharge = pincodeModalclass[i].dcharge!;
  //         debugPrint("aaaaa");
  //       }
  //
  //     }
  //
  //     debugPrint(deliveryCharge.toString()+"vvvvvvvvvvv");
  //
  //
  //     grandPrice = widget.productPriceTotal + double.parse(deliveryCharge);
  //
  //       isLoading = false;
  //     });
  //
  //
  //   }
  // }

}


