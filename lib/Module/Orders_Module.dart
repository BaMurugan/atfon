// To parse this JSON data, do
//
//     final orderModule = orderModuleFromMap(jsonString);

import 'dart:convert';

OrderModule orderModuleFromMap(String str) =>
    OrderModule.fromMap(json.decode(str));

String orderModuleToMap(OrderModule data) => json.encode(data.toMap());

class OrderModule {
  Data? data;
  String? message;

  OrderModule({
    this.data,
    this.message,
  });

  factory OrderModule.fromMap(Map<String, dynamic> json) => OrderModule(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? totalOrders;
  List<Order>? orders;
  int? totalPages;
  int? currentPage;

  Data({
    this.totalOrders,
    this.orders,
    this.totalPages,
    this.currentPage,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        totalOrders: json["totalOrders"],
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromMap(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalOrders": totalOrders,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Order {
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
  DateTime? dispatchedAt;
  DateTime? deliveredAt;
  DateTime? createdAt;
  String? quoteId;
  int? lineItemsCount;
  String? invoiceFileUrl;
  int? initialCancelationAllowedTime;
  bool? onHold;
  bool? sendQuoteAcceptedSms;
  bool? isSplitOrderCompleted;
  DateTime? paymentCreatedAt;
  Quote? quote;
  int? shipmentsLength;
  List<dynamic>? shipments;
  bool? hasExceededGracePeriod;
  List<OrderLineItem>? orderLineItems;

  Order({
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
    this.invoiceFileUrl,
    this.initialCancelationAllowedTime,
    this.onHold,
    this.sendQuoteAcceptedSms,
    this.isSplitOrderCompleted,
    this.paymentCreatedAt,
    this.quote,
    this.shipmentsLength,
    this.shipments,
    this.hasExceededGracePeriod,
    this.orderLineItems,
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
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
        dispatchedAt: json["dispatchedAt"] == null
            ? null
            : DateTime.parse(json["dispatchedAt"]),
        deliveredAt: json["deliveredAt"] == null
            ? null
            : DateTime.parse(json["deliveredAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        quoteId: json["quoteId"],
        lineItemsCount: json["lineItemsCount"],
        invoiceFileUrl: json["invoiceFileUrl"],
        initialCancelationAllowedTime: json["initialCancelationAllowedTime"],
        onHold: json["onHold"],
        sendQuoteAcceptedSms: json["sendQuoteAcceptedSms"],
        isSplitOrderCompleted: json["isSplitOrderCompleted"],
        paymentCreatedAt: json["paymentCreatedAt"] == null
            ? null
            : DateTime.parse(json["paymentCreatedAt"]),
        quote: json["quote"] == null ? null : Quote.fromMap(json["quote"]),
        shipmentsLength: json["shipmentsLength"],
        shipments: json["shipments"] == null
            ? []
            : List<dynamic>.from(json["shipments"]!.map((x) => x)),
        hasExceededGracePeriod: json["hasExceededGracePeriod"],
        orderLineItems: json["orderLineItems"] == null
            ? []
            : List<OrderLineItem>.from(
                json["orderLineItems"]!.map((x) => OrderLineItem.fromMap(x))),
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
        "dispatchedAt": dispatchedAt?.toIso8601String(),
        "deliveredAt": deliveredAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "quoteId": quoteId,
        "lineItemsCount": lineItemsCount,
        "invoiceFileUrl": invoiceFileUrl,
        "initialCancelationAllowedTime": initialCancelationAllowedTime,
        "onHold": onHold,
        "sendQuoteAcceptedSms": sendQuoteAcceptedSms,
        "isSplitOrderCompleted": isSplitOrderCompleted,
        "paymentCreatedAt": paymentCreatedAt?.toIso8601String(),
        "quote": quote?.toMap(),
        "shipmentsLength": shipmentsLength,
        "shipments": shipments == null
            ? []
            : List<dynamic>.from(shipments!.map((x) => x)),
        "hasExceededGracePeriod": hasExceededGracePeriod,
        "orderLineItems": orderLineItems == null
            ? []
            : List<dynamic>.from(orderLineItems!.map((x) => x.toMap())),
      };
}

class OrderLineItem {
  String? id;
  String? productId;
  String? units;
  String? itemPrice;
  String? itemTotalPrice;
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
  OrderLineItemProduct? product;
  bool? isToleranceApplied;

  OrderLineItem({
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

  factory OrderLineItem.fromMap(Map<String, dynamic> json) => OrderLineItem(
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
        product: json["product"] == null
            ? null
            : OrderLineItemProduct.fromMap(json["product"]),
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

class OrderLineItemProduct {
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
  String? manufacturerProductId;
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

  OrderLineItemProduct({
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

  factory OrderLineItemProduct.fromMap(Map<String, dynamic> json) =>
      OrderLineItemProduct(
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
  List<QuoteLineItem>? quoteLineItems;
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
    this.quoteLineItems,
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
        "quoteLineItems": quoteLineItems == null
            ? []
            : List<dynamic>.from(quoteLineItems!.map((x) => x.toMap())),
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

class QuoteLineItem {
  String? id;
  String? quoteId;
  String? productId;
  String? units;
  String? uom;
  String? gstRate;
  bool? excluded;
  bool? serviceableMinMaxQuantityExceeded;
  bool? isSellerProduct;
  String? itemPrice;
  String? itemTotalPrice;
  String? taxAmount;
  String? commissionRate;
  String? commissionAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  QuoteLineItemProduct? product;

  QuoteLineItem({
    this.id,
    this.quoteId,
    this.productId,
    this.units,
    this.uom,
    this.gstRate,
    this.excluded,
    this.serviceableMinMaxQuantityExceeded,
    this.isSellerProduct,
    this.itemPrice,
    this.itemTotalPrice,
    this.taxAmount,
    this.commissionRate,
    this.commissionAmount,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory QuoteLineItem.fromMap(Map<String, dynamic> json) => QuoteLineItem(
        id: json["id"],
        quoteId: json["quoteId"],
        productId: json["productId"],
        units: json["units"],
        uom: json["uom"],
        gstRate: json["gstRate"],
        excluded: json["excluded"],
        serviceableMinMaxQuantityExceeded:
            json["serviceableMinMaxQuantityExceeded"],
        isSellerProduct: json["isSellerProduct"],
        itemPrice: json["itemPrice"],
        itemTotalPrice: json["itemTotalPrice"],
        taxAmount: json["taxAmount"],
        commissionRate: json["commissionRate"],
        commissionAmount: json["commissionAmount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        product: json["product"] == null
            ? null
            : QuoteLineItemProduct.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "quoteId": quoteId,
        "productId": productId,
        "units": units,
        "uom": uom,
        "gstRate": gstRate,
        "excluded": excluded,
        "serviceableMinMaxQuantityExceeded": serviceableMinMaxQuantityExceeded,
        "isSellerProduct": isSellerProduct,
        "itemPrice": itemPrice,
        "itemTotalPrice": itemTotalPrice,
        "taxAmount": taxAmount,
        "commissionRate": commissionRate,
        "commissionAmount": commissionAmount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "product": product?.toMap(),
      };
}

class QuoteLineItemProduct {
  String? name;
  String? imageUrl;

  QuoteLineItemProduct({
    this.name,
    this.imageUrl,
  });

  factory QuoteLineItemProduct.fromMap(Map<String, dynamic> json) =>
      QuoteLineItemProduct(
        name: json["name"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "image_url": imageUrl,
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
  String? selfPickupPincode;
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
            : DeliveryPreference.fromJson(json["deliveryPreference"]),
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
        "deliveryPreference": deliveryPreference?.toJson(),
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
  DateTime? sellerExpectedDeliveryDate;
  String? sellerExpectedDeliveryTime;

  DeliveryPreference({
    this.expectedDeliveryDate,
    this.expectedDeliveryTime,
    this.sellerExpectedDeliveryDate,
    this.sellerExpectedDeliveryTime,
  });

  factory DeliveryPreference.fromJson(Map<String, dynamic> json) =>
      DeliveryPreference(
        expectedDeliveryDate: json["expectedDeliveryDate"] == null
            ? null
            : DateTime.parse(json["expectedDeliveryDate"]),
        expectedDeliveryTime: json["expectedDeliveryTime"],
        sellerExpectedDeliveryDate: json["sellerExpectedDeliveryDate"] == null
            ? null
            : DateTime.parse(json["sellerExpectedDeliveryDate"]),
        sellerExpectedDeliveryTime: json["sellerExpectedDeliveryTime"],
      );

  Map<String, dynamic> toJson() => {
        "expectedDeliveryDate": expectedDeliveryDate?.toIso8601String(),
        "expectedDeliveryTime": expectedDeliveryTime,
        "sellerExpectedDeliveryDate":
            sellerExpectedDeliveryDate?.toIso8601String(),
        "sellerExpectedDeliveryTime": sellerExpectedDeliveryTime,
      };
}
