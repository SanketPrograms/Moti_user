import 'package:big_basket/screens/product_details/product_details_api.dart';
import 'package:big_basket/screens/product_details/product_details_new.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

const bannerImage2 =
    "https://www.payworldindia.com/wp-content/uploads/2021/01/banner-10-bill-payment-1.png";
const bannerImage =
    "https://i1.wp.com/momobud.sg/wp-content/uploads/2015/01/Picture4-1537x500.png?resize=1090%2C355";

const bannerImage3 = "https://image.freepik.com/free-vector/hello-summer-tropic-fruits-banner_1268-11173.jpg";

Widget HomeSlidingImage(BannerImage) {
  List<int> imageLength = [];
  for (int i = 0; i < BannerImage.length; i++) {
    imageLength.add(i);
  }
  debugPrint("this is i $imageLength");
  return Container(
    // height: 80,
    child: CarouselSlider(
      options: CarouselOptions(

        // height: 200,
        aspectRatio: 9 / 3,

        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        // reverse: false,

        autoPlay: true,

        // autoPlayInterval: Duration(seconds: 10),
        //autoPlayAnimationDuration: Duration(milliseconds: 100),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        autoPlayAnimationDuration:
        Duration(seconds: 3),
        scrollDirection: Axis.horizontal,
      ),
      items: imageLength.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(

              onTap: (){
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             ProductDetailsNew(
                //               productId: BannerID[i],
                //             )));

              },
              //  height:90,



              child: Container(
                // height: 100,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(),
                child: Container(
                  // height: 100,
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(BannerImage[i]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    ),
  );
}