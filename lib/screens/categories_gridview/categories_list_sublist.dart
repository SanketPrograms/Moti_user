import 'dart:convert';

import 'package:big_basket/Widgets/myaccount_appbar.dart';
import 'package:big_basket/constants/apis.dart';
import 'package:big_basket/constants/constant.dart';
import 'package:big_basket/services/fetch_product_subtlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Categories_subCat_List extends StatefulWidget {
  const Categories_subCat_List({Key? key}) : super(key: key);

  @override
  _Categories_subCat_ListState createState() => _Categories_subCat_ListState();
}

class _Categories_subCat_ListState extends State<Categories_subCat_List> {
  List<String> categoryName = [];
  List<String> categoryImage = [];
  List<String> subcategoryName = [];
  List<String> fruitName = [];
  List<String> categoryId = [];

  var subList = [];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getCategoryData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
    //  appBar: customAppBar("Categories"),
          body: isLoading == true
              ?Center(child: Image.asset("assets/images/loading_page.gif",scale: 3,))
              :SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height:SizedBoxSize),

                  SizedBox(

                    // height: MediaQuery.of(context).size.height - 100,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),

                      itemBuilder: _buildList,
                      //  itemCount: roles.length,
                      itemCount: categoryName.length,
                      shrinkWrap: true,
                    ),
                  )
                ],
              ),
            ),
        );
  }

  Widget _buildList(BuildContext context, int index) {
    return GestureDetector(
      onTap: (){},
      child: ExpansionTile(
      
          title: Row(
            children: [
              Expanded(flex: 1,child: Padding(
                padding: const EdgeInsets.all(paddingAllTwo),
                child: Card(

                  //elevation: elevation_size,
                  child: Container(

                      height:60,child:
                  ClipRRect(
                      borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(00.0),
                          topLeft: Radius.circular(10.0)),
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) => Image.network("https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"),

                        placeholder: (context, url) => Center(
                          child: Center(
                            child: Image.asset("assets/images/image_loader.gif"),
                          ),),
                        imageUrl: categoryImage[index],

                       // width: MediaQuery.of(context).size.width/1.9,
                        fit: BoxFit.fitHeight,

                      ))

                  ),
                ),
              ),),
               Expanded(
                 flex: 2,
                 child: Padding(
                   padding: const EdgeInsets.all(12.0),
                   child: Text(categoryName[index],
                        style: constantFontStyle(
                            fontSize: TitleFontsize, fontWeight: FontWeight.bold)),
                 ),
               ),


            ],
          ),
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: _buildRolesList,
              itemCount: subcategoryName.length,
            ),
          ]),
    );
  }

  Widget _buildRolesList(BuildContext context, int index) {
    return ListTile(
      // dense: true,
      // title: Text(roles[index]),
      title: Column(
        children: [
      const Divider(
              thickness: 1,



          ),
       Center(
                  child: Text(
                    subcategoryName[index],
            style: constantFontStyle(fontSize: Fontsize),
          ))
        ],
      ),
      onTap: () {},
    );
  }

  // getData() async {
  //   var response = await http.get(Uri.parse(categoriesSublistApi));
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //
  //     categoryName.clear();
  //     categoryImage.clear();
  //
  //     var s = [];
  //
  //     for (int i = 0; i < jsonResponse["data"].length; i++) {
  //       categoryName.add(jsonResponse["data"][i]["category_name"]);
  //       categoryImage.add(jsonResponse["data"][i]["image_category"]);
  //
  //       for (int j = 0;
  //           j < jsonResponse["data"][i]["sub_categories"].length;
  //           j++) {
  //         s.add(jsonResponse["data"][i]["sub_categories"][j]
  //                 ["sub_category_name"]
  //             .toString());
  //       }
  //     }
  //
  //     subList = s;
  //
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } else {
  //     debugPrint("Error in the Api");
  //   }
  // }


  getCategoryData() async {
    var response = await http.get(Uri.parse(categoriesSublistApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      categoryName.clear();
      categoryImage.clear();
      categoryId.clear();



      var s = [];

      for (int i = 0; i < data["result"].length; i++) {
        categoryName.add(data["result"][i]["name"]);
        categoryImage.add(data["result"][i]["imgpath"]);
        categoryId.add(data["result"][i]["id"]);

        // for (int j = 0;
        // j < jsonResponse["data"][i]["sub_categories"].length;
        // j++) {
        //   s.add(jsonResponse["data"][i]["sub_categories"][j]
        //   ["sub_category_name"]
        //       .toString());
        // }
      }

      // subList = s;

      setState(() {
        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }
  getsubcategoryData(categoryid) async {
    var response = await http.get(Uri.parse("$subCategoriesApi?category=${categoryid}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // categoryName.clear();
      // categoryImage.clear();
      subcategoryName.clear();

      var s = [];

      for (int i = 0; i < data["result"].length; i++) {
        subcategoryName.add(data["result"][i]["name"]);
      //  subcategoryImage.add(data["result"][i]["imgpath"]);
     //   SubcategoryId.add(data["result"][i]["id"]);

        // for (int j = 0;
        // j < jsonResponse["data"][i]["sub_categories"].length;
        // j++) {
        //   s.add(jsonResponse["data"][i]["sub_categories"][j]
        //   ["sub_category_name"]
        //       .toString());
        // }
      }

      // subList = s;

      setState(() {
        isLoading = false;
      });
    } else {
      debugPrint("Error in the Api");
    }
  }
}
