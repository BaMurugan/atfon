// To parse this JSON data, do
//
//     final pincodeModule = pincodeModuleFromJson(jsonString);

import 'dart:convert';

PincodeModule pincodeModuleFromJson(String str) =>
    PincodeModule.fromJson(json.decode(str));

String pincodeModuleToJson(PincodeModule data) => json.encode(data.toJson());

class PincodeModule {
  Data? data;
  String? message;

  PincodeModule({
    this.data,
    this.message,
  });

  factory PincodeModule.fromJson(Map<String, dynamic> json) => PincodeModule(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  List<Pincode>? pincodes;
  int? totalPincodes;
  int? totalPages;
  int? currentPage;

  Data({
    this.pincodes,
    this.totalPincodes,
    this.totalPages,
    this.currentPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pincodes: json["pincodes"] == null
            ? []
            : List<Pincode>.from(
                json["pincodes"]!.map((x) => Pincode.fromJson(x))),
        totalPincodes: json["totalPincodes"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "pincodes": pincodes == null
            ? []
            : List<dynamic>.from(pincodes!.map((x) => x.toJson())),
        "totalPincodes": totalPincodes,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Pincode {
  String? id;
  String? pincode;
  String? district;
  String? subDistrict;
  String? state;
  bool? buyerAvailabilityPincode;
  bool? sellerAvailabilityPincode;
  bool? isBuyerAreaPincodeEnabled;
  bool? isSellerAreaPincodeEnabled;

  Pincode({
    this.id,
    this.pincode,
    this.district,
    this.subDistrict,
    this.state,
    this.buyerAvailabilityPincode,
    this.sellerAvailabilityPincode,
    this.isBuyerAreaPincodeEnabled,
    this.isSellerAreaPincodeEnabled,
  });

  factory Pincode.fromJson(Map<String, dynamic> json) => Pincode(
        id: json["id"],
        pincode: json["pincode"],
        district: json["district"]!,
        subDistrict: json["subDistrict"],
        state: json["state"]!,
        buyerAvailabilityPincode: json["buyerAvailabilityPincode"],
        sellerAvailabilityPincode: json["sellerAvailabilityPincode"],
        isBuyerAreaPincodeEnabled: json["isBuyerAreaPincodeEnabled"],
        isSellerAreaPincodeEnabled: json["isSellerAreaPincodeEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pincode": pincode,
        "district": district,
        "subDistrict": subDistrict,
        "state": state,
        "buyerAvailabilityPincode": buyerAvailabilityPincode,
        "sellerAvailabilityPincode": sellerAvailabilityPincode,
        "isBuyerAreaPincodeEnabled": isBuyerAreaPincodeEnabled,
        "isSellerAreaPincodeEnabled": isSellerAreaPincodeEnabled,
      };
}
