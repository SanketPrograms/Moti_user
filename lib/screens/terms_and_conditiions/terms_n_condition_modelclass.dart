// // To parse this JSON data, do
// //
// //     final termsAndCondition = termsAndConditionFromJson(jsonString);
//
// import 'dart:convert';
//
// TermsAndCondition termsAndConditionFromJson(String str) => TermsAndCondition.fromJson(json.decode(str));
//
// String termsAndConditionToJson(TermsAndCondition data) => json.encode(data.toJson());
//
// class TermsAndCondition {
//   TermsAndCondition({
//     this.status,
//     this.error,
//     this.success,
//     this.result,
//   });
//
//   String? status;
//   int? error;
//   int? success;
//   Result? result;
//
//   factory TermsAndCondition.fromJson(Map<String, dynamic> json) => TermsAndCondition(
//     status: json["status"],
//     error: json["error"],
//     success: json["success"],
//     result: Result.fromJson(json["result"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "error": error,
//     "success": success,
//     "result": result!.toJson(),
//   };
// }
//
// class Result {
//   Result({
//     this.id,
//     this.title,
//     this.logoImgpath,
//     this.favicon,
//     this.email,
//     this.phone,
//     this.terms,
//     this.termsUrl,
//     this.privacy,
//     this.privacyUrl,
//     this.deleted,
//     this.dt,
//     this.tax,
//   });
//
//   String? id;
//   String? title;
//   String? logoImgpath;
//   String? favicon;
//   String? email;
//   String? phone;
//   String? terms;
//   dynamic? termsUrl;
//   String? privacy;
//   dynamic? privacyUrl;
//   String? deleted;
//   DateTime? dt;
//   String? tax;
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     id: json["id"],
//     title: json["title"],
//     logoImgpath: json["logo_imgpath"],
//     favicon: json["favicon"],
//     email: json["email"],
//     phone: json["phone"],
//     terms: json["terms"],
//     termsUrl: json["terms_url"],
//     privacy: json["privacy"],
//     privacyUrl: json["privacy_url"],
//     deleted: json["deleted"],
//     dt: DateTime.parse(json["dt"]),
//     tax: json["tax"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "logo_imgpath": logoImgpath,
//     "favicon": favicon,
//     "email": email,
//     "phone": phone,
//     "terms": terms,
//     "terms_url": termsUrl,
//     "privacy": privacy,
//     "privacy_url": privacyUrl,
//     "deleted": deleted,
//     "dt": dt!.toIso8601String(),
//     "tax": tax,
//   };
// }
