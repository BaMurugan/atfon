// To parse this JSON data, do
//
//     final notificationDataModule = notificationDataModuleFromMap(jsonString);

import 'dart:convert';

NotificationDataModule notificationDataModuleFromMap(String str) =>
    NotificationDataModule.fromMap(json.decode(str));

String notificationDataModuleToMap(NotificationDataModule data) =>
    json.encode(data.toMap());

class NotificationDataModule {
  List<Datum>? data;
  String? message;

  NotificationDataModule({
    this.data,
    this.message,
  });

  factory NotificationDataModule.fromMap(Map<String, dynamic> json) =>
      NotificationDataModule(
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
  String? id;
  String? userId;
  String? eventType;
  String? eventMessage;
  bool? dismiss;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.eventType,
    this.eventMessage,
    this.dismiss,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["userId"],
        eventType: json["eventType"],
        eventMessage: json["eventMessage"],
        dismiss: json["dismiss"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "eventType": eventType,
        "eventMessage": eventMessage,
        "dismiss": dismiss,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
