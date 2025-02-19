// To parse this JSON data, do
//
//     final brandModel = brandModelFromMap(jsonString);

import 'dart:convert';

BrandModel brandModelFromMap(String str) =>
    BrandModel.fromMap(json.decode(str));

String brandModelToMap(BrandModel data) => json.encode(data.toMap());

class BrandModel {
  List<Datum>? data;
  String? message;

  BrandModel({
    this.data,
    this.message,
  });

  factory BrandModel.fromMap(Map<String, dynamic> json) => BrandModel(
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
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
