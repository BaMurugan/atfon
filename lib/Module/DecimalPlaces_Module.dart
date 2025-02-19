// To parse this JSON data, do
//
//     final decimalPlaceModule = decimalPlaceModuleFromJson(jsonString);

import 'dart:convert';

DecimalPlaceModule decimalPlaceModuleFromJson(String str) =>
    DecimalPlaceModule.fromJson(json.decode(str));

String decimalPlaceModuleToJson(DecimalPlaceModule data) =>
    json.encode(data.toJson());

class DecimalPlaceModule {
  Data? data;
  String? message;

  DecimalPlaceModule({
    this.data,
    this.message,
  });

  factory DecimalPlaceModule.fromJson(Map<String, dynamic> json) =>
      DecimalPlaceModule(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  String? value;
  String? description;
  int? decimalPlaces;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.value,
    this.description,
    this.decimalPlaces,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
