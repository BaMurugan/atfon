// To parse this JSON data, do
//
//     final profileAddress = profileAddressFromMap(jsonString);

import 'dart:convert';

ProfileAddress profileAddressFromMap(String str) =>
    ProfileAddress.fromMap(json.decode(str));

String profileAddressToMap(ProfileAddress data) => json.encode(data.toMap());

class ProfileAddress {
  List<Datum>? data;
  String? message;

  ProfileAddress({
    this.data,
    this.message,
  });

  factory ProfileAddress.fromMap(Map<String, dynamic> json) => ProfileAddress(
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
  dynamic addressName;
  String? partyName;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? district;
  String? state;
  String? pincode;
  String? phone;
  bool? defaultAddress;
  bool? profileAddress;
  String? mapLocation;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic contactPersonName;
  String? contactPhone;
  String? gstNumber;
  String? panNumber;
  String? gstFileName;
  String? panFileName;
  String? gstFileUrl;
  String? panFileUrl;
  dynamic deliveryType;

  Datum({
    this.id,
    this.userId,
    this.addressName,
    this.partyName,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.district,
    this.state,
    this.pincode,
    this.phone,
    this.defaultAddress,
    this.profileAddress,
    this.mapLocation,
    this.createdAt,
    this.updatedAt,
    this.contactPersonName,
    this.contactPhone,
    this.gstNumber,
    this.panNumber,
    this.gstFileName,
    this.panFileName,
    this.gstFileUrl,
    this.panFileUrl,
    this.deliveryType,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["userId"],
        addressName: json["addressName"],
        partyName: json["partyName"],
        addressLine1: json["addressLine_1"],
        addressLine2: json["addressLine_2"],
        city: json["city"],
        district: json["district"],
        state: json["state"],
        pincode: json["pincode"],
        phone: json["phone"],
        defaultAddress: json["defaultAddress"],
        profileAddress: json["profileAddress"],
        mapLocation: json["mapLocation"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        contactPersonName: json["contactPersonName"],
        contactPhone: json["contactPhone"],
        gstNumber: json["gstNumber"],
        panNumber: json["panNumber"],
        gstFileName: json["gstFileName"],
        panFileName: json["panFileName"],
        gstFileUrl: json["gstFileUrl"],
        panFileUrl: json["panFileUrl"],
        deliveryType: json["deliveryType"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "addressName": addressName,
        "partyName": partyName,
        "addressLine_1": addressLine1,
        "addressLine_2": addressLine2,
        "city": city,
        "district": district,
        "state": state,
        "pincode": pincode,
        "phone": phone,
        "defaultAddress": defaultAddress,
        "profileAddress": profileAddress,
        "mapLocation": mapLocation,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "contactPersonName": contactPersonName,
        "contactPhone": contactPhone,
        "gstNumber": gstNumber,
        "panNumber": panNumber,
        "gstFileName": gstFileName,
        "panFileName": panFileName,
        "gstFileUrl": gstFileUrl,
        "panFileUrl": panFileUrl,
        "deliveryType": deliveryType,
      };
}
