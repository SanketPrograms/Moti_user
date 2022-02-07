// To parse this JSON data, do
//
//     final homeDataModalClass = homeDataModalClassFromJson(jsonString);

import 'dart:convert';

HomeDataModalClass homeDataModalClassFromJson(String str) => HomeDataModalClass.fromJson(json.decode(str));

String homeDataModalClassToJson(HomeDataModalClass data) => json.encode(data.toJson());

class HomeDataModalClass {
  HomeDataModalClass({
    this.status,
    this.error,
    this.success,
    this.result,
  });

  String? status;
  int? error;
  int? success;
  List<Result>? result;

  factory HomeDataModalClass.fromJson(Map<String, dynamic> json) => HomeDataModalClass(
    status: json["status"],
    error: json["error"],
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "success": success,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.name,
    this.imgs,
    this.products,
  });

  String? id;
  String? name;
  List<ResultImg>? imgs;
  List<Product>? products;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    imgs: List<ResultImg>.from(json["imgs"].map((x) => ResultImg.fromJson(x))),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imgs": List<dynamic>.from(imgs!.map((x) => x.toJson())),
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class ResultImg {
  ResultImg({
    this.imgpath,
  });

  String? imgpath;

  factory ResultImg.fromJson(Map<String, dynamic> json) => ResultImg(
    imgpath: json["imgpath"],
  );

  Map<String, dynamic> toJson() => {
    "imgpath": imgpath,
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.category,
    this.subcategory,
    this.brand,
    this.discount,
    this.description,
    this.status,
    this.deleted,
    this.dt,
    this.vendor,
    this.findicator,
    this.homecat,
    this.pincodes,
    this.stock,
    this.shopName,
    this.inCart,
    this.inCartQty,
    this.product,
    this.imgs,
    this.opts,
  });

  String? id;
  String? name;
  String? category;
  String? subcategory;
  String? brand;
  String? discount;
  String? description;
  String? status;
  String? deleted;
  DateTime? dt;
  String? vendor;
  String? findicator;
  String? homecat;
  String? pincodes;
  String? stock;
  ShopName? shopName;
  String? inCart;
  String? inCartQty;
  String? product;
  List<ProductImg>? imgs;
  List<Opt>? opts;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    subcategory: json["subcategory"],
    brand: json["brand"],
    discount: json["discount"],
    description: json["description"],
    status: json["status"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
    vendor: json["vendor"],
    findicator: json["findicator"],
    homecat: json["homecat"],
    pincodes: json["pincodes"] == null ? null : json["pincodes"],
    stock: json["stock"],
    shopName: shopNameValues.map![json["shop_name"]],
    inCart: json["in_cart"],
    inCartQty: json["in_cart_qty"],
    product: json["product"] == null ? null : json["product"],
    imgs: List<ProductImg>.from(json["imgs"].map((x) => ProductImg.fromJson(x))),
    opts: List<Opt>.from(json["opts"].map((x) => Opt.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category,
    "subcategory": subcategory,
    "brand": brand,
    "discount": discount,
    "description": description,
    "status": status,
    "deleted": deleted,
    "dt": dt!.toIso8601String(),
    "vendor": vendor,
    "findicator": findicator,
    "homecat": homecat,
    "pincodes": pincodes == null ? null : pincodes,
    "stock": stock,
    "shop_name": shopNameValues.reverse![shopName],
    "in_cart": inCart,
    "in_cart_qty": inCartQty,
    "product": product == null ? null : product,
    "imgs": List<dynamic>.from(imgs!.map((x) => x.toJson())),
    "opts": List<dynamic>.from(opts!.map((x) => x.toJson())),
  };
}

class ProductImg {
  ProductImg({
    this.id,
    this.product,
    this.imgpath,
    this.deleted,
    this.dt,
    this.iorder,
  });

  String? id;
  String? product;
  String? imgpath;
  String? deleted;
  DateTime? dt;
  String? iorder;

  factory ProductImg.fromJson(Map<String, dynamic> json) => ProductImg(
    id: json["id"],
    product: json["product"],
    imgpath: json["imgpath"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
    iorder: json["iorder"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product,
    "imgpath": imgpath,
    "deleted": deleted,
    "dt": dt!.toIso8601String(),
    "iorder": iorder,
  };
}

class Opt {
  Opt({
    this.id,
    this.product,
    this.variants,
    this.price,
    this.deleted,
    this.dt,
    this.variantStr,
    this.discount,
    this.dprice,
  });

  String? id;
  String? product;
  String? variants;
  String? price;
  String? deleted;
  DateTime? dt;
  String? variantStr;
  int? discount;
  String? dprice;

  factory Opt.fromJson(Map<String, dynamic> json) => Opt(
    id: json["id"],
    product: json["product"],
    variants: json["variants"],
    price: json["price"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
    variantStr: json["variant_str"],
    discount: json["discount"],
    dprice: json["dprice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product,
    "variants": variants,
    "price": price,
    "deleted": deleted,
    "dt": dt!.toIso8601String(),
    "variant_str": variantStr,
    "discount": discount,
    "dprice": dprice,
  };
}

enum ShopName { MOTI_CONFECTIONERY }

final shopNameValues = EnumValues({
  "Moti Confectionery": ShopName.MOTI_CONFECTIONERY
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
