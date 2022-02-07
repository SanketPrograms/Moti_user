import 'package:big_basket/screens/product_details/product_details_api.dart';
import 'package:big_basket/screens/product_details/product_details_new.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';



Widget SlidingImage(BannerImage, BannerID) {
  ValueNotifier current = ValueNotifier(0);

  final CarouselController _controller = CarouselController();


  List<int> imageLength = [];
  for (int i = 0; i < BannerImage.length; i++) {
    imageLength.add(i);
  }
  debugPrint("this is i $imageLength");
  return Column(
    children: [
      Container(
        // height: 80,
        child: CarouselSlider(
          options: CarouselOptions(
            // height: 200,
            aspectRatio: 9 / 3,
            onPageChanged: (index, reason) {
              // setState(() {
              current.value = index;
              // });
            },
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            // reverse: false,

            autoPlay: true,

            // autoPlayInterval: Duration(seconds: 10),
            //autoPlayAnimationDuration: Duration(milliseconds: 100),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            autoPlayAnimationDuration: Duration(seconds: 3),
            scrollDirection: Axis.horizontal,
          ),
          items: imageLength.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailsNew(
                                  productId: BannerID[i],
                                )));
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
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageLength.asMap().entries.map((entry) {
          return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child:ValueListenableBuilder(
                  valueListenable: current,
                  builder: (context, value, child) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                              .withOpacity(current.value == entry.key ? 0.9 : 0.4)),
                    );
                  }
              )
          );
        }).toList(),
      )

    ],
  );
}
