// To parse this JSON data, do
//
//     final sellerQuoteModule = sellerQuoteModuleFromMap(jsonString);

import 'dart:convert';

SellerQuoteModule sellerQuoteModuleFromMap(String str) =>
    SellerQuoteModule.fromMap(json.decode(str));

String sellerQuoteModuleToMap(SellerQuoteModule data) =>
    json.encode(data.toMap());

class SellerQuoteModule {
  Data? data;
  String? message;

  SellerQuoteModule({
    this.data,
    this.message,
  });

  factory SellerQuoteModule.fromMap(Map<String, dynamic> json) =>
      SellerQuoteModule(
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
  List<QuoteLineItem>? quoteLineItems;
  List<DeliveryCharge>? deliveryCharges;
  QuoteRequest? quoteRequest;
  List<dynamic>? previousQuotes;
  DeliveryAddress? deliveryAddress;

  Data({
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
    this.quoteLineItems,
    this.deliveryCharges,
    this.quoteRequest,
    this.previousQuotes,
    this.deliveryAddress,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
        quoteLineItems: json["quoteLineItems"] == null
            ? []
            : List<QuoteLineItem>.from(
                json["quoteLineItems"]!.map((x) => QuoteLineItem.fromMap(x))),
        deliveryCharges: json["deliveryCharges"] == null
            ? []
            : List<DeliveryCharge>.from(
                json["deliveryCharges"]!.map((x) => DeliveryCharge.fromMap(x))),
        quoteRequest: json["quoteRequest"] == null
            ? null
            : QuoteRequest.fromMap(json["quoteRequest"]),
        previousQuotes: json["previousQuotes"] == null
            ? []
            : List<dynamic>.from(json["previousQuotes"]!.map((x) => x)),
        deliveryAddress: json["deliveryAddress"] == null
            ? null
            : DeliveryAddress.fromMap(json["deliveryAddress"]),
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
        "quoteLineItems": quoteLineItems == null
            ? []
            : List<dynamic>.from(quoteLineItems!.map((x) => x.toMap())),
        "deliveryCharges": deliveryCharges == null
            ? []
            : List<dynamic>.from(deliveryCharges!.map((x) => x.toMap())),
        "quoteRequest": quoteRequest?.toMap(),
        "previousQuotes": previousQuotes == null
            ? []
            : List<dynamic>.from(previousQuotes!.map((x) => x)),
        "deliveryAddress": deliveryAddress?.toMap(),
      };
}

class DeliveryAddress {
  String? id;
  String? pincode;

  DeliveryAddress({
    this.id,
    this.pincode,
  });

  factory DeliveryAddress.fromMap(Map<String, dynamic> json) => DeliveryAddress(
        id: json["id"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "pincode": pincode,
      };
}

class DeliveryCharge {
  String? id;
  String? type;
  String? charge;
  String? commissionRate;
  String? commissionAmount;
  DateTime? createdAt;

  DeliveryCharge({
    this.id,
    this.type,
    this.charge,
    this.commissionRate,
    this.commissionAmount,
    this.createdAt,
  });

  factory DeliveryCharge.fromMap(Map<String, dynamic> json) => DeliveryCharge(
        id: json["id"],
        type: json["type"],
        charge: json["charge"],
        commissionRate: json["commissionRate"],
        commissionAmount: json["commissionAmount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "charge": charge,
        "commissionRate": commissionRate,
        "commissionAmount": commissionAmount,
        "createdAt": createdAt?.toIso8601String(),
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
  String? uomValue;
  String? alternateUomValue;
  bool? isToleranceApplicableProduct;
  String? productUom;
  bool? isUomChanged;

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
    this.uomValue,
    this.alternateUomValue,
    this.isToleranceApplicableProduct,
    this.productUom,
    this.isUomChanged,
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
        uomValue: json["uomValue"],
        alternateUomValue: json["alternateUomValue"],
        isToleranceApplicableProduct: json["isToleranceApplicableProduct"],
        productUom: json["productUom"],
        isUomChanged: json["isUomChanged"],
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

class QuoteRequest {
  String? id;
  String? userId;
  String? deliveryAddressId;
  DeliveryPreference? deliveryPreference;
  bool? selfPickup;
  String? status;
  DateTime? validUntil;
  bool? processed;
  dynamic selfPickupPincode;
  DateTime? createdAt;
  DateTime? updatedAt;
  DeliveryAddress? deliveryAddress;

  QuoteRequest({
    this.id,
    this.userId,
    this.deliveryAddressId,
    this.deliveryPreference,
    this.selfPickup,
    this.status,
    this.validUntil,
    this.processed,
    this.selfPickupPincode,
    this.createdAt,
    this.updatedAt,
    this.deliveryAddress,
  });

  factory QuoteRequest.fromMap(Map<String, dynamic> json) => QuoteRequest(
        id: json["id"],
        userId: json["userId"],
        deliveryAddressId: json["deliveryAddressId"],
        deliveryPreference: json["deliveryPreference"] == null
            ? null
            : DeliveryPreference.fromMap(json["deliveryPreference"]),
        selfPickup: json["selfPickup"],
        status: json["status"],
        validUntil: json["validUntil"] == null
            ? null
            : DateTime.parse(json["validUntil"]),
        processed: json["processed"],
        selfPickupPincode: json["selfPickupPincode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deliveryAddress: json["deliveryAddress"] == null
            ? null
            : DeliveryAddress.fromMap(json["deliveryAddress"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "deliveryAddressId": deliveryAddressId,
        "deliveryPreference": deliveryPreference?.toMap(),
        "selfPickup": selfPickup,
        "status": status,
        "validUntil": validUntil?.toIso8601String(),
        "processed": processed,
        "selfPickupPincode": selfPickupPincode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deliveryAddress": deliveryAddress?.toMap(),
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
