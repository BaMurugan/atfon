// To parse this JSON data, do
//
//     final uomModule = uomModuleFromJson(jsonString);

import 'dart:convert';

UomModule uomModuleFromJson(String str) => UomModule.fromJson(json.decode(str));

String uomModuleToJson(UomModule data) => json.encode(data.toJson());

class UomModule {
  List<Datum>? data;
  String? message;

  UomModule({
    this.data,
    this.message,
  });

  factory UomModule.fromJson(Map<String, dynamic> json) => UomModule(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int? id;
  String? value;
  String? description;
  int? decimalPlaces;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.value,
    this.description,
    this.decimalPlaces,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        value: json["value"],
        description: json["description"],
        decimalPlaces: json["decimalPlaces"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "description": description,
        "decimalPlaces": decimalPlaces,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
