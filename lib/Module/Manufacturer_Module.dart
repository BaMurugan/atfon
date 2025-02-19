// To parse this JSON data, do
//
//     final manufacturersModel = manufacturersModelFromMap(jsonString);

import 'dart:convert';

ManufacturersModel manufacturersModelFromMap(String str) =>
    ManufacturersModel.fromMap(json.decode(str));

String manufacturersModelToMap(ManufacturersModel data) =>
    json.encode(data.toMap());

class ManufacturersModel {
  List<Datum>? data;
  String? message;

  ManufacturersModel({
    this.data,
    this.message,
  });

  factory ManufacturersModel.fromMap(Map<String, dynamic> json) =>
      ManufacturersModel(
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
  String? logoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
