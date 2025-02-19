// To parse this JSON data, do
//
//     final quotes = quotesFromMap(jsonString);

import 'dart:convert';

Quotes quotesFromMap(String str) => Quotes.fromMap(json.decode(str));

String quotesToMap(Quotes data) => json.encode(data.toMap());

class Quotes {
  Data? data;
  String? message;

  Quotes({
    this.data,
    this.message,
  });

  factory Quotes.fromMap(Map<String, dynamic> json) => Quotes(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? totalQuotes;
  List<Quote>? quotes;
  int? totalPages;
  int? currentPage;

  Data({
    this.totalQuotes,
    this.quotes,
    this.totalPages,
    this.currentPage,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        totalQuotes: json["totalQuotes"],
        quotes: json["quotes"] == null
            ? []
            : List<Quote>.from(json["quotes"]!.map((x) => Quote.fromMap(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalQuotes": totalQuotes,
        "quotes": quotes == null
            ? []
            : List<dynamic>.from(quotes!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Quote {
  String? id;
  String? status;
  String? sellerId;
  String? totalDeliveryCharge;
  String? deliveryChargeTax;
  String? deliveryChargeTaxRate;
  String? totalPrice;
  String? totalTax;
  String? totalCommission;
  DateTime? validUntil;
  DateTime? createdAt;
  DateTime? submittedAt;
  String? quoteEnquiryId;
  String? distance;
  int? lineItemsCount;
  bool? isUnloadPartyScope;
  String? totalDeliveryChargesCommission;
  String? quoteRequestStatus;
  List<QuoteLineItem>? quoteLineItems;
  List<dynamic>? deliveryCharges;
  List<dynamic>? previousQuotes;
  dynamic deliveryAddress;

  Quote({
    this.id,
    this.status,
    this.sellerId,
    this.totalDeliveryCharge,
    this.deliveryChargeTax,
    this.deliveryChargeTaxRate,
    this.totalPrice,
    this.totalTax,
    this.totalCommission,
    this.validUntil,
    this.createdAt,
    this.submittedAt,
    this.quoteEnquiryId,
    this.distance,
    this.lineItemsCount,
    this.isUnloadPartyScope,
    this.totalDeliveryChargesCommission,
    this.quoteRequestStatus,
    this.quoteLineItems,
    this.deliveryCharges,
    this.previousQuotes,
    this.deliveryAddress,
  });

  factory Quote.fromMap(Map<String, dynamic> json) => Quote(
        id: json["id"],
        status: json["status"],
        sellerId: json["sellerId"],
        totalDeliveryCharge: json["totalDeliveryCharge"],
        deliveryChargeTax: json["deliveryChargeTax"],
        deliveryChargeTaxRate: json["deliveryChargeTaxRate"],
        totalPrice: json["totalPrice"],
        totalTax: json["totalTax"],
        totalCommission: json["totalCommission"],
        validUntil: json["validUntil"] == null
            ? null
            : DateTime.parse(json["validUntil"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        submittedAt: json["submittedAt"] == null
            ? null
            : DateTime.parse(json["submittedAt"]),
        quoteEnquiryId: json["quoteEnquiryId"],
        distance: json["distance"],
        lineItemsCount: json["lineItemsCount"],
        isUnloadPartyScope: json["isUnloadPartyScope"],
        totalDeliveryChargesCommission: json["totalDeliveryChargesCommission"],
        quoteRequestStatus: json["quoteRequestStatus"],
        quoteLineItems: json["quoteLineItems"] == null
            ? []
            : List<QuoteLineItem>.from(
                json["quoteLineItems"]!.map((x) => QuoteLineItem.fromMap(x))),
        deliveryCharges: json["deliveryCharges"] == null
            ? []
            : List<dynamic>.from(json["deliveryCharges"]!.map((x) => x)),
        previousQuotes: json["previousQuotes"] == null
            ? []
            : List<dynamic>.from(json["previousQuotes"]!.map((x) => x)),
        deliveryAddress: json["deliveryAddress"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "sellerId": sellerId,
        "totalDeliveryCharge": totalDeliveryCharge,
        "deliveryChargeTax": deliveryChargeTax,
        "deliveryChargeTaxRate": deliveryChargeTaxRate,
        "totalPrice": totalPrice,
        "totalTax": totalTax,
        "totalCommission": totalCommission,
        "validUntil": validUntil?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "submittedAt": submittedAt?.toIso8601String(),
        "quoteEnquiryId": quoteEnquiryId,
        "distance": distance,
        "lineItemsCount": lineItemsCount,
        "isUnloadPartyScope": isUnloadPartyScope,
        "totalDeliveryChargesCommission": totalDeliveryChargesCommission,
        "quoteRequestStatus": quoteRequestStatus,
        "quoteLineItems": quoteLineItems == null
            ? []
            : List<dynamic>.from(quoteLineItems!.map((x) => x.toMap())),
        "deliveryCharges": deliveryCharges == null
            ? []
            : List<dynamic>.from(deliveryCharges!.map((x) => x)),
        "previousQuotes": previousQuotes == null
            ? []
            : List<dynamic>.from(previousQuotes!.map((x) => x)),
        "deliveryAddress": deliveryAddress,
      };
}

class QuoteLineItem {
  String? id;
  String? productId;
  String? units;
  String? uom;
  bool? excluded;
  bool? serviceableMinMaxQuantityExceeded;
  String? itemPrice;
  String? itemTotalPrice;
  String? gstRate;
  String? taxAmount;
  String? commissionRate;
  String? commissionAmount;
  String? name;
  String? alternateUom;
  String? manufacturerName;
  String? imageUrl;
  String? sectorType;
  DateTime? createdAt;
  bool? isSellerProduct;

  QuoteLineItem({
    this.id,
    this.productId,
    this.units,
    this.uom,
    this.excluded,
    this.serviceableMinMaxQuantityExceeded,
    this.itemPrice,
    this.itemTotalPrice,
    this.gstRate,
    this.taxAmount,
    this.commissionRate,
    this.commissionAmount,
    this.name,
    this.alternateUom,
    this.manufacturerName,
    this.imageUrl,
    this.sectorType,
    this.createdAt,
    this.isSellerProduct,
  });

  factory QuoteLineItem.fromMap(Map<String, dynamic> json) => QuoteLineItem(
        id: json["id"],
        productId: json["productId"],
        units: json["units"],
        uom: json["uom"],
        excluded: json["excluded"],
        serviceableMinMaxQuantityExceeded:
            json["serviceableMinMaxQuantityExceeded"],
        itemPrice: json["itemPrice"],
        itemTotalPrice: json["itemTotalPrice"],
        gstRate: json["gstRate"],
        taxAmount: json["taxAmount"],
        commissionRate: json["commissionRate"],
        commissionAmount: json["commissionAmount"],
        name: json["name"],
        alternateUom: json["alternateUom"],
        manufacturerName: json["manufacturerName"],
        imageUrl: json["imageUrl"],
        sectorType: json["sectorType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isSellerProduct: json["isSellerProduct"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
        "units": units,
        "uom": uom,
        "excluded": excluded,
        "serviceableMinMaxQuantityExceeded": serviceableMinMaxQuantityExceeded,
        "itemPrice": itemPrice,
        "itemTotalPrice": itemTotalPrice,
        "gstRate": gstRate,
        "taxAmount": taxAmount,
        "commissionRate": commissionRate,
        "commissionAmount": commissionAmount,
        "name": name,
        "alternateUom": alternateUom,
        "manufacturerName": manufacturerName,
        "imageUrl": imageUrl,
        "sectorType": sectorType,
        "createdAt": createdAt?.toIso8601String(),
        "isSellerProduct": isSellerProduct,
      };
}
