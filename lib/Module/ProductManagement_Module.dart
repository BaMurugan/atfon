// To parse this JSON data, do
//
//     final productManagementModel = productManagementModelFromMap(jsonString);

import 'dart:convert';

ProductManagementModel productManagementModelFromMap(String str) =>
    ProductManagementModel.fromMap(json.decode(str));

String productManagementModelToMap(ProductManagementModel data) =>
    json.encode(data.toMap());

class ProductManagementModel {
  int? totalSellerProducts;
  List<SellerProduct>? sellerProducts;
  int? totalPages;
  int? currentPage;

  ProductManagementModel({
    this.totalSellerProducts,
    this.sellerProducts,
    this.totalPages,
    this.currentPage,
  });

  factory ProductManagementModel.fromMap(Map<String, dynamic> json) =>
      ProductManagementModel(
        totalSellerProducts: json["totalSellerProducts"],
        sellerProducts: json["sellerProducts"] == null
            ? []
            : List<SellerProduct>.from(
                json["sellerProducts"]!.map((x) => SellerProduct.fromMap(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalSellerProducts": totalSellerProducts,
        "sellerProducts": sellerProducts == null
            ? []
            : List<dynamic>.from(sellerProducts!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class SellerProduct {
  String? id;
  String? productId;
  List<String>? serviceAreaIds;
  List<String>? serviceableAreas;
  dynamic serviceableDistance;
  Product? product;

  SellerProduct({
    this.id,
    this.productId,
    this.serviceAreaIds,
    this.serviceableAreas,
    this.serviceableDistance,
    this.product,
  });

  factory SellerProduct.fromMap(Map<String, dynamic> json) => SellerProduct(
        id: json["id"],
        productId: json["productId"],
        serviceAreaIds: json["serviceAreaIds"] == null
            ? []
            : List<String>.from(json["serviceAreaIds"]!.map((x) => x)),
        serviceableAreas: json["serviceableAreas"] == null
            ? []
            : List<String>.from(json["serviceableAreas"]!.map((x) => x)),
        serviceableDistance: json["serviceableDistance"],
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
        "serviceAreaIds": serviceAreaIds == null
            ? []
            : List<dynamic>.from(serviceAreaIds!.map((x) => x)),
        "serviceableAreas": serviceableAreas == null
            ? []
            : List<dynamic>.from(serviceableAreas!.map((x) => x)),
        "serviceableDistance": serviceableDistance,
        "product": product?.toMap(),
      };
}

class Product {
  String? id;
  String? name;
  String? description;
  String? uom;
  String? alternateUom;
  String? gstRate;
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
  List<RequiredMeasurement>? requiredMeasurements;
  List<String>? tags;
  String? code;
  String? returnPolicy;
  String? uomValue;
  String? alternateUomValue;
  bool? isDiscontinued;

  Product({
    this.id,
    this.name,
    this.description,
    this.uom,
    this.alternateUom,
    this.gstRate,
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
    this.isDiscontinued,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      uom: json["uom"],
      alternateUom: json["alternateUom"],
      gstRate: json["gstRate"],
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
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      requiredMeasurements: json["requiredMeasurements"] == null
          ? []
          : List<RequiredMeasurement>.from(json["requiredMeasurements"]!
              .map((x) => RequiredMeasurement.fromMap(x))),
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
      code: json["code"],
      returnPolicy: json["returnPolicy"],
      uomValue: json["uomValue"],
      alternateUomValue: json["alternateUomValue"],
      isDiscontinued: json['isDiscontinued']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "uom": uom,
        "alternateUom": alternateUom,
        "gstRate": gstRate,
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
            : List<dynamic>.from(requiredMeasurements!.map((x) => x.toMap())),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "code": code,
        "returnPolicy": returnPolicy,
        "uomValue": uomValue,
        "alternateUomValue": alternateUomValue,
        'isDiscontinued': isDiscontinued
      };
}

class RequiredMeasurement {
  String? name;
  String? unit;
  String? valueType;
  List<String>? fixedValues;
  ValueRange? valueRange;

  RequiredMeasurement({
    this.name,
    this.unit,
    this.valueType,
    this.fixedValues,
    this.valueRange,
  });

  factory RequiredMeasurement.fromMap(Map<String, dynamic> json) =>
      RequiredMeasurement(
        name: json["name"],
        unit: json["unit"],
        valueType: json["valueType"],
        fixedValues: json["fixedValues"] == null
            ? []
            : List<String>.from(json["fixedValues"]!.map((x) => x)),
        valueRange: json["valueRange"] == null
            ? null
            : ValueRange.fromMap(json["valueRange"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "unit": unit,
        "valueType": valueType,
        "fixedValues": fixedValues == null
            ? []
            : List<dynamic>.from(fixedValues!.map((x) => x)),
        "valueRange": valueRange?.toMap(),
      };
}

class ValueRange {
  int? to;
  int? from;
  int? minUnit;

  ValueRange({
    this.to,
    this.from,
    this.minUnit,
  });

  factory ValueRange.fromMap(Map<String, dynamic> json) => ValueRange(
        to: json["to"],
        from: json["from"],
        minUnit: json["minUnit"],
      );

  Map<String, dynamic> toMap() => {
        "to": to,
        "from": from,
        "minUnit": minUnit,
      };
}
