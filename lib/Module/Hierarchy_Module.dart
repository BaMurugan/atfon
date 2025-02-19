// To parse this JSON data, do
//
//     final hierarchyModel = hierarchyModelFromMap(jsonString);

import 'dart:convert';

HierarchyModel hierarchyModelFromMap(String str) => HierarchyModel.fromMap(json.decode(str));

String hierarchyModelToMap(HierarchyModel data) => json.encode(data.toMap());

class HierarchyModel {
    List<Datum>? data;
    String? message;

    HierarchyModel({
        this.data,
        this.message,
    });

    factory HierarchyModel.fromMap(Map<String, dynamic> json) => HierarchyModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
    };
}

class Datum {
    int? id;
    String? name;
    String? imageUrl;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    List<Subcategory>? subcategories;

    Datum({
        this.id,
        this.name,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.subcategories,
    });

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toMap())),
    };
}

class Subcategory {
    int? id;
    String? name;
    String? imageUrl;
    List<Subcategory>? branches;

    Subcategory({
        this.id,
        this.name,
        this.imageUrl,
        this.branches,
    });

    factory Subcategory.fromMap(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        branches: json["branches"] == null ? [] : List<Subcategory>.from(json["branches"]!.map((x) => Subcategory.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toMap())),
    };
}
