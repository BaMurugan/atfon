// To parse this JSON data, do
//
//     final wallet = walletFromMap(jsonString);

import 'dart:convert';

Wallet walletFromMap(String str) => Wallet.fromMap(json.decode(str));

String walletToMap(Wallet data) => json.encode(data.toMap());

class Wallet {
  String id;
  String userId;
  String balance;

  Wallet({
    required this.id,
    required this.userId,
    required this.balance,
  });

  factory Wallet.fromMap(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        userId: json["userId"],
        balance: json["balance"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "balance": balance,
      };
}
