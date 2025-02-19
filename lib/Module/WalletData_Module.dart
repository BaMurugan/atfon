// To parse this JSON data, do
//
//     final walletData = walletDataFromMap(jsonString);

import 'dart:convert';

WalletData walletDataFromMap(String str) =>
    WalletData.fromMap(json.decode(str));

String walletDataToMap(WalletData data) => json.encode(data.toMap());

class WalletData {
  List<Map<String, String?>> walletTransactions;
  int totalTransactions;
  int totalPages;
  int currentPage;

  WalletData({
    required this.walletTransactions,
    required this.totalTransactions,
    required this.totalPages,
    required this.currentPage,
  });

  factory WalletData.fromMap(Map<String, dynamic> json) => WalletData(
        walletTransactions: List<Map<String, String?>>.from(
            json["walletTransactions"].map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
        totalTransactions: json["totalTransactions"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  get length => null;

  Map<String, dynamic> toMap() => {
        "walletTransactions": List<dynamic>.from(walletTransactions.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "totalTransactions": totalTransactions,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}
