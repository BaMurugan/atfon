// To parse this JSON data, do
//
//     final minMaxModule = minMaxModuleFromMap(jsonString);

import 'dart:convert';

MinMaxModule minMaxModuleFromMap(String str) =>
    MinMaxModule.fromMap(json.decode(str));

String minMaxModuleToMap(MinMaxModule data) => json.encode(data.toMap());

class MinMaxModule {
  List<Datum>? data;
  String? message;

  MinMaxModule({
    this.data,
    this.message,
  });

  factory MinMaxModule.fromMap(Map<String, dynamic> json) => MinMaxModule(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
      };
}

class Datum {
  String? id;
  String? sellerProductId;
  String? productId;
  String? pincode;
  dynamic serviceableDistance;
  int? maximumQuantity;
  int? minimumQuantity;
  String? sellerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  SellerProduct? sellerProduct;
  Product? product;

  Datum({
    this.id,
    this.sellerProductId,
    this.productId,
    this.pincode,
    this.serviceableDistance,
    this.maximumQuantity,
    this.minimumQuantity,
    this.sellerId,
    this.createdAt,
    this.updatedAt,
    this.sellerProduct,
    this.product,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sellerProductId: json["sellerProductId"],
        productId: json["productId"],
        pincode: json["pincode"],
        serviceableDistance: json["serviceableDistance"],
        maximumQuantity: json["maximumQuantity"],
        minimumQuantity: json["minimumQuantity"],
        sellerId: json["sellerId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        sellerProduct: json["sellerProduct"] == null
            ? null
            : SellerProduct.fromMap(json["sellerProduct"]),
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sellerProductId": sellerProductId,
        "productId": productId,
        "pincode": pincode,
        "serviceableDistance": serviceableDistance,
        "maximumQuantity": maximumQuantity,
        "minimumQuantity": minimumQuantity,
        "sellerId": sellerId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "sellerProduct": sellerProduct?.toMap(),
        "product": product?.toMap(),
      };
}

class Product {
  String? uom;

  Product({
    this.uom,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        uom: json["uom"],
      );

  Map<String, dynamic> toMap() => {
        "uom": uom,
      };
}

class SellerProduct {
  String? sellerId;
  String? productId;

  SellerProduct({
    this.sellerId,
    this.productId,
  });

  factory SellerProduct.fromMap(Map<String, dynamic> json) => SellerProduct(
        sellerId: json["sellerId"],
        productId: json["productId"],
      );

  Map<String, dynamic> toMap() => {
        "sellerId": sellerId,
        "productId": productId,
      };
}
