// To parse this JSON data, do
//
//     final notificationStatusModule = notificationStatusModuleFromMap(jsonString);

import 'dart:convert';

NotificationStatusModule notificationStatusModuleFromMap(String str) =>
    NotificationStatusModule.fromMap(json.decode(str));

String notificationStatusModuleToMap(NotificationStatusModule data) =>
    json.encode(data.toMap());

class NotificationStatusModule {
  Data? data;
  String? message;

  NotificationStatusModule({
    this.data,
    this.message,
  });

  factory NotificationStatusModule.fromMap(Map<String, dynamic> json) =>
      NotificationStatusModule(
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
  String? email;
  String? phone;
  bool? active;
  String? name;
  String? acceptedTermsId;
  dynamic termsAcceptedTime;
  dynamic buyerPan;
  dynamic buyerGst;
  dynamic bankAccountNumber;
  dynamic ifsc;
  dynamic bankName;
  dynamic upiId;
  dynamic bankFileName;
  bool? notificationEnabled;
  bool? isVerifiedEmail;
  bool? firstOrder;
  String? referralCode;
  dynamic referredBy;
  String? userLoginOtpVerifyKey;
  String? awsOtpLoginSessionResponse;
  String? userLoginOtp;
  dynamic deletedByAdminId;
  dynamic deletionReasonByAdmin;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Seller? seller;

  Data({
    this.id,
    this.email,
    this.phone,
    this.active,
    this.name,
    this.acceptedTermsId,
    this.termsAcceptedTime,
    this.buyerPan,
    this.buyerGst,
    this.bankAccountNumber,
    this.ifsc,
    this.bankName,
    this.upiId,
    this.bankFileName,
    this.notificationEnabled,
    this.isVerifiedEmail,
    this.firstOrder,
    this.referralCode,
    this.referredBy,
    this.userLoginOtpVerifyKey,
    this.awsOtpLoginSessionResponse,
    this.userLoginOtp,
    this.deletedByAdminId,
    this.deletionReasonByAdmin,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.seller,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        active: json["active"],
        name: json["name"],
        acceptedTermsId: json["acceptedTermsId"],
        termsAcceptedTime: json["termsAcceptedTime"],
        buyerPan: json["buyer_pan"],
        buyerGst: json["buyer_gst"],
        bankAccountNumber: json["bankAccountNumber"],
        ifsc: json["ifsc"],
        bankName: json["bankName"],
        upiId: json["upi_id"],
        bankFileName: json["bankFileName"],
        notificationEnabled: json["notificationEnabled"],
        isVerifiedEmail: json["isVerifiedEmail"],
        firstOrder: json["firstOrder"],
        referralCode: json["referralCode"],
        referredBy: json["referredBy"],
        userLoginOtpVerifyKey: json["userLoginOtpVerifyKey"],
        awsOtpLoginSessionResponse: json["awsOtpLoginSessionResponse"],
        userLoginOtp: json["userLoginOtp"],
        deletedByAdminId: json["deletedByAdminId"],
        deletionReasonByAdmin: json["deletionReasonByAdmin"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        seller: json["seller"] == null ? null : Seller.fromMap(json["seller"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "phone": phone,
        "active": active,
        "name": name,
        "acceptedTermsId": acceptedTermsId,
        "termsAcceptedTime": termsAcceptedTime,
        "buyer_pan": buyerPan,
        "buyer_gst": buyerGst,
        "bankAccountNumber": bankAccountNumber,
        "ifsc": ifsc,
        "bankName": bankName,
        "upi_id": upiId,
        "bankFileName": bankFileName,
        "notificationEnabled": notificationEnabled,
        "isVerifiedEmail": isVerifiedEmail,
        "firstOrder": firstOrder,
        "referralCode": referralCode,
        "referredBy": referredBy,
        "userLoginOtpVerifyKey": userLoginOtpVerifyKey,
        "awsOtpLoginSessionResponse": awsOtpLoginSessionResponse,
        "userLoginOtp": userLoginOtp,
        "deletedByAdminId": deletedByAdminId,
        "deletionReasonByAdmin": deletionReasonByAdmin,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "seller": seller?.toMap(),
      };
}

class Seller {
  String? id;
  String? sellerType;

  Seller({
    this.id,
    this.sellerType,
  });

  factory Seller.fromMap(Map<String, dynamic> json) => Seller(
        id: json["id"],
        sellerType: json["seller_type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "seller_type": sellerType,
      };
}
