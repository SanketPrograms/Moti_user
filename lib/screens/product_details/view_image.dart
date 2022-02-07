import 'dart:convert';

import 'package:big_basket/Widgets/appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

import 'package:http/http.dart' as http;

class ViewImage extends StatefulWidget {
  final productId;
  ViewImage({Key? key, this.productId}) : super(key: key);

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  List<String> productImage = [];

  int showSubImage = 0;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        leading: IconButton(onPressed: (){Navigator.pop(context);} ,icon: Icon(Icons.cancel,color: Colors.black,)),
        backgroundColor: Colors.white,
        title: Text("Image Detail",style: constantFontStyle(color: Colors.black,fontSize: 14),),
      ),
      body: isLoading == true
          ?Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
          : SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height/1.6,
              child: CachedNetworkImage(
                color: Colors.white,
                fit: BoxFit.cover,
                imageUrl: productImage[showSubImage],
                imageBuilder: (context, imageProvider) => PhotoView(
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.8,
                //  enableRotation: true,

                  backgroundDecoration: BoxDecoration(color: Colors.white),
                  imageProvider: imageProvider,
                ),
                placeholder: (context, url) => Center(
                  child: Image.asset("assets/images/image_loader.gif"),
                ),
                errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
              ),
            ),
            Container(height: 70, child: subImages()),
          ],
        ),
      ),
    );
  }

  Widget subImages() {
    return ListView.builder(
      itemCount: productImage.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showSubImage = index;
                });
              },
              child: Container(
                height: 65,
                width: 65,


                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.transparent),
                child: Card(
                //  elevation: 5,
                  shape:  RoundedRectangleBorder(
                      side:  BorderSide(color: productImage[showSubImage] == productImage[index]?themeColor:Colors.grey.shade300, width: productImage[showSubImage] == productImage[index]?1:1,),
                      borderRadius: BorderRadius.circular(4.0)),

                  elevation: productImage[showSubImage] == productImage[index]?10:0,
        color: Colors.transparent,
                  child:  CachedNetworkImage(imageUrl: productImage[index],
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),
                          placeholder: (context, url) => Center(
                            child: Image.asset("assets/images/image_loader.gif"),

                          )


                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  GetData() async {
    var response = await http
        .get(Uri.parse("$productDetailsApi?product=${widget.productId}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      debugPrint(data.toString() + "Data");

      productImage.clear();

      for (int i = 0; i < data["result"]["imgs"].length; i++) {
        productImage.add(data["result"]["imgs"][i]["imgpath"]);
      }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error in the Api");
    }
  }


}
