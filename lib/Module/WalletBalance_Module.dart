// To parse this JSON data, do
//
//     final walletBalance = walletBalanceFromJson(jsonString);

import 'dart:convert';

WalletBalance walletBalanceFromJson(String str) => WalletBalance.fromJson(json.decode(str));

String walletBalanceToJson(WalletBalance data) => json.encode(data.toJson());

class WalletBalance {
  Data? data;
  String? message;

  WalletBalance({
    this.data,
    this.message,
  });

  factory WalletBalance.fromJson(Map<String, dynamic> json) => WalletBalance(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? id;
  String? userId;
  String? balance;
  String? amountOnHold;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.balance,
    this.amountOnHold,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["userId"],
    balance: json["balance"],
    amountOnHold: json["amountOnHold"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "balance": balance,
    "amountOnHold": amountOnHold,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
