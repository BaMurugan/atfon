// To parse this JSON data, do
//
//     final enquirie = enquirieFromMap(jsonString);

import 'dart:convert';

Enquirie enquirieFromMap(String str) => Enquirie.fromMap(json.decode(str));

String enquirieToMap(Enquirie data) => json.encode(data.toMap());

class Enquirie {
  Data? data;
  String? message;

  Enquirie({
    this.data,
    this.message,
  });

  factory Enquirie.fromMap(Map<String, dynamic> json) => Enquirie(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? totalQuoteEnquiries;
  List<QuoteEnquiry>? quoteEnquiries;
  int? currentPage;
  int? totalPages;
  List<dynamic>? aggregations;

  Data({
    this.totalQuoteEnquiries,
    this.quoteEnquiries,
    this.currentPage,
    this.totalPages,
    this.aggregations,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        totalQuoteEnquiries: json["totalQuoteEnquiries"],
        quoteEnquiries: json["quoteEnquiries"] == null
            ? []
            : List<QuoteEnquiry>.from(
                json["quoteEnquiries"]!.map((x) => QuoteEnquiry.fromMap(x))),
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        aggregations: json["aggregations"] == null
            ? []
            : List<dynamic>.from(json["aggregations"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "totalQuoteEnquiries": totalQuoteEnquiries,
        "quoteEnquiries": quoteEnquiries == null
            ? []
            : List<dynamic>.from(quoteEnquiries!.map((x) => x.toMap())),
        "currentPage": currentPage,
        "totalPages": totalPages,
        "aggregations": aggregations == null
            ? []
            : List<dynamic>.from(aggregations!.map((x) => x)),
      };
}

class QuoteEnquiry {
  String? id;
  String? status;
  dynamic reason;
  String? distance;
  String? deliveryPincode;
  bool? selfPickup;
  String? selfPickupPincode;
  DateTime? validUntil;
  DateTime? createdAt;
  List<QuoteEnquiryItem>? quoteEnquiryItems;
  dynamic previousQuoteId;
  DeliveryPreference? deliveryPreference;
  String? quoteRequestStatus;

  QuoteEnquiry({
    this.id,
    this.status,
    this.reason,
    this.distance,
    this.deliveryPincode,
    this.selfPickup,
    this.selfPickupPincode,
    this.validUntil,
    this.createdAt,
    this.quoteEnquiryItems,
    this.previousQuoteId,
    this.deliveryPreference,
    this.quoteRequestStatus,
  });

  factory QuoteEnquiry.fromMap(Map<String, dynamic> json) => QuoteEnquiry(
        id: json["id"],
        status: json["status"],
        reason: json["reason"],
        distance: json["distance"],
        deliveryPincode: json["deliveryPincode"],
        selfPickup: json["selfPickup"],
        selfPickupPincode: json["selfPickupPincode"],
        validUntil: json["validUntil"] == null
            ? null
            : DateTime.parse(json["validUntil"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        quoteEnquiryItems: json["quoteEnquiryItems"] == null
            ? []
            : List<QuoteEnquiryItem>.from(json["quoteEnquiryItems"]!
                .map((x) => QuoteEnquiryItem.fromMap(x))),
        previousQuoteId: json["previousQuoteId"],
        deliveryPreference: json["deliveryPreference"] == null
            ? null
            : DeliveryPreference.fromMap(json["deliveryPreference"]),
        quoteRequestStatus: json["quoteRequestStatus"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "reason": reason,
        "distance": distance,
        "deliveryPincode": deliveryPincode,
        "selfPickup": selfPickup,
        "selfPickupPincode": selfPickupPincode,
        "validUntil": validUntil?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "quoteEnquiryItems": quoteEnquiryItems == null
            ? []
            : List<dynamic>.from(quoteEnquiryItems!.map((x) => x.toMap())),
        "previousQuoteId": previousQuoteId,
        "deliveryPreference": deliveryPreference?.toMap(),
        "quoteRequestStatus": quoteRequestStatus,
      };
}

class DeliveryPreference {
  DateTime? expectedDeliveryDate;
  String? expectedDeliveryTime;

  DeliveryPreference({
    this.expectedDeliveryDate,
    this.expectedDeliveryTime,
  });

  factory DeliveryPreference.fromMap(Map<String, dynamic> json) =>
      DeliveryPreference(
        expectedDeliveryDate: json["expectedDeliveryDate"] == null
            ? null
            : DateTime.parse(json["expectedDeliveryDate"]),
        expectedDeliveryTime: json["expectedDeliveryTime"],
      );

  Map<String, dynamic> toMap() => {
        "expectedDeliveryDate": expectedDeliveryDate?.toIso8601String(),
        "expectedDeliveryTime": expectedDeliveryTime,
      };
}

class QuoteEnquiryItem {
  String? id;
  String? productId;
  String? units;
  String? uom;
  String? name;
  String? alternateUom;
  String? manufacturerName;
  String? imageUrl;
  String? sectorType;

  QuoteEnquiryItem({
    this.id,
    this.productId,
    this.units,
    this.uom,
    this.name,
    this.alternateUom,
    this.manufacturerName,
    this.imageUrl,
    this.sectorType,
  });

  factory QuoteEnquiryItem.fromMap(Map<String, dynamic> json) =>
      QuoteEnquiryItem(
        id: json["id"],
        productId: json["productId"],
        units: json["units"],
        uom: json["uom"],
        name: json["name"],
        alternateUom: json["alternateUom"],
        manufacturerName: json["manufacturerName"],
        imageUrl: json["imageUrl"],
        sectorType: json["sectorType"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
        "units": units,
        "uom": uom,
        "name": name,
        "alternateUom": alternateUom,
        "manufacturerName": manufacturerName,
        "imageUrl": imageUrl,
        "sectorType": sectorType,
      };
}
