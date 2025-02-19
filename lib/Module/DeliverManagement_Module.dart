// To parse this JSON data, do
//
//     final deliveryPersons = deliveryPersonsFromMap(jsonString);

import 'dart:convert';

DeliveryPersons deliveryPersonsFromMap(String str) =>
    DeliveryPersons.fromMap(json.decode(str));

String deliveryPersonsToMap(DeliveryPersons data) => json.encode(data.toMap());

class DeliveryPersons {
  Data? data;
  String? message;

  DeliveryPersons({
    this.data,
    this.message,
  });

  factory DeliveryPersons.fromMap(Map<String, dynamic> json) => DeliveryPersons(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? totalDeliveryPersons;
  List<DeliveryPerson>? deliveryPersons;
  int? totalPages;
  int? currentPage;

  Data({
    this.totalDeliveryPersons,
    this.deliveryPersons,
    this.totalPages,
    this.currentPage,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        totalDeliveryPersons: json["totalDeliveryPersons"],
        deliveryPersons: json["deliveryPersons"] == null
            ? []
            : List<DeliveryPerson>.from(
                json["deliveryPersons"]!.map((x) => DeliveryPerson.fromMap(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalDeliveryPersons": totalDeliveryPersons,
        "deliveryPersons": deliveryPersons == null
            ? []
            : List<dynamic>.from(deliveryPersons!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class DeliveryPerson {
  String? id;
  String? name;
  String? phoneNumber;
  String? vehicleNumber;

  DeliveryPerson({
    this.id,
    this.name,
    this.phoneNumber,
    this.vehicleNumber,
  });

  factory DeliveryPerson.fromMap(Map<String, dynamic> json) => DeliveryPerson(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        vehicleNumber: json["vehicleNumber"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "vehicleNumber": vehicleNumber,
      };
}
