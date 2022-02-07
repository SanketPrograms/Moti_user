import 'package:big_basket/Widgets/appbar.dart';
import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/my_account/my_account_menus.dart';
import 'package:big_basket/screens/my_account/my_account_top.dart';
import 'package:flutter/material.dart';

class MyAccountDashboard extends StatelessWidget {
  const MyAccountDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("My Account"),
      body: Container(
        child: Column(children: [
          my_account_top(),
          MyAcccountMenus()
        ],),
      ),
    );
  }

}
