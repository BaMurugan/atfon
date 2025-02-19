// To parse this JSON data, do
//
//     final serviceArea = serviceAreaFromJson(jsonString);

import 'dart:convert';

ServiceArea serviceAreaFromJson(String str) =>
    ServiceArea.fromJson(json.decode(str));

String serviceAreaToJson(ServiceArea data) => json.encode(data.toJson());

class ServiceArea {
  List<Datum>? data;
  String? message;

  ServiceArea({
    this.data,
    this.message,
  });

  factory ServiceArea.fromJson(Map<String, dynamic> json) => ServiceArea(
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
  String? name;
  List<String>? serviceableAreas;
  String? state;
  String? district;

  Datum({
    this.id,
    this.name,
    this.serviceableAreas,
    this.state,
    this.district,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        serviceableAreas: json["serviceableAreas"] == null
            ? []
            : List<String>.from(json["serviceableAreas"]!.map((x) => x)),
        state: json["state"],
        district: json["district"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "serviceableAreas": serviceableAreas == null
            ? []
            : List<dynamic>.from(serviceableAreas!.map((x) => x)),
        "state": state,
        "district": district,
      };
}
