import 'dart:convert';
import 'dart:ui';
import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/Widgets/sliding_image.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/screens/categories_gridview/categories_list_sublist.dart';
import 'package:big_basket/screens/product_list/product_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class ShopByCategories extends StatefulWidget {
  final categoryid;
  final categoryName;
  final BannerImageList;
  final BannerID;
   ShopByCategories({Key? key, this.categoryid, this.categoryName, this.BannerImageList, this.BannerID}) : super(key: key);

  @override
  State<ShopByCategories> createState() => _ShopByCategoriesState();
}

class _ShopByCategoriesState extends State<ShopByCategories> {
  bool isLoading =  true;

  List categoryName = [];

  List categoryImage = [];
  List SubcategoryId = [];
   var noProduct = 0;
  @override
  void initState() {
    // TODO: implement initState
    getData();
    // FetchHomePage().getData();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(widget.categoryName.toString()),
      body: isLoading
          ? Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,)):noProduct == 1 ? Card(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                      "assets/images/404_not_found.png",scale: 1.7,)),
              Text("Products Not Available!", style: constantFontStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent),)
            ],
          )):SingleChildScrollView(
                    child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(

          children: [
            const SizedBox(
              height: 0,
            ),
          Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child:  Container(
                    //  height:90,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: SlidingImage(widget.BannerImageList,widget.BannerID),
                    ),
                ),
              ),

            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orangeAccent.shade100, //background color of button
                              side: BorderSide(width:1.1, color:themeColor), //border width and color
                              elevation: 3, //elevation of button
                              // shape: RoundedRectangleBorder( //to set border radius to button
                              //     borderRadius: BorderRadius.circular(10)
                              // ),
                              padding: EdgeInsets.all(1) //content padding inside button
                          ),
                            onPressed: () {
                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories_subCat_List()));
                            },
                            child: Text(
                              "SHOP BY CATEGORIES",
                              style: constantFontStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ))),
                ),
              ],
            ),
             Padding(
                padding: const EdgeInsets.all(paddingAllTwo),
                child: Container(
                    child: dynamicGridView(),
                ),
              ),

           Padding(
                padding: const EdgeInsets.all(paddingAllTwo),
                child:  Container(
                     // height:90,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: SlidingImage(widget.BannerImageList,widget.BannerID),
                    ),

              ),
            ),
          ],
        ),
      ),
                  ),
    );
  }

  Widget dynamicGridView() {
    // print("this is findword $findWord");
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1,

            mainAxisSpacing: 8,
            childAspectRatio: 0.7),
        itemCount: categoryName.length,
        //  itemCount: title.length,
        shrinkWrap: true,
        //  physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductList(categoryName:categoryName[index],BannerImageList:widget.BannerImageList,BannerID:widget.BannerID,category:widget.categoryid,subcategory:SubcategoryId[index])));
            },
            child: Card(
              color: Colors.lightGreen.shade200,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: elevation_size,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                // margin: EdgeInsets.all(10),
                child: Column(
                  children: [

                    // subtitle: Text(description[index]),
                     Expanded(
                       flex: 3,
                       child: Padding(
                          padding: const EdgeInsets.all(paddingAllTwo),
                          child: Container(
                            height: MediaQuery.of(context).size.height/5.5,
                            child:
                          ClipRRect(
                              borderRadius: new BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0)),
                              child: CachedNetworkImage(
                                errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),

                                placeholder: (context, url) => Center(

                                    child: Image.asset("assets/images/image_loader.gif"),
                                  ),
                                imageUrl: categoryImage[index],



                             //   width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              )),

                          ),
                        ),
                     ),
                    
                    // Expanded(
                    //     flex: 4,
                    //     child: Image.network(
                    //         categoryImage[index],fit: BoxFit.fill,)),
                    Expanded(
                          //decoration: BoxDecoration(
                         //   color: Colors.black12,
                            // border: Border.all(),
                        //    borderRadius: const BorderRadius.all(Radius.circular(5)),
                       //   ),
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  categoryName[index],
                                  style: constantFontStyle(
                                      fontSize: Fontsize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )),
                        ),
                  ],
                )),
          );
        },
      );
    });
  }


  getData() async {
    var response = await http.get(Uri.parse("$subCategoriesApi?category=${widget.categoryid}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      debugPrint(data.toString());
      categoryName.clear();
      categoryImage.clear();
      SubcategoryId.clear();
      setState(() {
      var s = [];
          if(data["error"] == 1){

              noProduct = 1;
              isLoading = false;



            debugPrint("yess");
          }else {
            for (int i = 0; i < data["result"].length; i++) {
              categoryName.add(data["result"][i]["name"]);
              categoryImage.add(data["result"][i]["imgpath"]);
              SubcategoryId.add(data["result"][i]["id"]);

              // for (int j = 0;
              // j < jsonResponse["data"][i]["sub_categories"].length;
              // j++) {
              //   s.add(jsonResponse["data"][i]["sub_categories"][j]
              //   ["sub_category_name"]
              //       .toString());
              // }
            }

            // subList = s;


              isLoading = false;
          }
            });

    } else {
      debugPrint("Error in the Api");
    }
  }

}
