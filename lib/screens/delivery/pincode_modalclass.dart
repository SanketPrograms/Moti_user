// To parse this JSON data, do
//
//     final pincodeModalclass = pincodeModalclassFromJson(jsonString);

import 'dart:convert';

List<PincodeModalclass> pincodeModalclassFromJson(String str) => List<PincodeModalclass>.from(json.decode(str).map((x) => PincodeModalclass.fromJson(x)));

String pincodeModalclassToJson(List<PincodeModalclass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PincodeModalclass {
  PincodeModalclass({
    this.id,
    this.pincode,
    this.dcharge,
  });

  String? id;
  String? pincode;
  String? dcharge;

  factory PincodeModalclass.fromJson(Map<String, dynamic> json) => PincodeModalclass(
    id: json["id"],
    pincode: json["pincode"],
    dcharge: json["dcharge"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pincode": pincode,
    "dcharge": dcharge,
  };
}
