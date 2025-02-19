// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

ProductModel productModelFromMap(String str) =>
    ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
  Data? data;
  String? message;

  ProductModel({
    this.data,
    this.message,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? totalProducts;
  List<Product>? products;
  int? totalPages;
  int? currentPage;

  Data({
    this.totalProducts,
    this.products,
    this.totalPages,
    this.currentPage,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        totalProducts: json["totalProducts"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromMap(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalProducts": totalProducts,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Product {
  String? id;
  String? name;
  String? description;
  String? uom;
  String? alternateUom;
  String? hsnCode;
  String? size;
  String? subtype;
  String? registeredOrPl;
  int? manufacturerId;
  int? brandId;
  dynamic manufacturerProductId;
  String? imageUrl;
  String? bisStandard;
  String? brouchureOrSpec;
  String? sectorType;
  dynamic relatedGroupId;
  String? variantId;
  int? branchId;
  int? subcategoryId;
  bool? toleranceApplicable;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? requiredMeasurements;
  List<String>? tags;
  String? code;
  String? returnPolicy;
  String? uomValue;
  String? alternateUomValue;
  String? gstRate;
  bool? isDiscontinued;

  Product({
    this.id,
    this.name,
    this.description,
    this.uom,
    this.alternateUom,
    this.hsnCode,
    this.size,
    this.subtype,
    this.registeredOrPl,
    this.manufacturerId,
    this.brandId,
    this.manufacturerProductId,
    this.imageUrl,
    this.bisStandard,
    this.brouchureOrSpec,
    this.sectorType,
    this.relatedGroupId,
    this.variantId,
    this.branchId,
    this.subcategoryId,
    this.toleranceApplicable,
    this.createdAt,
    this.updatedAt,
    this.requiredMeasurements,
    this.tags,
    this.code,
    this.returnPolicy,
    this.uomValue,
    this.alternateUomValue,
    this.gstRate,
    this.isDiscontinued,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        uom: json["uom"],
        alternateUom: json["alternateUom"],
        hsnCode: json["hsnCode"],
        size: json["size"],
        subtype: json["subtype"],
        registeredOrPl: json["registeredOrPl"],
        manufacturerId: json["manufacturerId"],
        brandId: json["brandId"],
        manufacturerProductId: json["manufacturerProductId"],
        imageUrl: json["imageUrl"],
        bisStandard: json["bisStandard"],
        brouchureOrSpec: json["brouchureOrSpec"],
        sectorType: json["sectorType"],
        relatedGroupId: json["relatedGroupId"],
        variantId: json["variantId"],
        branchId: json["branchId"],
        subcategoryId: json["subcategoryId"],
        toleranceApplicable: json["toleranceApplicable"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        requiredMeasurements: json["requiredMeasurements"] == null
            ? []
            : List<dynamic>.from(json["requiredMeasurements"]!.map((x) => x)),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        code: json["code"],
        returnPolicy: json["returnPolicy"],
        uomValue: json["uomValue"],
        alternateUomValue: json["alternateUomValue"],
        gstRate: json["gstRate"],
        isDiscontinued: json['isDiscontinued'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "uom": uom,
        "alternateUom": alternateUom,
        "hsnCode": hsnCode,
        "size": size,
        "subtype": subtype,
        "registeredOrPl": registeredOrPl,
        "manufacturerId": manufacturerId,
        "brandId": brandId,
        "manufacturerProductId": manufacturerProductId,
        "imageUrl": imageUrl,
        "bisStandard": bisStandard,
        "brouchureOrSpec": brouchureOrSpec,
        "sectorType": sectorType,
        "relatedGroupId": relatedGroupId,
        "variantId": variantId,
        "branchId": branchId,
        "subcategoryId": subcategoryId,
        "toleranceApplicable": toleranceApplicable,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "requiredMeasurements": requiredMeasurements == null
            ? []
            : List<dynamic>.from(requiredMeasurements!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "code": code,
        "returnPolicy": returnPolicy,
        "uomValue": uomValue,
        "alternateUomValue": alternateUomValue,
        "gstRate": gstRate,
        'isDiscontinued': isDiscontinued
      };
}
