// To parse this JSON data, do
//
//     final gstSearchModule = gstSearchModuleFromMap(jsonString);

import 'dart:convert';

GstSearchModule gstSearchModuleFromMap(String str) =>
    GstSearchModule.fromMap(json.decode(str));

String gstSearchModuleToMap(GstSearchModule data) => json.encode(data.toMap());

class GstSearchModule {
  Data? data;

  GstSearchModule({
    this.data,
  });

  factory GstSearchModule.fromMap(Map<String, dynamic> json) => GstSearchModule(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class Data {
  String? id;
  String? gstin;
  String? tradeName;
  String? legalName;
  String? constitutionOfBusiness;
  String? stateJurisdiction;
  String? stateJurisdictionCode;
  String? status;
  String? registrationDate;
  String? cancellationDate;
  String? lastUpdatedDate;
  String? centreJurisdiction;
  String? centreJurisdictionCode;
  String? gstType;
  String? einvoiceStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Address>? addresses;

  Data({
    this.id,
    this.gstin,
    this.tradeName,
    this.legalName,
    this.constitutionOfBusiness,
    this.stateJurisdiction,
    this.stateJurisdictionCode,
    this.status,
    this.registrationDate,
    this.cancellationDate,
    this.lastUpdatedDate,
    this.centreJurisdiction,
    this.centreJurisdictionCode,
    this.gstType,
    this.einvoiceStatus,
    this.createdAt,
    this.updatedAt,
    this.addresses,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        gstin: json["gstin"],
        tradeName: json["tradeName"],
        legalName: json["legalName"],
        constitutionOfBusiness: json["constitutionOfBusiness"],
        stateJurisdiction: json["stateJurisdiction"],
        stateJurisdictionCode: json["stateJurisdictionCode"],
        status: json["status"],
        registrationDate: json["registrationDate"],
        cancellationDate: json["cancellationDate"],
        lastUpdatedDate: json["lastUpdatedDate"],
        centreJurisdiction: json["centreJurisdiction"],
        centreJurisdictionCode: json["centreJurisdictionCode"],
        gstType: json["gstType"],
        einvoiceStatus: json["einvoiceStatus"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "gstin": gstin,
        "tradeName": tradeName,
        "legalName": legalName,
        "constitutionOfBusiness": constitutionOfBusiness,
        "stateJurisdiction": stateJurisdiction,
        "stateJurisdictionCode": stateJurisdictionCode,
        "status": status,
        "registrationDate": registrationDate,
        "cancellationDate": cancellationDate,
        "lastUpdatedDate": lastUpdatedDate,
        "centreJurisdiction": centreJurisdiction,
        "centreJurisdictionCode": centreJurisdictionCode,
        "gstType": gstType,
        "einvoiceStatus": einvoiceStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toMap())),
      };
}

class Address {
  String? id;
  String? gstId;
  String? buildingName;
  String? buildingNumber;
  String? floorNumber;
  String? location;
  String? street;
  String? landMark;
  String? district;
  String? state;
  String? pincode;
  String? lat;
  String? lng;
  dynamic natureOfPlaceOfBusiness;
  bool? isPrincipalPlaceOfBusiness;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.gstId,
    this.buildingName,
    this.buildingNumber,
    this.floorNumber,
    this.location,
    this.street,
    this.landMark,
    this.district,
    this.state,
    this.pincode,
    this.lat,
    this.lng,
    this.natureOfPlaceOfBusiness,
    this.isPrincipalPlaceOfBusiness,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["id"],
        gstId: json["gstId"],
        buildingName: json["buildingName"],
        buildingNumber: json["buildingNumber"],
        floorNumber: json["floorNumber"],
        location: json["location"],
        street: json["street"],
        landMark: json["landMark"],
        district: json["district"],
        state: json["state"],
        pincode: json["pincode"],
        lat: json["lat"],
        lng: json["lng"],
        natureOfPlaceOfBusiness: json["natureOfPlaceOfBusiness"],
        isPrincipalPlaceOfBusiness: json["isPrincipalPlaceOfBusiness"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "gstId": gstId,
        "buildingName": buildingName,
        "buildingNumber": buildingNumber,
        "floorNumber": floorNumber,
        "location": location,
        "street": street,
        "landMark": landMark,
        "district": district,
        "state": state,
        "pincode": pincode,
        "lat": lat,
        "lng": lng,
        "natureOfPlaceOfBusiness": natureOfPlaceOfBusiness,
        "isPrincipalPlaceOfBusiness": isPrincipalPlaceOfBusiness,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
