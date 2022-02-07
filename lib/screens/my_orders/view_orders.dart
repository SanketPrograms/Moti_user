import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/my_orders/order_items.dart';
import 'package:big_basket/screens/my_orders/track_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewOrders extends StatelessWidget {
  final time;
  final date;
  final TxnID;
  final OID;
  final SubTotal;
  final Total;
  final userPhoneNo;
  final userADDRESS;
  final productQUantity;
  final deliveryCharge;


  ViewOrders({Key? key,
    this.time,
    this.date,
    this.TxnID,
    this.OID,
    this.SubTotal,
    this.deliveryCharge,
    this.Total, this.userPhoneNo, this.userADDRESS, this.productQUantity})
      : super(key: key);

   var GrandTotal;
  @override
  Widget build(BuildContext context) {
    GrandTotal = double.parse(SubTotal.toString())+double.parse(deliveryCharge.toString());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Order Details",
            style: constantFontStyle(fontSize: 14),
          ),
          backgroundColor: Colors.blueGrey,
          bottom: TabBar(
            automaticIndicatorColorAdjustment: true,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  "Summary",
                  style: constantFontStyle(),
                ),
              ),
              Tab(
                child: Text("Items", style: constantFontStyle()),
              ),
              Tab(
                child: Text("Track", style: constantFontStyle()),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(color: Colors.blueGrey.shade100, child: orderInvoice()),
            OrderItems(),
            TrackOrder(),
          ],
        ),
      ),
    );
  }

  Widget orderInvoice() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "DELIVERY SLOT",
              style: constantFontStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.blueGrey.shade500),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date,
                            style: constantFontStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey.shade300,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            time,
                            style: constantFontStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey.shade300,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Order Pending",
                            style: constantFontStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey.shade300,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "ADDRESS",
              style: constantFontStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.blueGrey.shade500),
            ),
            Card(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userADDRESS.toString(),
                            style: constantFontStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey.shade300,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            userPhoneNo.toString(),
                            style: constantFontStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey.shade300,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "INVOICE",
              style: constantFontStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.blueGrey.shade500),
            ),
            Card(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Transaction ID",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                              Text(
                                TxnID,
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                              Text(
                                OID,
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       "Payment By",
                          //       style: constantFontStyle(
                          //           fontWeight: FontWeight.w500,
                          //           color: Colors.blueGrey.shade300,
                          //           fontSize: 12),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub-Total",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                              Text(
                                SubTotal,
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Charge",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                              Text(
                                "Rs ${deliveryCharge.toString()}",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand Total",
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                              Text(
                                // Total,
                                GrandTotal.toString()
                                ,
                                style: constantFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey.shade300,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




}