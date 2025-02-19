// To parse this JSON data, do
//
//     final selfPickUpModule = selfPickUpModuleFromMap(jsonString);

import 'dart:convert';

SelfPickUpModule selfPickUpModuleFromMap(String str) =>
    SelfPickUpModule.fromMap(json.decode(str));

String selfPickUpModuleToMap(SelfPickUpModule data) =>
    json.encode(data.toMap());

class SelfPickUpModule {
  Data? data;
  String? message;

  SelfPickUpModule({
    this.data,
    this.message,
  });

  factory SelfPickUpModule.fromMap(Map<String, dynamic> json) =>
      SelfPickUpModule(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? totalSellerSelfPickupPincodes;
  List<SellerSelfPickupPincode>? sellerSelfPickupPincodes;
  int? totalPages;
  int? currentPage;

  Data({
    this.totalSellerSelfPickupPincodes,
    this.sellerSelfPickupPincodes,
    this.totalPages,
    this.currentPage,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        totalSellerSelfPickupPincodes: json["totalSellerSelfPickupPincodes"],
        sellerSelfPickupPincodes: json["sellerSelfPickupPincodes"] == null
            ? []
            : List<SellerSelfPickupPincode>.from(
                json["sellerSelfPickupPincodes"]!
                    .map((x) => SellerSelfPickupPincode.fromMap(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalSellerSelfPickupPincodes": totalSellerSelfPickupPincodes,
        "sellerSelfPickupPincodes": sellerSelfPickupPincodes == null
            ? []
            : List<dynamic>.from(
                sellerSelfPickupPincodes!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class SellerSelfPickupPincode {
  String? id;
  String? name;
  List<String>? pincodes;

  SellerSelfPickupPincode({
    this.id,
    this.name,
    this.pincodes,
  });

  factory SellerSelfPickupPincode.fromMap(Map<String, dynamic> json) =>
      SellerSelfPickupPincode(
        id: json["id"],
        name: json["name"],
        pincodes: json["pincodes"] == null
            ? []
            : List<String>.from(json["pincodes"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "pincodes":
            pincodes == null ? [] : List<dynamic>.from(pincodes!.map((x) => x)),
      };
}
