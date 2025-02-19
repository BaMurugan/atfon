// To parse this JSON data, do
//
//     final bankDetailModule = bankDetailModuleFromMap(jsonString);

import 'dart:convert';

BankDetailModule bankDetailModuleFromMap(String str) =>
    BankDetailModule.fromMap(json.decode(str));

String bankDetailModuleToMap(BankDetailModule data) =>
    json.encode(data.toMap());

class BankDetailModule {
  Data? data;
  String? message;

  BankDetailModule({
    this.data,
    this.message,
  });

  factory BankDetailModule.fromMap(Map<String, dynamic> json) =>
      BankDetailModule(
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
  String? name;
  String? bankAccountNumber;
  String? bankName;
  String? ifsc;
  String? upiId;
  dynamic bankFileName;
  dynamic bankFileUrl;

  Data({
    this.id,
    this.name,
    this.bankAccountNumber,
    this.bankName,
    this.ifsc,
    this.upiId,
    this.bankFileName,
    this.bankFileUrl,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        bankAccountNumber: json["bankAccountNumber"],
        bankName: json["bankName"],
        ifsc: json["ifsc"],
        upiId: json["upi_id"],
        bankFileName: json["bankFileName"],
        bankFileUrl: json["bankFileUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "bankAccountNumber": bankAccountNumber,
        "bankName": bankName,
        "ifsc": ifsc,
        "upi_id": upiId,
        "bankFileName": bankFileName,
        "bankFileUrl": bankFileUrl,
      };
}
