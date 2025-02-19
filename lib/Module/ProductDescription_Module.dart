// To parse this JSON data, do
//
//     final productDescriptionModule = productDescriptionModuleFromMap(jsonString);

import 'dart:convert';

ProductDescriptionModule productDescriptionModuleFromMap(String str) =>
    ProductDescriptionModule.fromMap(json.decode(str));

String productDescriptionModuleToMap(ProductDescriptionModule data) =>
    json.encode(data.toMap());

class ProductDescriptionModule {
  Data? data;
  String? message;

  ProductDescriptionModule({
    this.data,
    this.message,
  });

  factory ProductDescriptionModule.fromMap(Map<String, dynamic> json) =>
      ProductDescriptionModule(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
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
  Manufacturer? manufacturer;
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
  ProductSpecTemplate? productSpecTemplate;
  String? returnPolicy;
  String? uomValue;
  String? alternateUomValue;
  List<dynamic>? productImages;
  ProductSpec? productSpec;
  Variant? variant;

  Data({
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
    this.manufacturer,
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
    this.productSpecTemplate,
    this.returnPolicy,
    this.uomValue,
    this.alternateUomValue,
    this.productImages,
    this.productSpec,
    this.variant,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
        manufacturer: json["manufacturer"] == null
            ? null
            : Manufacturer.fromMap(json["manufacturer"]),
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
        productSpecTemplate: json["productSpecTemplate"] == null
            ? null
            : ProductSpecTemplate.fromMap(json["productSpecTemplate"]),
        returnPolicy: json["returnPolicy"],
        uomValue: json["uomValue"],
        alternateUomValue: json["alternateUomValue"],
        productImages: json["productImages"] == null
            ? []
            : List<dynamic>.from(json["productImages"]!.map((x) => x)),
        productSpec: json["productSpec"] == null
            ? null
            : ProductSpec.fromMap(json["productSpec"]),
        variant:
            json["variant"] == null ? null : Variant.fromMap(json["variant"]),
      );

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
        "manufacturer": manufacturer?.toMap(),
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
        "productSpecTemplate": productSpecTemplate?.toMap(),
        "returnPolicy": returnPolicy,
        "uomValue": uomValue,
        "alternateUomValue": alternateUomValue,
        "productImages": productImages == null
            ? []
            : List<dynamic>.from(productImages!.map((x) => x)),
        "productSpec": productSpec?.toMap(),
        "variant": variant?.toMap(),
      };
}

class Manufacturer {
  int? id;
  String? name;
  String? logoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  Manufacturer({
    this.id,
    this.name,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Manufacturer.fromMap(Map<String, dynamic> json) => Manufacturer(
        id: json["id"],
        name: json["name"],
        logoUrl: json["logoUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "logoUrl": logoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class ProductSpec {
  int? id;
  int? templateId;
  String? productId;
  List<Spec>? spec;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProductSpecTemplate? specTempalte;

  ProductSpec({
    this.id,
    this.templateId,
    this.productId,
    this.spec,
    this.createdAt,
    this.updatedAt,
    this.specTempalte,
  });

  factory ProductSpec.fromMap(Map<String, dynamic> json) => ProductSpec(
        id: json["id"],
        templateId: json["templateId"],
        productId: json["productId"],
        spec: json["spec"] == null
            ? []
            : List<Spec>.from(json["spec"]!.map((x) => Spec.fromMap(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        specTempalte: json["specTempalte"] == null
            ? null
            : ProductSpecTemplate.fromMap(json["specTempalte"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "templateId": templateId,
        "productId": productId,
        "spec":
            spec == null ? [] : List<dynamic>.from(spec!.map((x) => x.toMap())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "specTempalte": specTempalte?.toMap(),
      };
}

class Spec {
  String? field;
  int? order;
  String? value;
  String? dataType;
  bool? optional;
  List<String>? fixedValues;

  Spec({
    this.field,
    this.order,
    this.value,
    this.dataType,
    this.optional,
    this.fixedValues,
  });

  factory Spec.fromMap(Map<String, dynamic> json) => Spec(
        field: json["field"],
        order: json["order"],
        value: json["value"],
        dataType: json["dataType"],
        optional: json["optional"],
        fixedValues: json["fixedValues"] == null
            ? []
            : List<String>.from(json["fixedValues"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "field": field,
        "order": order,
        "value": value,
        "dataType": dataType,
        "optional": optional,
        "fixedValues": fixedValues == null
            ? []
            : List<dynamic>.from(fixedValues!.map((x) => x)),
      };
}

class ProductSpecTemplate {
  int? id;
  String? hierarchyType;
  String? hierarchyId;
  List<Spec>? template;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductSpecTemplate({
    this.id,
    this.hierarchyType,
    this.hierarchyId,
    this.template,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductSpecTemplate.fromMap(Map<String, dynamic> json) =>
      ProductSpecTemplate(
        id: json["id"],
        hierarchyType: json["hierarchyType"],
        hierarchyId: json["hierarchyId"],
        template: json["template"] == null
            ? []
            : List<Spec>.from(json["template"]!.map((x) => Spec.fromMap(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "hierarchyType": hierarchyType,
        "hierarchyId": hierarchyId,
        "template": template == null
            ? []
            : List<dynamic>.from(template!.map((x) => x.toMap())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Variant {
  String? id;
  String? variantType;
  String? subvariantType;
  List<VariantProduct>? variantProducts;

  Variant({
    this.id,
    this.variantType,
    this.subvariantType,
    this.variantProducts,
  });

  factory Variant.fromMap(Map<String, dynamic> json) => Variant(
        id: json["id"],
        variantType: json["variantType"],
        subvariantType: json["subvariantType"],
        variantProducts: json["variantProducts"] == null
            ? []
            : List<VariantProduct>.from(
                json["variantProducts"]!.map((x) => VariantProduct.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "variantType": variantType,
        "subvariantType": subvariantType,
        "variantProducts": variantProducts == null
            ? []
            : List<dynamic>.from(variantProducts!.map((x) => x.toMap())),
      };
}

class VariantProduct {
  String? id;
  String? name;
  String? size;
  String? subtype;

  VariantProduct({
    this.id,
    this.name,
    this.size,
    this.subtype,
  });

  factory VariantProduct.fromMap(Map<String, dynamic> json) => VariantProduct(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        subtype: json["subtype"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "size": size,
        "subtype": subtype,
      };
}
