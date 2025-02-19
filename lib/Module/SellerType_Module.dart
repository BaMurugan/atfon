// To parse this JSON data, do
//
//     final sellerTypeModule = sellerTypeModuleFromMap(jsonString);

import 'dart:convert';

SellerTypeModule sellerTypeModuleFromMap(String str) =>
    SellerTypeModule.fromMap(json.decode(str));

String sellerTypeModuleToMap(SellerTypeModule data) =>
    json.encode(data.toMap());

class SellerTypeModule {
  Data? data;
  String? message;

  SellerTypeModule({
    this.data,
    this.message,
  });

  factory SellerTypeModule.fromMap(Map<String, dynamic> json) =>
      SellerTypeModule(
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
  String? sellerId;
  String? userId;
  String? requestedType;
  String? currentType;
  String? status;
  bool? pendingOrders;
  dynamic processedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.sellerId,
    this.userId,
    this.requestedType,
    this.currentType,
    this.status,
    this.pendingOrders,
    this.processedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        sellerId: json["sellerId"],
        userId: json["userId"],
        requestedType: json["requestedType"],
        currentType: json["currentType"],
        status: json["status"],
        pendingOrders: json["pendingOrders"],
        processedAt: json["processedAt"],
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
        "userId": userId,
        "requestedType": requestedType,
        "currentType": currentType,
        "status": status,
        "pendingOrders": pendingOrders,
        "processedAt": processedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
