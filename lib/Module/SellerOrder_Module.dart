// To parse this JSON data, do
//
//     final sellerOrderModule = sellerOrderModuleFromMap(jsonString);

import 'dart:convert';

SellerOrderModule sellerOrderModuleFromMap(String str) =>
    SellerOrderModule.fromMap(json.decode(str));

String sellerOrderModuleToMap(SellerOrderModule data) =>
    json.encode(data.toMap());

class SellerOrderModule {
  Data? data;
  String? message;

  SellerOrderModule({
    this.data,
    this.message,
  });

  factory SellerOrderModule.fromMap(Map<String, dynamic> json) =>
      SellerOrderModule(
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
  String? sellerId;
  String? referenceId;
  bool? cancellationPermissionByAdmin;
  dynamic cancelReason;
  String? cancellationReasonByAdmin;
  dynamic cancelledAt;
  String? status;
  String? isAdminApprovedRefund;
  bool? isRefundRequested;
  bool? isOrderCancellationTimeExceeded;
  String? totalPrice;
  String? totalTax;
  String? totalCommission;
  dynamic dispatchedAt;
  dynamic deliveredAt;
  DateTime? createdAt;
  String? quoteId;
  int? lineItemsCount;
  DateTime? initialCancelationAllowedTime;
  bool? onHold;
  bool? sendQuoteAcceptedSms;
  bool? isSplitOrderCompleted;
  DateTime? paymentCreatedAt;
  Quote? quote;
  List<Shipment>? shipments;
  List<Item>? orderLineItems;
  Address? deliveryAddress;
  Address? billingAddress;
  Payment? payment;
  List<dynamic>? invoices;
  List<PendingSplitItem>? pendingSplitItems;
  AppliedDeliveryCharges? appliedDeliveryCharges;
  List<Item>? allShipmentItems;
  List<PendingShipmentLineItem>? pendingShipmentLineItems;
  List<Item>? splitOrderLineItems;
  List<AllShipmentDeliveryCharge>? allShipmentDeliveryCharges;
  List<PendingShipmentDeliveryCharge>? pendingShipmentDeliveryCharges;

  Data({
    this.id,
    this.sellerId,
    this.referenceId,
    this.cancellationPermissionByAdmin,
    this.cancelReason,
    this.cancellationReasonByAdmin,
    this.cancelledAt,
    this.status,
    this.isAdminApprovedRefund,
    this.isRefundRequested,
    this.isOrderCancellationTimeExceeded,
    this.totalPrice,
    this.totalTax,
    this.totalCommission,
    this.dispatchedAt,
    this.deliveredAt,
    this.createdAt,
    this.quoteId,
    this.lineItemsCount,
    this.initialCancelationAllowedTime,
    this.onHold,
    this.sendQuoteAcceptedSms,
    this.isSplitOrderCompleted,
    this.paymentCreatedAt,
    this.quote,
    this.shipments,
    this.orderLineItems,
    this.deliveryAddress,
    this.billingAddress,
    this.payment,
    this.invoices,
    this.pendingSplitItems,
    this.appliedDeliveryCharges,
    this.allShipmentItems,
    this.pendingShipmentLineItems,
    this.splitOrderLineItems,
    this.allShipmentDeliveryCharges,
    this.pendingShipmentDeliveryCharges,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        sellerId: json["sellerId"],
        referenceId: json["referenceId"],
        cancellationPermissionByAdmin: json["cancellationPermissionByAdmin"],
        cancelReason: json["cancelReason"],
        cancellationReasonByAdmin: json["cancellationReasonByAdmin"],
        cancelledAt: json["cancelledAt"],
        status: json["status"],
        isAdminApprovedRefund: json["isAdminApprovedRefund"],
        isRefundRequested: json["isRefundRequested"],
        isOrderCancellationTimeExceeded:
            json["isOrderCancellationTimeExceeded"],
        totalPrice: json["totalPrice"],
        totalTax: json["totalTax"],
        totalCommission: json["totalCommission"],
        dispatchedAt: json["dispatchedAt"],
        deliveredAt: json["deliveredAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        quoteId: json["quoteId"],
        lineItemsCount: json["lineItemsCount"],
        initialCancelationAllowedTime:
            json["initialCancelationAllowedTime"] == null
                ? null
                : DateTime.parse(json["initialCancelationAllowedTime"]),
        onHold: json["onHold"],
        sendQuoteAcceptedSms: json["sendQuoteAcceptedSms"],
        isSplitOrderCompleted: json["isSplitOrderCompleted"],
        paymentCreatedAt: json["paymentCreatedAt"] == null
            ? null
            : DateTime.parse(json["paymentCreatedAt"]),
        quote: json["quote"] == null ? null : Quote.fromMap(json["quote"]),
        shipments: json["shipments"] == null
            ? []
            : List<Shipment>.from(
                json["shipments"]!.map((x) => Shipment.fromMap(x))),
        orderLineItems: json["orderLineItems"] == null
            ? []
            : List<Item>.from(
                json["orderLineItems"]!.map((x) => Item.fromMap(x))),
        deliveryAddress: json["deliveryAddress"] == null
            ? null
            : Address.fromMap(json["deliveryAddress"]),
        billingAddress: json["billingAddress"] == null
            ? null
            : Address.fromMap(json["billingAddress"]),
        payment:
            json["payment"] == null ? null : Payment.fromMap(json["payment"]),
        invoices: json["invoices"] == null
            ? []
            : List<dynamic>.from(json["invoices"]!.map((x) => x)),
        pendingSplitItems: json["pendingSplitItems"] == null
            ? []
            : List<PendingSplitItem>.from(json["pendingSplitItems"]!
                .map((x) => PendingSplitItem.fromMap(x))),
        appliedDeliveryCharges: json["appliedDeliveryCharges"] == null
            ? null
            : AppliedDeliveryCharges.fromMap(json["appliedDeliveryCharges"]),
        allShipmentItems: json["allShipmentItems"] == null
            ? []
            : List<Item>.from(
                json["allShipmentItems"]!.map((x) => Item.fromMap(x))),
        pendingShipmentLineItems: json["pendingShipmentLineItems"] == null
            ? []
            : List<PendingShipmentLineItem>.from(
                json["pendingShipmentLineItems"]!
                    .map((x) => PendingShipmentLineItem.fromMap(x))),
        splitOrderLineItems: json["splitOrderLineItems"] == null
            ? []
            : List<Item>.from(
                json["splitOrderLineItems"]!.map((x) => Item.fromMap(x))),
        allShipmentDeliveryCharges: json["allShipmentDeliveryCharges"] == null
            ? []
            : List<AllShipmentDeliveryCharge>.from(
                json["allShipmentDeliveryCharges"]!
                    .map((x) => AllShipmentDeliveryCharge.fromMap(x))),
        pendingShipmentDeliveryCharges:
            json["pendingShipmentDeliveryCharges"] == null
                ? []
                : List<PendingShipmentDeliveryCharge>.from(
                    json["pendingShipmentDeliveryCharges"]!
                        .map((x) => PendingShipmentDeliveryCharge.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sellerId": sellerId,
        "referenceId": referenceId,
        "cancellationPermissionByAdmin": cancellationPermissionByAdmin,
        "cancelReason": cancelReason,
        "cancellationReasonByAdmin": cancellationReasonByAdmin,
        "cancelledAt": cancelledAt,
        "status": status,
        "isAdminApprovedRefund": isAdminApprovedRefund,
        "isRefundRequested": isRefundRequested,
        "isOrderCancellationTimeExceeded": isOrderCancellationTimeExceeded,
        "totalPrice": totalPrice,
        "totalTax": totalTax,
        "totalCommission": totalCommission,
        "dispatchedAt": dispatchedAt,
        "deliveredAt": deliveredAt,
        "createdAt": createdAt?.toIso8601String(),
        "quoteId": quoteId,
        "lineItemsCount": lineItemsCount,
        "initialCancelationAllowedTime":
            initialCancelationAllowedTime?.toIso8601String(),
        "onHold": onHold,
        "sendQuoteAcceptedSms": sendQuoteAcceptedSms,
        "isSplitOrderCompleted": isSplitOrderCompleted,
        "paymentCreatedAt": paymentCreatedAt?.toIso8601String(),
        "quote": quote?.toMap(),
        "shipments": shipments == null
            ? []
            : List<dynamic>.from(shipments!.map((x) => x.toMap())),
        "orderLineItems": orderLineItems == null
            ? []
            : List<dynamic>.from(orderLineItems!.map((x) => x.toMap())),
        "deliveryAddress": deliveryAddress?.toMap(),
        "billingAddress": billingAddress?.toMap(),
        "payment": payment?.toMap(),
        "invoices":
            invoices == null ? [] : List<dynamic>.from(invoices!.map((x) => x)),
        "pendingSplitItems": pendingSplitItems == null
            ? []
            : List<dynamic>.from(pendingSplitItems!.map((x) => x.toMap())),
        "appliedDeliveryCharges": appliedDeliveryCharges?.toMap(),
        "allShipmentItems": allShipmentItems == null
            ? []
            : List<dynamic>.from(allShipmentItems!.map((x) => x.toMap())),
        "pendingShipmentLineItems": pendingShipmentLineItems == null
            ? []
            : List<dynamic>.from(
                pendingShipmentLineItems!.map((x) => x.toMap())),
        "splitOrderLineItems": splitOrderLineItems == null
            ? []
            : List<dynamic>.from(splitOrderLineItems!.map((x) => x.toMap())),
        "allShipmentDeliveryCharges": allShipmentDeliveryCharges == null
            ? []
            : List<dynamic>.from(
                allShipmentDeliveryCharges!.map((x) => x.toMap())),
        "pendingShipmentDeliveryCharges": pendingShipmentDeliveryCharges == null
            ? []
            : List<dynamic>.from(
                pendingShipmentDeliveryCharges!.map((x) => x.toMap())),
      };
}

class AllShipmentDeliveryCharge {
  String? id;
  String? type;
  String? name;
  String? charge;
  String? commissionRate;
  String? commissionAmount;
  String? gstRate;
  String? shipmentId;

  AllShipmentDeliveryCharge({
    this.id,
    this.type,
    this.name,
    this.charge,
    this.commissionRate,
    this.commissionAmount,
    this.gstRate,
    this.shipmentId,
  });

  factory AllShipmentDeliveryCharge.fromMap(Map<String, dynamic> json) =>
      AllShipmentDeliveryCharge(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        charge: json["charge"],
        commissionRate: json["commissionRate"],
        commissionAmount: json["commissionAmount"],
        gstRate: json["gstRate"],
        shipmentId: json["shipmentId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "name": name,
        "charge": charge,
        "commissionRate": commissionRate,
        "commissionAmount": commissionAmount,
        "gstRate": gstRate,
        "shipmentId": shipmentId,
      };
}

class Item {
  String? id;
  String? productId;
  String? orderId;
  String? shipmentId;
  String? orderLineItemId;
  String? units;
  String? itemPrice;
  String? itemTotalPrice;
  String? gstRate;
  String? taxAmount;
  String? commissionAmount;
  String? commissionRate;
  String? name;
  String? uom;
  String? imageUrl;
  String? alternateUom;
  String? sectorType;
  DateTime? createdAt;
  String? hsnCode;
  bool? isToleranceApplied;
  String? manufacturerName;
  Product? product;

  Item({
    this.id,
    this.productId,
    this.orderId,
    this.shipmentId,
    this.orderLineItemId,
    this.units,
    this.itemPrice,
    this.itemTotalPrice,
    this.gstRate,
    this.taxAmount,
    this.commissionAmount,
    this.commissionRate,
    this.name,
    this.uom,
    this.imageUrl,
    this.alternateUom,
    this.sectorType,
    this.createdAt,
    this.hsnCode,
    this.isToleranceApplied,
    this.manufacturerName,
    this.product,
  });

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        productId: json["productId"],
        orderId: json["orderId"],
        shipmentId: json["shipmentId"],
        orderLineItemId: json["orderLineItemId"],
        units: json["units"],
        itemPrice: json["itemPrice"],
        itemTotalPrice: json["itemTotalPrice"],
        gstRate: json["gstRate"],
        taxAmount: json["taxAmount"],
        commissionAmount: json["commissionAmount"],
        commissionRate: json["commissionRate"],
        name: json["name"],
        uom: json["uom"],
        imageUrl: json["imageUrl"],
        alternateUom: json["alternateUom"],
        sectorType: json["sectorType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        hsnCode: json["hsnCode"],
        isToleranceApplied: json["isToleranceApplied"],
        manufacturerName: json["manufacturerName"],
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
        "orderId": orderId,
        "shipmentId": shipmentId,
        "orderLineItemId": orderLineItemId,
        "units": units,
        "itemPrice": itemPrice,
        "itemTotalPrice": itemTotalPrice,
        "gstRate": gstRate,
        "taxAmount": taxAmount,
        "commissionAmount": commissionAmount,
        "commissionRate": commissionRate,
        "name": name,
        "uom": uom,
        "imageUrl": imageUrl,
        "alternateUom": alternateUom,
        "sectorType": sectorType,
        "createdAt": createdAt?.toIso8601String(),
        "hsnCode": hsnCode,
        "isToleranceApplied": isToleranceApplied,
        "manufacturerName": manufacturerName,
        "product": product?.toMap(),
      };
}

class Product {
  String? id;
  String? name;
  String? description;
  String? uom;
  String? alternateUom;
  String? gstRate;
  String? hsnCode;
  String? size;
  String? subtype;
  String? registeredOrPl;
  int? manufacturerId;
  int? brandId;
  dynamic manufacturerProductId;
  Manufacturer? manufacturer;
  String? imageUrl;
  String? bisStandard;
  String? brouchureOrSpec;
  String? sectorType;
  dynamic relatedGroupId;
  String? variantId;
  int? branchId;
  int? subcategoryId;
  bool? toleranceApplicable;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? requiredMeasurements;
  List<String>? tags;
  String? code;
  String? returnPolicy;
  String? uomValue;
  String? alternateUomValue;

  Product({
    this.id,
    this.name,
    this.description,
    this.uom,
    this.alternateUom,
    this.gstRate,
    this.hsnCode,
    this.size,
    this.subtype,
    this.registeredOrPl,
    this.manufacturerId,
    this.brandId,
    this.manufacturerProductId,
    this.manufacturer,
    this.imageUrl,
    this.bisStandard,
    this.brouchureOrSpec,
    this.sectorType,
    this.relatedGroupId,
    this.variantId,
    this.branchId,
    this.subcategoryId,
    this.toleranceApplicable,
    this.createdAt,
    this.updatedAt,
    this.requiredMeasurements,
    this.tags,
    this.code,
    this.returnPolicy,
    this.uomValue,
    this.alternateUomValue,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        uom: json["uom"],
        alternateUom: json["alternateUom"],
        gstRate: json["gstRate"],
        hsnCode: json["hsnCode"],
        size: json["size"],
        subtype: json["subtype"],
        registeredOrPl: json["registeredOrPl"],
        manufacturerId: json["manufacturerId"],
        brandId: json["brandId"],
        manufacturerProductId: json["manufacturerProductId"],
        manufacturer: json["manufacturer"] == null
            ? null
            : Manufacturer.fromMap(json["manufacturer"]),
        imageUrl: json["imageUrl"],
        bisStandard: json["bisStandard"],
        brouchureOrSpec: json["brouchureOrSpec"],
        sectorType: json["sectorType"],
        relatedGroupId: json["relatedGroupId"],
        variantId: json["variantId"],
        branchId: json["branchId"],
        subcategoryId: json["subcategoryId"],
        toleranceApplicable: json["toleranceApplicable"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        requiredMeasurements: json["requiredMeasurements"] == null
            ? []
            : List<dynamic>.from(json["requiredMeasurements"]!.map((x) => x)),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        code: json["code"],
        returnPolicy: json["returnPolicy"],
        uomValue: json["uomValue"],
        alternateUomValue: json["alternateUomValue"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "uom": uom,
        "alternateUom": alternateUom,
        "gstRate": gstRate,
        "hsnCode": hsnCode,
        "size": size,
        "subtype": subtype,
        "registeredOrPl": registeredOrPl,
        "manufacturerId": manufacturerId,
        "brandId": brandId,
        "manufacturerProductId": manufacturerProductId,
        "manufacturer": manufacturer?.toMap(),
        "imageUrl": imageUrl,
        "bisStandard": bisStandard,
        "brouchureOrSpec": brouchureOrSpec,
        "sectorType": sectorType,
        "relatedGroupId": relatedGroupId,
        "variantId": variantId,
        "branchId": branchId,
        "subcategoryId": subcategoryId,
        "toleranceApplicable": toleranceApplicable,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "requiredMeasurements": requiredMeasurements == null
            ? []
            : List<dynamic>.from(requiredMeasurements!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "code": code,
        "returnPolicy": returnPolicy,
        "uomValue": uomValue,
        "alternateUomValue": alternateUomValue,
      };
}

class Manufacturer {
  int? id;
  String? name;
  String? logoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  Manufacturer({
    this.id,
    this.name,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Manufacturer.fromMap(Map<String, dynamic> json) => Manufacturer(
        id: json["id"],
        name: json["name"],
        logoUrl: json["logoUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "logoUrl": logoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class AppliedDeliveryCharges {
  AppliedDeliveryCharges();

  factory AppliedDeliveryCharges.fromMap(Map<String, dynamic> json) =>
      AppliedDeliveryCharges();

  Map<String, dynamic> toMap() => {};
}

class Address {
  String? id;
  String? userId;
  String? addressName;
  String? partyName;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? district;
  String? state;
  String? pincode;
  dynamic defaultAddress;
  bool? profileAddress;
  String? mapLocation;
  String? contactPersonName;
  String? gstNumber;
  String? panNumber;
  dynamic gstFileUrl;
  dynamic panFileUrl;

  Address({
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
    this.defaultAddress,
    this.profileAddress,
    this.mapLocation,
    this.contactPersonName,
    this.gstNumber,
    this.panNumber,
    this.gstFileUrl,
    this.panFileUrl,
  });

  factory Address.fromMap(Map<String, dynamic> json) => Address(
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
        defaultAddress: json["defaultAddress"],
        profileAddress: json["profileAddress"],
        mapLocation: json["mapLocation"],
        contactPersonName: json["contactPersonName"],
        gstNumber: json["gstNumber"],
        panNumber: json["panNumber"],
        gstFileUrl: json["gstFileUrl"],
        panFileUrl: json["panFileUrl"],
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
        "defaultAddress": defaultAddress,
        "profileAddress": profileAddress,
        "mapLocation": mapLocation,
        "contactPersonName": contactPersonName,
        "gstNumber": gstNumber,
        "panNumber": panNumber,
        "gstFileUrl": gstFileUrl,
        "panFileUrl": panFileUrl,
      };
}

class Payment {
  String? amount;
  String? referenceId;
  String? status;
  dynamic method;
  dynamic gateway;
  DateTime? createdAt;

  Payment({
    this.amount,
    this.referenceId,
    this.status,
    this.method,
    this.gateway,
    this.createdAt,
  });

  factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        amount: json["amount"],
        referenceId: json["referenceId"],
        status: json["status"],
        method: json["method"],
        gateway: json["gateway"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "referenceId": referenceId,
        "status": status,
        "method": method,
        "gateway": gateway,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class PendingShipmentDeliveryCharge {
  String? id;
  String? quoteId;
  String? type;
  String? commissionAmount;
  String? commissionRate;
  DateTime? createdAt;
  int? charge;

  PendingShipmentDeliveryCharge({
    this.id,
    this.quoteId,
    this.type,
    this.commissionAmount,
    this.commissionRate,
    this.createdAt,
    this.charge,
  });

  factory PendingShipmentDeliveryCharge.fromMap(Map<String, dynamic> json) =>
      PendingShipmentDeliveryCharge(
        id: json["id"],
        quoteId: json["quoteId"],
        type: json["type"],
        commissionAmount: json["commissionAmount"],
        commissionRate: json["commissionRate"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        charge: json["charge"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "quoteId": quoteId,
        "type": type,
        "commissionAmount": commissionAmount,
        "commissionRate": commissionRate,
        "createdAt": createdAt?.toIso8601String(),
        "charge": charge,
      };
}

class PendingShipmentLineItem {
  String? id;
  String? productId;
  dynamic units;
  String? itemPrice;
  dynamic itemTotalPrice;
  String? gstRate;
  String? taxAmount;
  String? commissionRate;
  String? commissionAmount;
  String? name;
  String? uom;
  String? alternateUom;
  String? manufacturerName;
  String? imageUrl;
  String? sectorType;
  DateTime? createdAt;
  Product? product;
  bool? isToleranceApplied;

  PendingShipmentLineItem({
    this.id,
    this.productId,
    this.units,
    this.itemPrice,
    this.itemTotalPrice,
    this.gstRate,
    this.taxAmount,
    this.commissionRate,
    this.commissionAmount,
    this.name,
    this.uom,
    this.alternateUom,
    this.manufacturerName,
    this.imageUrl,
    this.sectorType,
    this.createdAt,
    this.product,
    this.isToleranceApplied,
  });

  factory PendingShipmentLineItem.fromMap(Map<String, dynamic> json) =>
      PendingShipmentLineItem(
        id: json["id"],
        productId: json["productId"],
        units: json["units"],
        itemPrice: json["itemPrice"],
        itemTotalPrice: json["itemTotalPrice"],
        gstRate: json["gstRate"],
        taxAmount: json["taxAmount"],
        commissionRate: json["commissionRate"],
        commissionAmount: json["commissionAmount"],
        name: json["name"],
        uom: json["uom"],
        alternateUom: json["alternateUom"],
        manufacturerName: json["manufacturerName"],
        imageUrl: json["imageUrl"],
        sectorType: json["sectorType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
        isToleranceApplied: json["isToleranceApplied"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
        "units": units,
        "itemPrice": itemPrice,
        "itemTotalPrice": itemTotalPrice,
        "gstRate": gstRate,
        "taxAmount": taxAmount,
        "commissionRate": commissionRate,
        "commissionAmount": commissionAmount,
        "name": name,
        "uom": uom,
        "alternateUom": alternateUom,
        "manufacturerName": manufacturerName,
        "imageUrl": imageUrl,
        "sectorType": sectorType,
        "createdAt": createdAt?.toIso8601String(),
        "product": product?.toMap(),
        "isToleranceApplied": isToleranceApplied,
      };
}

class PendingSplitItem {
  String? id;
  String? productId;
  int? units;
  String? itemPrice;
  int? itemTotalPrice;
  String? gstRate;
  String? taxAmount;
  String? commissionRate;
  String? commissionAmount;
  String? name;
  String? uom;
  String? alternateUom;
  String? manufacturerName;
  String? imageUrl;
  String? sectorType;
  DateTime? createdAt;
  Product? product;
  bool? isToleranceApplied;

  PendingSplitItem({
    this.id,
    this.productId,
    this.units,
    this.itemPrice,
    this.itemTotalPrice,
    this.gstRate,
    this.taxAmount,
    this.commissionRate,
    this.commissionAmount,
    this.name,
    this.uom,
    this.alternateUom,
    this.manufacturerName,
    this.imageUrl,
    this.sectorType,
    this.createdAt,
    this.product,
    this.isToleranceApplied,
  });

  factory PendingSplitItem.fromMap(Map<String, dynamic> json) =>
      PendingSplitItem(
        id: json["id"],
        productId: json["productId"],
        units: json["units"],
        itemPrice: json["itemPrice"],
        itemTotalPrice: json["itemTotalPrice"],
        gstRate: json["gstRate"],
        taxAmount: json["taxAmount"],
        commissionRate: json["commissionRate"],
        commissionAmount: json["commissionAmount"],
        name: json["name"],
        uom: json["uom"],
        alternateUom: json["alternateUom"],
        manufacturerName: json["manufacturerName"],
        imageUrl: json["imageUrl"],
        sectorType: json["sectorType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
        isToleranceApplied: json["isToleranceApplied"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
        "units": units,
        "itemPrice": itemPrice,
        "itemTotalPrice": itemTotalPrice,
        "gstRate": gstRate,
        "taxAmount": taxAmount,
        "commissionRate": commissionRate,
        "commissionAmount": commissionAmount,
        "name": name,
        "uom": uom,
        "alternateUom": alternateUom,
        "manufacturerName": manufacturerName,
        "imageUrl": imageUrl,
        "sectorType": sectorType,
        "createdAt": createdAt?.toIso8601String(),
        "product": product?.toMap(),
        "isToleranceApplied": isToleranceApplied,
      };
}

class Quote {
  String? id;
  String? sellerId;
  String? quoteRequestId;
  String? quoteEnquiryId;
  String? status;
  String? totalDeliveryCharge;
  String? deliveryChargeTax;
  String? deliveryChargeTaxRate;
  String? totalPrice;
  String? totalTax;
  String? totalCommission;
  DateTime? validUntil;
  DateTime? submittedAt;
  bool? isUnloadPartyScope;
  String? totalDeliveryChargesCommission;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<DeliveryCharge>? deliveryCharges;
  QuoteRequest? quoteRequest;

  Quote({
    this.id,
    this.sellerId,
    this.quoteRequestId,
    this.quoteEnquiryId,
    this.status,
    this.totalDeliveryCharge,
    this.deliveryChargeTax,
    this.deliveryChargeTaxRate,
    this.totalPrice,
    this.totalTax,
    this.totalCommission,
    this.validUntil,
    this.submittedAt,
    this.isUnloadPartyScope,
    this.totalDeliveryChargesCommission,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharges,
    this.quoteRequest,
  });

  factory Quote.fromMap(Map<String, dynamic> json) => Quote(
        id: json["id"],
        sellerId: json["sellerId"],
        quoteRequestId: json["quoteRequestId"],
        quoteEnquiryId: json["quoteEnquiryId"],
        status: json["status"],
        totalDeliveryCharge: json["totalDeliveryCharge"],
        deliveryChargeTax: json["deliveryChargeTax"],
        deliveryChargeTaxRate: json["deliveryChargeTaxRate"],
        totalPrice: json["totalPrice"],
        totalTax: json["totalTax"],
        totalCommission: json["totalCommission"],
        validUntil: json["validUntil"] == null
            ? null
            : DateTime.parse(json["validUntil"]),
        submittedAt: json["submittedAt"] == null
            ? null
            : DateTime.parse(json["submittedAt"]),
        isUnloadPartyScope: json["isUnloadPartyScope"],
        totalDeliveryChargesCommission: json["totalDeliveryChargesCommission"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deliveryCharges: json["deliveryCharges"] == null
            ? []
            : List<DeliveryCharge>.from(
                json["deliveryCharges"]!.map((x) => DeliveryCharge.fromMap(x))),
        quoteRequest: json["quoteRequest"] == null
            ? null
            : QuoteRequest.fromMap(json["quoteRequest"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sellerId": sellerId,
        "quoteRequestId": quoteRequestId,
        "quoteEnquiryId": quoteEnquiryId,
        "status": status,
        "totalDeliveryCharge": totalDeliveryCharge,
        "deliveryChargeTax": deliveryChargeTax,
        "deliveryChargeTaxRate": deliveryChargeTaxRate,
        "totalPrice": totalPrice,
        "totalTax": totalTax,
        "totalCommission": totalCommission,
        "validUntil": validUntil?.toIso8601String(),
        "submittedAt": submittedAt?.toIso8601String(),
        "isUnloadPartyScope": isUnloadPartyScope,
        "totalDeliveryChargesCommission": totalDeliveryChargesCommission,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deliveryCharges": deliveryCharges == null
            ? []
            : List<dynamic>.from(deliveryCharges!.map((x) => x.toMap())),
        "quoteRequest": quoteRequest?.toMap(),
      };
}

class DeliveryCharge {
  String? id;
  String? quoteId;
  String? type;
  String? charge;
  String? commissionAmount;
  String? commissionRate;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryCharge({
    this.id,
    this.quoteId,
    this.type,
    this.charge,
    this.commissionAmount,
    this.commissionRate,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryCharge.fromMap(Map<String, dynamic> json) => DeliveryCharge(
        id: json["id"],
        quoteId: json["quoteId"],
        type: json["type"],
        charge: json["charge"],
        commissionAmount: json["commissionAmount"],
        commissionRate: json["commissionRate"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "quoteId": quoteId,
        "type": type,
        "charge": charge,
        "commissionAmount": commissionAmount,
        "commissionRate": commissionRate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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

class Shipment {
  String? id;
  String? sellerId;
  String? orderId;
  String? referenceId;
  String? status;
  String? totalPrice;
  String? totalTax;
  String? totalCommission;
  String? dispatchedAt;
  String? deliveredAt;
  DateTime? createdAt;
  String? quoteId;
  int? platformAddressId;
  int? lineItemsCount;
  List<Item>? shipmentLineItems;
  List<DisputeLineItem>? disputeLineItems;
  dynamic deliveryPersonContact;
  dynamic deliveryPersonName;
  dynamic deliveryVehicleNo;
  dynamic confirmationOtp;
  bool? confirmedWithOtp;
  bool? confirmedWithoutOtp;
  bool? hasSellerRaisedDispute;
  bool? hasBuyerRaisedDispute;
  bool? disputeOtpConfirmation;
  bool? disputeApproval;
  List<ShipmentDeliveryCharge>? deliveryCharges;
  String? totalDeliveryCharge;
  dynamic disputeConfirmationOtp;
  dynamic amountRefunded;
  int? invoiceNumber;
  int? debitNoteNumber;
  int? serviceBillNumber;
  dynamic creditNoteNumber;
  dynamic otpCreatedAt;

  Shipment({
    this.id,
    this.sellerId,
    this.orderId,
    this.referenceId,
    this.status,
    this.totalPrice,
    this.totalTax,
    this.totalCommission,
    this.dispatchedAt,
    this.deliveredAt,
    this.createdAt,
    this.quoteId,
    this.platformAddressId,
    this.lineItemsCount,
    this.shipmentLineItems,
    this.disputeLineItems,
    this.deliveryPersonContact,
    this.deliveryPersonName,
    this.deliveryVehicleNo,
    this.confirmationOtp,
    this.confirmedWithOtp,
    this.confirmedWithoutOtp,
    this.hasSellerRaisedDispute,
    this.hasBuyerRaisedDispute,
    this.disputeOtpConfirmation,
    this.disputeApproval,
    this.deliveryCharges,
    this.totalDeliveryCharge,
    this.disputeConfirmationOtp,
    this.amountRefunded,
    this.invoiceNumber,
    this.debitNoteNumber,
    this.serviceBillNumber,
    this.creditNoteNumber,
    this.otpCreatedAt,
  });

  factory Shipment.fromMap(Map<String, dynamic> json) => Shipment(
        id: json["id"],
        sellerId: json["sellerId"],
        orderId: json["orderId"],
        referenceId: json["referenceId"],
        status: json["status"],
        totalPrice: json["totalPrice"],
        totalTax: json["totalTax"],
        totalCommission: json["totalCommission"],
        dispatchedAt: json["dispatchedAt"],
        deliveredAt: json["deliveredAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        quoteId: json["quoteId"],
        platformAddressId: json["platformAddressId"],
        lineItemsCount: json["lineItemsCount"],
        shipmentLineItems: json["shipmentLineItems"] == null
            ? []
            : List<Item>.from(
                json["shipmentLineItems"]!.map((x) => Item.fromMap(x))),
        disputeLineItems: json["disputeLineItems"] == null
            ? []
            : List<DisputeLineItem>.from(json["disputeLineItems"]!
                .map((x) => DisputeLineItem.fromMap(x))),
        deliveryPersonContact: json["deliveryPersonContact"],
        deliveryPersonName: json["deliveryPersonName"],
        deliveryVehicleNo: json["deliveryVehicleNo"],
        confirmationOtp: json["confirmationOtp"],
        confirmedWithOtp: json["confirmedWithOtp"],
        confirmedWithoutOtp: json["confirmedWithoutOtp"],
        hasSellerRaisedDispute: json["hasSellerRaisedDispute"],
        hasBuyerRaisedDispute: json["hasBuyerRaisedDispute"],
        disputeOtpConfirmation: json["disputeOtpConfirmation"],
        disputeApproval: json["disputeApproval"],
        deliveryCharges: json["deliveryCharges"] == null
            ? []
            : List<ShipmentDeliveryCharge>.from(json["deliveryCharges"]!
                .map((x) => ShipmentDeliveryCharge.fromMap(x))),
        totalDeliveryCharge: json["totalDeliveryCharge"],
        disputeConfirmationOtp: json["disputeConfirmationOtp"],
        amountRefunded: json["amountRefunded"],
        invoiceNumber: json["invoiceNumber"],
        debitNoteNumber: json["debitNoteNumber"],
        serviceBillNumber: json["serviceBillNumber"],
        creditNoteNumber: json["creditNoteNumber"],
        otpCreatedAt: json["otpCreatedAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sellerId": sellerId,
        "orderId": orderId,
        "referenceId": referenceId,
        "status": status,
        "totalPrice": totalPrice,
        "totalTax": totalTax,
        "totalCommission": totalCommission,
        "dispatchedAt": dispatchedAt,
        "deliveredAt": deliveredAt,
        "createdAt": createdAt?.toIso8601String(),
        "quoteId": quoteId,
        "platformAddressId": platformAddressId,
        "lineItemsCount": lineItemsCount,
        "shipmentLineItems": shipmentLineItems == null
            ? []
            : List<dynamic>.from(shipmentLineItems!.map((x) => x.toMap())),
        "disputeLineItems": disputeLineItems == null
            ? []
            : List<dynamic>.from(disputeLineItems!.map((x) => x.toMap())),
        "deliveryPersonContact": deliveryPersonContact,
        "deliveryPersonName": deliveryPersonName,
        "deliveryVehicleNo": deliveryVehicleNo,
        "confirmationOtp": confirmationOtp,
        "confirmedWithOtp": confirmedWithOtp,
        "confirmedWithoutOtp": confirmedWithoutOtp,
        "hasSellerRaisedDispute": hasSellerRaisedDispute,
        "hasBuyerRaisedDispute": hasBuyerRaisedDispute,
        "disputeOtpConfirmation": disputeOtpConfirmation,
        "disputeApproval": disputeApproval,
        "deliveryCharges": deliveryCharges == null
            ? []
            : List<dynamic>.from(deliveryCharges!.map((x) => x)),
        "totalDeliveryCharge": totalDeliveryCharge,
        "disputeConfirmationOtp": disputeConfirmationOtp,
        "amountRefunded": amountRefunded,
        "invoiceNumber": invoiceNumber,
        "debitNoteNumber": debitNoteNumber,
        "serviceBillNumber": serviceBillNumber,
        "creditNoteNumber": creditNoteNumber,
        "otpCreatedAt": otpCreatedAt,
      };
}

class DisputeLineItem {
  String? id;
  String? shipmentId;
  String? shipmentLineItemId;
  String? units;
  String? itemPrice;
  String? itemTotalPrice;
  String? taxAmount;
  String? feedback;
  String? gstRate;
  String? uom;
  String? productName;
  String? commissionRate;
  String? commissionAmount;
  String? hsnCode;

  DisputeLineItem({
    this.id,
    this.shipmentId,
    this.shipmentLineItemId,
    this.units,
    this.itemPrice,
    this.itemTotalPrice,
    this.taxAmount,
    this.feedback,
    this.gstRate,
    this.uom,
    this.productName,
    this.commissionRate,
    this.commissionAmount,
    this.hsnCode,
  });

  factory DisputeLineItem.fromMap(Map<String, dynamic> json) => DisputeLineItem(
        id: json["id"],
        shipmentId: json["shipmentId"],
        shipmentLineItemId: json["shipmentLineItemId"],
        units: json["units"],
        itemPrice: json["itemPrice"],
        itemTotalPrice: json["itemTotalPrice"],
        taxAmount: json["taxAmount"],
        feedback: json["feedback"],
        gstRate: json["gstRate"],
        uom: json["uom"],
        productName: json["productName"],
        commissionRate: json["commissionRate"],
        commissionAmount: json["commissionAmount"],
        hsnCode: json["hsnCode"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shipmentId": shipmentId,
        "shipmentLineItemId": shipmentLineItemId,
        "units": units,
        "itemPrice": itemPrice,
        "itemTotalPrice": itemTotalPrice,
        "taxAmount": taxAmount,
        "feedback": feedback,
        "gstRate": gstRate,
        "uom": uom,
        "productName": productName,
        "commissionRate": commissionRate,
        "commissionAmount": commissionAmount,
        "hsnCode": hsnCode,
      };
}

class ShipmentDeliveryCharge {
  String? id;
  String? type;
  String? name;
  String? charge;
  String? commissionRate;
  String? commissionAmount;
  String? gstRate;
  String? shipmentId;

  ShipmentDeliveryCharge({
    this.id,
    this.type,
    this.name,
    this.charge,
    this.commissionRate,
    this.commissionAmount,
    this.gstRate,
    this.shipmentId,
  });

  factory ShipmentDeliveryCharge.fromMap(Map<String, dynamic> json) =>
      ShipmentDeliveryCharge(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        charge: json["charge"],
        commissionRate: json["commissionRate"],
        commissionAmount: json["commissionAmount"],
        gstRate: json["gstRate"],
        shipmentId: json["shipmentId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "name": name,
        "charge": charge,
        "commissionRate": commissionRate,
        "commissionAmount": commissionAmount,
        "gstRate": gstRate,
        "shipmentId": shipmentId,
      };
}
