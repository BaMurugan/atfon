// To parse this JSON data, do
//
//     final itTaxModule = itTaxModuleFromMap(jsonString);

import 'dart:convert';

ItTaxModule itTaxModuleFromMap(String str) =>
    ItTaxModule.fromMap(json.decode(str));

String itTaxModuleToMap(ItTaxModule data) => json.encode(data.toMap());

class ItTaxModule {
  bool? success;
  List<Datum>? data;

  ItTaxModule({
    this.success,
    this.data,
  });

  factory ItTaxModule.fromMap(Map<String, dynamic> json) => ItTaxModule(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  String? id;
  String? sellerId;
  String? orderId;
  String? orderReferenceId;
  String? taxRule;
  String? orderValue;
  List<String>? invoices;
  List<dynamic>? credits;
  String? netValue;
  String? percentage;
  String? amount;
  String? sellerPan;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.sellerId,
    this.orderId,
    this.orderReferenceId,
    this.taxRule,
    this.orderValue,
    this.invoices,
    this.credits,
    this.netValue,
    this.percentage,
    this.amount,
    this.sellerPan,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sellerId: json["sellerId"],
        orderId: json["orderId"],
        orderReferenceId: json["orderReferenceId"],
        taxRule: json["taxRule"],
        orderValue: json["orderValue"],
        invoices: json["invoices"] == null
            ? []
            : List<String>.from(json["invoices"]!.map((x) => x)),
        credits: json["credits"] == null
            ? []
            : List<dynamic>.from(json["credits"]!.map((x) => x)),
        netValue: json["netValue"],
        percentage: json["percentage"],
        amount: json["amount"],
        sellerPan: json["sellerPan"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sellerId": sellerId,
        "orderId": orderId,
        "orderReferenceId": orderReferenceId,
        "taxRule": taxRule,
        "orderValue": orderValue,
        "invoices":
            invoices == null ? [] : List<dynamic>.from(invoices!.map((x) => x)),
        "credits":
            credits == null ? [] : List<dynamic>.from(credits!.map((x) => x)),
        "netValue": netValue,
        "percentage": percentage,
        "amount": amount,
        "sellerPan": sellerPan,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
