// To parse this JSON data, do
//
//     final rewardPointModule = rewardPointModuleFromJson(jsonString);

import 'dart:convert';

RewardPointModule rewardPointModuleFromJson(String str) =>
    RewardPointModule.fromJson(json.decode(str));

String rewardPointModuleToJson(RewardPointModule data) =>
    json.encode(data.toJson());

class RewardPointModule {
  List<Datum>? data;
  String? message;

  RewardPointModule({
    this.data,
    this.message,
  });

  factory RewardPointModule.fromJson(Map<String, dynamic> json) =>
      RewardPointModule(
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
  String? id;
  String? event;
  String? userId;
  String? referralCode;
  String? particulars;
  String? platformAllocated;
  String? pointsEarned;
  String? pointsRedeemed;
  String? totalPoints;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.event,
    this.userId,
    this.referralCode,
    this.particulars,
    this.platformAllocated,
    this.pointsEarned,
    this.pointsRedeemed,
    this.totalPoints,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        event: json["event"],
        userId: json["userId"],
        referralCode: json["referralCode"],
        particulars: json["particulars"],
        platformAllocated: json["platformAllocated"],
        pointsEarned: json["pointsEarned"],
        pointsRedeemed: json["pointsRedeemed"],
        totalPoints: json["totalPoints"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event": event,
        "userId": userId,
        "referralCode": referralCode,
        "particulars": particulars,
        "platformAllocated": platformAllocated,
        "pointsEarned": pointsEarned,
        "pointsRedeemed": pointsRedeemed,
        "totalPoints": totalPoints,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
