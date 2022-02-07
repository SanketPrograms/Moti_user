import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

       child: Stack(
         children: [
           Image.asset("assets/images/green_background.png")
         ],
       ),


      ),
    );
  }
}
