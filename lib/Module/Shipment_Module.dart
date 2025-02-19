// To parse this JSON data, do
//
//     final shipmentModule = shipmentModuleFromMap(jsonString);

import 'dart:convert';

ShipmentModule shipmentModuleFromMap(String str) =>
    ShipmentModule.fromMap(json.decode(str));

String shipmentModuleToMap(ShipmentModule data) => json.encode(data.toMap());

class ShipmentModule {
  Data? data;
  String? message;

  ShipmentModule({
    this.data,
    this.message,
  });

  factory ShipmentModule.fromMap(Map<String, dynamic> json) => ShipmentModule(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  List<ShipmentDetail>? shipmentDetails;

  Data({
    this.shipmentDetails,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        shipmentDetails: json["shipmentDetails"] == null
            ? []
            : List<ShipmentDetail>.from(
                json["shipmentDetails"]!.map((x) => ShipmentDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "shipmentDetails": shipmentDetails == null
            ? []
            : List<dynamic>.from(shipmentDetails!.map((x) => x.toMap())),
      };
}

class ShipmentDetail {
  String? id;
  String? referenceId;
  String? orderId;
  String? userId;
  String? sellerId;
  int? platformAddressId;
  String? quoteId;
  String? status;
  String? totalPrice;
  String? totalTax;
  String? totalCommission;
  DateTime? dispatchedAt;
  DateTime? deliveredAt;
  String? deliveryAddressId;
  dynamic billingAddressId;
  String? deliveryPersonName;
  String? deliveryPersonContact;
  String? deliveryVehicleNo;
  int? confirmationOtp;
  bool? confirmedWithOtp;
  bool? confirmedWithoutOtp;
  bool? hasSellerRaisedDispute;
  bool? hasBuyerRaisedDispute;
  bool? disputeApproval;
  String? totalDeliveryCharge;
  String? deliveryChargeTax;
  String? deliveryChargeTaxRate;
  String? totalDeliveryChargesCommission;
  bool? disputeOtpConfirmation;
  bool? isDisputeSentToAdmin;
  dynamic disputeConfirmationOtp;
  String? amountRefunded;
  int? invoiceNumber;
  int? debitNoteNumber;
  int? serviceBillNumber;
  dynamic creditNoteNumber;
  DateTime? otpCreatedAt;
  dynamic canceledAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ShipmentLineItem>? shipmentLineItems;
  List<DisputeLineItem>? disputeLineItems;
  List<dynamic>? deliveryCharges;
  Invoice? invoice;
  bool? hasExceededGracePeriod;

  ShipmentDetail({
    this.id,
    this.referenceId,
    this.orderId,
    this.userId,
    this.sellerId,
    this.platformAddressId,
    this.quoteId,
    this.status,
    this.totalPrice,
    this.totalTax,
    this.totalCommission,
    this.dispatchedAt,
    this.deliveredAt,
    this.deliveryAddressId,
    this.billingAddressId,
    this.deliveryPersonName,
    this.deliveryPersonContact,
    this.deliveryVehicleNo,
    this.confirmationOtp,
    this.confirmedWithOtp,
    this.confirmedWithoutOtp,
    this.hasSellerRaisedDispute,
    this.hasBuyerRaisedDispute,
    this.disputeApproval,
    this.totalDeliveryCharge,
    this.deliveryChargeTax,
    this.deliveryChargeTaxRate,
    this.totalDeliveryChargesCommission,
    this.disputeOtpConfirmation,
    this.isDisputeSentToAdmin,
    this.disputeConfirmationOtp,
    this.amountRefunded,
    this.invoiceNumber,
    this.debitNoteNumber,
    this.serviceBillNumber,
    this.creditNoteNumber,
    this.otpCreatedAt,
    this.canceledAt,
    this.createdAt,
    this.updatedAt,
    this.shipmentLineItems,
    this.disputeLineItems,
    this.deliveryCharges,
    this.invoice,
    this.hasExceededGracePeriod,
  });

  factory ShipmentDetail.fromMap(Map<String, dynamic> json) => ShipmentDetail(
        id: json["id"],
        referenceId: json["referenceId"],
        orderId: json["orderId"],
        userId: json["userId"],
        sellerId: json["sellerId"],
        platformAddressId: json["platformAddressId"],
        quoteId: json["quoteId"],
        status: json["status"],
        totalPrice: json["totalPrice"],
        totalTax: json["totalTax"],
        totalCommission: json["totalCommission"],
        dispatchedAt: json["dispatchedAt"] == null
            ? null
            : DateTime.parse(json["dispatchedAt"]),
        deliveredAt: json["deliveredAt"] == null
            ? null
            : DateTime.parse(json["deliveredAt"]),
        deliveryAddressId: json["deliveryAddressId"],
        billingAddressId: json["billingAddressId"],
        deliveryPersonName: json["deliveryPersonName"],
        deliveryPersonContact: json["deliveryPersonContact"],
        deliveryVehicleNo: json["deliveryVehicleNo"],
        confirmationOtp: json["confirmationOtp"],
        confirmedWithOtp: json["confirmedWithOtp"],
        confirmedWithoutOtp: json["confirmedWithoutOtp"],
        hasSellerRaisedDispute: json["hasSellerRaisedDispute"],
        hasBuyerRaisedDispute: json["hasBuyerRaisedDispute"],
        disputeApproval: json["disputeApproval"],
        totalDeliveryCharge: json["totalDeliveryCharge"],
        deliveryChargeTax: json["deliveryChargeTax"],
        deliveryChargeTaxRate: json["deliveryChargeTaxRate"],
        totalDeliveryChargesCommission: json["totalDeliveryChargesCommission"],
        disputeOtpConfirmation: json["disputeOtpConfirmation"],
        isDisputeSentToAdmin: json["isDisputeSentToAdmin"],
        disputeConfirmationOtp: json["disputeConfirmationOtp"],
        amountRefunded: json["amountRefunded"],
        invoiceNumber: json["invoiceNumber"],
        debitNoteNumber: json["debitNoteNumber"],
        serviceBillNumber: json["serviceBillNumber"],
        creditNoteNumber: json["creditNoteNumber"],
        otpCreatedAt: json["otpCreatedAt"] == null
            ? null
            : DateTime.parse(json["otpCreatedAt"]),
        canceledAt: json["canceledAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        shipmentLineItems: json["shipmentLineItems"] == null
            ? []
            : List<ShipmentLineItem>.from(json["shipmentLineItems"]!
                .map((x) => ShipmentLineItem.fromMap(x))),
        disputeLineItems: json["disputeLineItems"] == null
            ? []
            : List<DisputeLineItem>.from(json["disputeLineItems"]!
                .map((x) => DisputeLineItem.fromMap(x))),
        deliveryCharges: json["deliveryCharges"] == null
            ? []
            : List<dynamic>.from(json["deliveryCharges"]!.map((x) => x)),
        invoice:
            json["invoice"] == null ? null : Invoice.fromMap(json["invoice"]),
        hasExceededGracePeriod: json["hasExceededGracePeriod"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "referenceId": referenceId,
        "orderId": orderId,
        "userId": userId,
        "sellerId": sellerId,
        "platformAddressId": platformAddressId,
        "quoteId": quoteId,
        "status": status,
        "totalPrice": totalPrice,
        "totalTax": totalTax,
        "totalCommission": totalCommission,
        "dispatchedAt": dispatchedAt?.toIso8601String(),
        "deliveredAt": deliveredAt?.toIso8601String(),
        "deliveryAddressId": deliveryAddressId,
        "billingAddressId": billingAddressId,
        "deliveryPersonName": deliveryPersonName,
        "deliveryPersonContact": deliveryPersonContact,
        "deliveryVehicleNo": deliveryVehicleNo,
        "confirmationOtp": confirmationOtp,
        "confirmedWithOtp": confirmedWithOtp,
        "confirmedWithoutOtp": confirmedWithoutOtp,
        "hasSellerRaisedDispute": hasSellerRaisedDispute,
        "hasBuyerRaisedDispute": hasBuyerRaisedDispute,
        "disputeApproval": disputeApproval,
        "totalDeliveryCharge": totalDeliveryCharge,
        "deliveryChargeTax": deliveryChargeTax,
        "deliveryChargeTaxRate": deliveryChargeTaxRate,
        "totalDeliveryChargesCommission": totalDeliveryChargesCommission,
        "disputeOtpConfirmation": disputeOtpConfirmation,
        "isDisputeSentToAdmin": isDisputeSentToAdmin,
        "disputeConfirmationOtp": disputeConfirmationOtp,
        "amountRefunded": amountRefunded,
        "invoiceNumber": invoiceNumber,
        "debitNoteNumber": debitNoteNumber,
        "serviceBillNumber": serviceBillNumber,
        "creditNoteNumber": creditNoteNumber,
        "otpCreatedAt": otpCreatedAt?.toIso8601String(),
        "canceledAt": canceledAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "shipmentLineItems": shipmentLineItems == null
            ? []
            : List<dynamic>.from(shipmentLineItems!.map((x) => x.toMap())),
        "disputeLineItems": disputeLineItems == null
            ? []
            : List<dynamic>.from(disputeLineItems!.map((x) => x.toMap())),
        "deliveryCharges": deliveryCharges == null
            ? []
            : List<dynamic>.from(deliveryCharges!.map((x) => x)),
        "invoice": invoice?.toMap(),
        "hasExceededGracePeriod": hasExceededGracePeriod,
      };
}

class DisputeLineItem {
  String? id;
  String? shipmentLineItemId;
  String? shipmentId;
  String? units;
  String? itemPrice;
  String? itemTotalPrice;
  String? gstRate;
  String? commissionRate;
  String? commissionAmount;
  String? taxAmount;
  String? feedback;
  String? uom;
  String? productName;
  String? disputeType;
  String? hsnCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  DisputeLineItem({
    this.id,
    this.shipmentLineItemId,
    this.shipmentId,
    this.units,
    this.itemPrice,
    this.itemTotalPrice,
    this.gstRate,
    this.commissionRate,
    this.commissionAmount,
    this.taxAmount,
    this.feedback,
    this.uom,
    this.productName,
    this.disputeType,
    this.hsnCode,
    this.createdAt,
    this.updatedAt,
  });

  factory DisputeLineItem.fromMap(Map<String, dynamic> json) => DisputeLineItem(
        id: json["id"],
        shipmentLineItemId: json["shipmentLineItemId"],
        shipmentId: json["shipmentId"],
        units: json["units"],
        itemPrice: json["itemPrice"],
        itemTotalPrice: json["itemTotalPrice"],
        gstRate: json["gstRate"],
        commissionRate: json["commissionRate"],
        commissionAmount: json["commissionAmount"],
        taxAmount: json["taxAmount"],
        feedback: json["feedback"],
        uom: json["uom"],
        productName: json["productName"],
        disputeType: json["disputeType"],
        hsnCode: json["hsnCode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shipmentLineItemId": shipmentLineItemId,
        "shipmentId": shipmentId,
        "units": units,
        "itemPrice": itemPrice,
        "itemTotalPrice": itemTotalPrice,
        "gstRate": gstRate,
        "commissionRate": commissionRate,
        "commissionAmount": commissionAmount,
        "taxAmount": taxAmount,
        "feedback": feedback,
        "uom": uom,
        "productName": productName,
        "disputeType": disputeType,
        "hsnCode": hsnCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Invoice {
  String? id;
  String? internalInvoiceNumber;
  String? sellerInvoiceNumber;
  String? fileName;
  String? orderId;
  String? shipmentId;
  bool? processed;
  dynamic sellerIrnNumber;
  dynamic sellerEwayNumber;
  DateTime? sellerInvoiceDate;
  dynamic vehicleNumber;
  dynamic sellerAcknowledgmentNumber;
  dynamic sellerAcknowledgmentDate;
  dynamic platformIrnNumber;
  dynamic platformAcknowledgmentNumber;
  dynamic platformAcknowledgmentDate;
  bool? afterTransitInvoiceProcessed;
  dynamic afterTransitInvoiceFileName;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  Invoice({
    this.id,
    this.internalInvoiceNumber,
    this.sellerInvoiceNumber,
    this.fileName,
    this.orderId,
    this.shipmentId,
    this.processed,
    this.sellerIrnNumber,
    this.sellerEwayNumber,
    this.sellerInvoiceDate,
    this.vehicleNumber,
    this.sellerAcknowledgmentNumber,
    this.sellerAcknowledgmentDate,
    this.platformIrnNumber,
    this.platformAcknowledgmentNumber,
    this.platformAcknowledgmentDate,
    this.afterTransitInvoiceProcessed,
    this.afterTransitInvoiceFileName,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory Invoice.fromMap(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        internalInvoiceNumber: json["internalInvoiceNumber"],
        sellerInvoiceNumber: json["sellerInvoiceNumber"],
        fileName: json["fileName"],
        orderId: json["orderId"],
        shipmentId: json["shipmentId"],
        processed: json["processed"],
        sellerIrnNumber: json["sellerIrnNumber"],
        sellerEwayNumber: json["sellerEwayNumber"],
        sellerInvoiceDate: json["sellerInvoiceDate"] == null
            ? null
            : DateTime.parse(json["sellerInvoiceDate"]),
        vehicleNumber: json["vehicleNumber"],
        sellerAcknowledgmentNumber: json["sellerAcknowledgmentNumber"],
        sellerAcknowledgmentDate: json["sellerAcknowledgmentDate"],
        platformIrnNumber: json["platformIrnNumber"],
        platformAcknowledgmentNumber: json["platformAcknowledgmentNumber"],
        platformAcknowledgmentDate: json["platformAcknowledgmentDate"],
        afterTransitInvoiceProcessed: json["afterTransitInvoiceProcessed"],
        afterTransitInvoiceFileName: json["afterTransitInvoiceFileName"],
        type: json["type"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "internalInvoiceNumber": internalInvoiceNumber,
        "sellerInvoiceNumber": sellerInvoiceNumber,
        "fileName": fileName,
        "orderId": orderId,
        "shipmentId": shipmentId,
        "processed": processed,
        "sellerIrnNumber": sellerIrnNumber,
        "sellerEwayNumber": sellerEwayNumber,
        "sellerInvoiceDate": sellerInvoiceDate?.toIso8601String(),
        "vehicleNumber": vehicleNumber,
        "sellerAcknowledgmentNumber": sellerAcknowledgmentNumber,
        "sellerAcknowledgmentDate": sellerAcknowledgmentDate,
        "platformIrnNumber": platformIrnNumber,
        "platformAcknowledgmentNumber": platformAcknowledgmentNumber,
        "platformAcknowledgmentDate": platformAcknowledgmentDate,
        "afterTransitInvoiceProcessed": afterTransitInvoiceProcessed,
        "afterTransitInvoiceFileName": afterTransitInvoiceFileName,
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class ShipmentLineItem {
  String? id;
  String? orderId;
  String? productId;
  String? shipmentId;
  String? orderLineItemId;
  String? units;
  String? itemPrice;
  String? itemTotalPrice;
  String? taxAmount;
  String? commissionAmount;
  String? gstRate;
  String? commissionRate;
  String? hsnCode;
  bool? isToleranceApplied;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  ShipmentLineItem({
    this.id,
    this.orderId,
    this.productId,
    this.shipmentId,
    this.orderLineItemId,
    this.units,
    this.itemPrice,
    this.itemTotalPrice,
    this.taxAmount,
    this.commissionAmount,
    this.gstRate,
    this.commissionRate,
    this.hsnCode,
    this.isToleranceApplied,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory ShipmentLineItem.fromMap(Map<String, dynamic> json) =>
      ShipmentLineItem(
        id: json["id"],
        orderId: json["orderId"],
        productId: json["productId"],
        shipmentId: json["shipmentId"],
        orderLineItemId: json["orderLineItemId"],
        units: json["units"],
        itemPrice: json["itemPrice"],
        itemTotalPrice: json["itemTotalPrice"],
        taxAmount: json["taxAmount"],
        commissionAmount: json["commissionAmount"],
        gstRate: json["gstRate"],
        commissionRate: json["commissionRate"],
        hsnCode: json["hsnCode"],
        isToleranceApplied: json["isToleranceApplied"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "orderId": orderId,
        "productId": productId,
        "shipmentId": shipmentId,
        "orderLineItemId": orderLineItemId,
        "units": units,
        "itemPrice": itemPrice,
        "itemTotalPrice": itemTotalPrice,
        "taxAmount": taxAmount,
        "commissionAmount": commissionAmount,
        "gstRate": gstRate,
        "commissionRate": commissionRate,
        "hsnCode": hsnCode,
        "isToleranceApplied": isToleranceApplied,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "product": product?.toMap(),
      };
}

class Product {
  String? id;
  String? name;
  String? description;
  String? uom;
  String? alternateUom;
  String? size;
  String? subtype;
  String? registeredOrPl;
  String? imageUrl;
  String? bisStandard;
  String? brouchureOrSpec;
  String? sectorType;
  dynamic relatedGroupId;
  int? branchId;
  int? subcategoryId;
  String? variantId;
  int? manufacturerId;
  dynamic brandId;
  String? manufacturerProductId;
  bool? toleranceApplicable;
  List<dynamic>? requiredMeasurements;
  List<String>? tags;
  String? code;
  String? gstRate;
  String? hsnCode;
  String? uomValue;
  String? alternateUomValue;
  String? returnPolicy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Product({
    this.id,
    this.name,
    this.description,
    this.uom,
    this.alternateUom,
    this.size,
    this.subtype,
    this.registeredOrPl,
    this.imageUrl,
    this.bisStandard,
    this.brouchureOrSpec,
    this.sectorType,
    this.relatedGroupId,
    this.branchId,
    this.subcategoryId,
    this.variantId,
    this.manufacturerId,
    this.brandId,
    this.manufacturerProductId,
    this.toleranceApplicable,
    this.requiredMeasurements,
    this.tags,
    this.code,
    this.gstRate,
    this.hsnCode,
    this.uomValue,
    this.alternateUomValue,
    this.returnPolicy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        uom: json["uom"],
        alternateUom: json["alternateUom"],
        size: json["size"],
        subtype: json["subtype"],
        registeredOrPl: json["registeredOrPl"],
        imageUrl: json["imageUrl"],
        bisStandard: json["bisStandard"],
        brouchureOrSpec: json["brouchureOrSpec"],
        sectorType: json["sectorType"],
        relatedGroupId: json["relatedGroupId"],
        branchId: json["branchId"],
        subcategoryId: json["subcategoryId"],
        variantId: json["variantId"],
        manufacturerId: json["manufacturerId"],
        brandId: json["brandId"],
        manufacturerProductId: json["manufacturerProductId"],
        toleranceApplicable: json["toleranceApplicable"],
        requiredMeasurements: json["requiredMeasurements"] == null
            ? []
            : List<dynamic>.from(json["requiredMeasurements"]!.map((x) => x)),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        code: json["code"],
        gstRate: json["gstRate"],
        hsnCode: json["hsnCode"],
        uomValue: json["uomValue"],
        alternateUomValue: json["alternateUomValue"],
        returnPolicy: json["returnPolicy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "uom": uom,
        "alternateUom": alternateUom,
        "size": size,
        "subtype": subtype,
        "registeredOrPl": registeredOrPl,
        "imageUrl": imageUrl,
        "bisStandard": bisStandard,
        "brouchureOrSpec": brouchureOrSpec,
        "sectorType": sectorType,
        "relatedGroupId": relatedGroupId,
        "branchId": branchId,
        "subcategoryId": subcategoryId,
        "variantId": variantId,
        "manufacturerId": manufacturerId,
        "brandId": brandId,
        "manufacturerProductId": manufacturerProductId,
        "toleranceApplicable": toleranceApplicable,
        "requiredMeasurements": requiredMeasurements == null
            ? []
            : List<dynamic>.from(requiredMeasurements!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "code": code,
        "gstRate": gstRate,
        "hsnCode": hsnCode,
        "uomValue": uomValue,
        "alternateUomValue": alternateUomValue,
        "returnPolicy": returnPolicy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
