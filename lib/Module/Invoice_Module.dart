// To parse this JSON data, do
//
//     final invoiceModule = invoiceModuleFromJson(jsonString);

import 'dart:convert';

InvoiceModule invoiceModuleFromJson(String str) =>
    InvoiceModule.fromJson(json.decode(str));

String invoiceModuleToJson(InvoiceModule data) => json.encode(data.toJson());

class InvoiceModule {
  Data? data;
  String? message;

  InvoiceModule({
    this.data,
    this.message,
  });

  factory InvoiceModule.fromJson(Map<String, dynamic> json) => InvoiceModule(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  String? shipmentId;
  String? debitNoteInvoiceFileUrl;
  String? creditNoteInvoiceFileUrl;
  String? transitInvoiceFileUrl;
  String? finalInvoiceFileUrl;
  String? sbFinalInvoiceFileUrl;
  String? serviceBillFileUrl;
  String? disputeDebitNoteInvoiceFileUrl;

  Data({
    this.shipmentId,
    this.debitNoteInvoiceFileUrl,
    this.creditNoteInvoiceFileUrl,
    this.transitInvoiceFileUrl,
    this.finalInvoiceFileUrl,
    this.sbFinalInvoiceFileUrl,
    this.serviceBillFileUrl,
    this.disputeDebitNoteInvoiceFileUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        shipmentId: json["shipmentId"],
        debitNoteInvoiceFileUrl: json["debitNoteInvoiceFileUrl"],
        creditNoteInvoiceFileUrl: json["creditNoteInvoiceFileUrl"],
        transitInvoiceFileUrl: json["transitInvoiceFileUrl"],
        finalInvoiceFileUrl: json["finalInvoiceFileUrl"],
        sbFinalInvoiceFileUrl: json["sbFinalInvoiceFileUrl"],
        serviceBillFileUrl: json["serviceBillFileUrl"],
        disputeDebitNoteInvoiceFileUrl: json["disputeDebitNoteInvoiceFileUrl"],
      );

  Map<String, dynamic> toJson() => {
        "shipmentId": shipmentId,
        "debitNoteInvoiceFileUrl": debitNoteInvoiceFileUrl,
        "creditNoteInvoiceFileUrl": creditNoteInvoiceFileUrl,
        "transitInvoiceFileUrl": transitInvoiceFileUrl,
        "finalInvoiceFileUrl": finalInvoiceFileUrl,
        "sbFinalInvoiceFileUrl": sbFinalInvoiceFileUrl,
        "serviceBillFileUrl": serviceBillFileUrl,
        "disputeDebitNoteInvoiceFileUrl": disputeDebitNoteInvoiceFileUrl,
      };
}
