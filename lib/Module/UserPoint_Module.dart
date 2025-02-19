// To parse this JSON data, do
//
//     final userPoint = userPointFromMap(jsonString);

import 'dart:convert';

UserPoint userPointFromMap(String str) => UserPoint.fromMap(json.decode(str));

String userPointToMap(UserPoint data) => json.encode(data.toMap());

class UserPoint {
  Data? data;
  String? message;

  UserPoint({
    this.data,
    this.message,
  });

  factory UserPoint.fromMap(Map<String, dynamic> json) => UserPoint(
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
  String? userId;
  String? balance;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.balance,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["userId"],
    balance: json["balance"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userId": userId,
    "balance": balance,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
