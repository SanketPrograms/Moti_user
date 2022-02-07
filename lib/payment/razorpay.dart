import 'dart:ui';

import 'package:big_basket/constants/constant.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RazorpayPayement extends StatefulWidget {
  @override
  _RazorpayPayementState createState() => _RazorpayPayementState();
}

class _RazorpayPayementState extends State<RazorpayPayement> {
  Razorpay? razorpay;
  TextEditingController textEditingController = new TextEditingController();
  FocusNode textFocusController = FocusNode();
  var msg;
  var contactNo;
 var userEmail;
  @override
  void initState() {
    super.initState();
    getSharedData();
    razorpay = new Razorpay();

    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => textFocusController.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
          title: const Text("ADD FUND"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: elevation_size,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: RadioListTile<int>(
                          activeColor: themeColor,
                          value: 1,
                          groupValue: 1,
                          onChanged: (ind) {
                            setState(() {

                            });
                          }),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Credit Card/Debit Card/Net-Banking",
                                  style: constantFontStyle(
                                      color: Colors.red, fontSize: 10),
                                ),

                              ],
                            ),

                          ],
                        )),

                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),

              Container(
                width: 200,
                height: 50,
                child: TextField(
                  focusNode: textFocusController,
                  cursorRadius: Radius.zero,
                  textAlign: TextAlign.center,
                  controller: textEditingController,

                  decoration: const InputDecoration(hintText: "Amount To Fund",
                    border:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10),),
                        borderSide:  BorderSide(color: themeColor)
                    ),

                    labelText: "Add Fund"
                  ),

                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
          RaisedButton(
                  color: themeColor,
                  child: Text(
                    "Submit",
                    style: const TextStyle(color: Colors.white,fontSize: 16),
                  ),
                  onPressed: () {
                    openCheckout();
                  },
                ),






            ],
          ),
        ),
      ),
    );
  }

  void openCheckout() {
    var amount =  int.parse(textEditingController.text)*100;
    var options = {
      'key': 'rzp_live_ybfigfWj1W9zlC',
      'amount': amount.toString(),
      'name': 'Moti Confectionery',
      "image" : "https://is2-ssl.mzstatic.com/image/thumb/Purple113/v4/3c/4c/9f/3c4c9f0b-85d7-5b4a-a2fe-59d6c0679aaf/source/512x512bb.jpg",

      'description': 'All In One Shop',
      'theme.color':'#00AC4C',
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
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    msg = "ERROR: " + response.code.toString() + " - " + jsonDecode(response.message.toString())['error']['description'];
    showToast(msg);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    msg = "EXTERNAL_WALLET: " + response.walletName.toString();
    showToast(msg);
  }

  showToast(msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.withOpacity(0.1),
      textColor: Colors.black54,
    );
  }
  getSharedData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      //address = prefs.getString('userAddress') ?? "";
      contactNo = prefs.getString('phone') ?? "";
      userEmail = prefs.getString('userEmail') ?? "";
    });
  }
}