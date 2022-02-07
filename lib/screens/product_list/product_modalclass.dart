class Product {
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.brand,
    required this.discount,
    required this.description,
    required this.status,
    required this.deleted,
    required this.dt,
    required this.vendor,
    required this.findicator,
    required this.shopName,
    required this.inCart,
    required this.imgs,
    required this.opts,
  });

  String id;
  String name;
  String category;
  String subcategory;
  String brand;
  String discount;
  String description;
  String status;
  String deleted;
  DateTime dt;
  String vendor;
  String findicator;
  String shopName;
  String inCart;
  List<Img> imgs;
  List<Opt> opts;

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
    shopName: json["shop_name"],
    inCart: json["in_cart"],
    imgs: List<Img>.from(json["imgs"].map((x) => Img.fromJson(x))),
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
    "dt": dt.toIso8601String(),
    "vendor": vendor,
    "findicator": findicator,
    "shop_name": shopName,
    "in_cart": inCart,
    "imgs": List<dynamic>.from(imgs.map((x) => x.toJson())),
    "opts": List<dynamic>.from(opts.map((x) => x.toJson())),
  };
}

class Img {
  Img({
    required this.id,
    required this.product,
    required this.imgpath,
    required this.deleted,
    required this.dt,
  });

  String id;
  String product;
  String imgpath;
  String deleted;
  DateTime dt;

  factory Img.fromJson(Map<String, dynamic> json) => Img(
    id: json["id"],
    product: json["product"],
    imgpath: json["imgpath"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product,
    "imgpath": imgpath,
    "deleted": deleted,
    "dt": dt.toIso8601String(),
  };
}

class Opt {
  Opt({
    required this.id,
    required this.product,
    required this.variants,
    required this.price,
    required this.deleted,
    required this.dt,
    required this.discount,
    required this.dprice,
  });

  String id;
  String product;
  String variants;
  String price;
  String deleted;
  DateTime dt;
  int discount;
  String dprice;

  factory Opt.fromJson(Map<String, dynamic> json) => Opt(
    id: json["id"],
    product: json["product"],
    variants: json["variants"],
    price: json["price"],
    deleted: json["deleted"],
    dt: DateTime.parse(json["dt"]),
    discount: json["discount"],
    dprice: json["dprice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product,
    "variants": variants,
    "price": price,
    "deleted": deleted,
    "dt": dt.toIso8601String(),
    "discount": discount,
    "dprice": dprice,
  };
}