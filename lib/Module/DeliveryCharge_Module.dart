// To parse this JSON data, do
//
//     final deliveryChargeModule = deliveryChargeModuleFromMap(jsonString);

import 'dart:convert';

DeliveryChargeModule deliveryChargeModuleFromMap(String str) =>
    DeliveryChargeModule.fromMap(json.decode(str));

String deliveryChargeModuleToMap(DeliveryChargeModule data) =>
    json.encode(data.toMap());

class DeliveryChargeModule {
  List<Datum>? data;
  String? message;

  DeliveryChargeModule({
    this.data,
    this.message,
  });

  factory DeliveryChargeModule.fromMap(Map<String, dynamic> json) =>
      DeliveryChargeModule(
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
  String? type;
  String? name;
  bool? deleted;
  String? commissionRate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.type,
    this.name,
    this.deleted,
    this.commissionRate,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        deleted: json["deleted"],
        commissionRate: json["commissionRate"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "name": name,
        "deleted": deleted,
        "commissionRate": commissionRate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
