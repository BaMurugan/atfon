// To parse this JSON data, do
//
//     final inquiriesModule = inquiriesModuleFromMap(jsonString);

import 'dart:convert';

InquiriesModule inquiriesModuleFromMap(String str) =>
    InquiriesModule.fromMap(json.decode(str));

String inquiriesModuleToMap(InquiriesModule data) => json.encode(data.toMap());

class InquiriesModule {
  Data? data;
  String? message;

  InquiriesModule({
    this.data,
    this.message,
  });

  factory InquiriesModule.fromMap(Map<String, dynamic> json) => InquiriesModule(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
      };
}

class Data {
  int? totalUserInquiries;
  List<UserInquiry>? userInquiries;
  int? totalPages;
  int? currentPage;

  Data({
    this.totalUserInquiries,
    this.userInquiries,
    this.totalPages,
    this.currentPage,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        totalUserInquiries: json["totalUserInquiries"],
        userInquiries: json["userInquiries"] == null
            ? []
            : List<UserInquiry>.from(
                json["userInquiries"]!.map((x) => UserInquiry.fromMap(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalUserInquiries": totalUserInquiries,
        "userInquiries": userInquiries == null
            ? []
            : List<dynamic>.from(userInquiries!.map((x) => x.toMap())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class UserInquiry {
  String? id;
  String? message;
  String? category;
  String? status;
  String? priority;
  String? userType;
  dynamic resolvedAt;
  dynamic closedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Customer? customer;
  String? name;
  String? email;
  String? phone;
  String? userId;

  UserInquiry({
    this.id,
    this.message,
    this.category,
    this.status,
    this.priority,
    this.userType,
    this.resolvedAt,
    this.closedAt,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.name,
    this.email,
    this.phone,
    this.userId,
  });

  factory UserInquiry.fromMap(Map<String, dynamic> json) => UserInquiry(
        id: json["id"],
        message: json["message"],
        category: json["category"],
        status: json["status"],
        priority: json["priority"],
        userType: json["userType"],
        resolvedAt: json["resolvedAt"],
        closedAt: json["closedAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromMap(json["customer"]),
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "message": message,
        "category": category,
        "status": status,
        "priority": priority,
        "userType": userType,
        "resolvedAt": resolvedAt,
        "closedAt": closedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "customer": customer?.toMap(),
        "name": name,
        "email": email,
        "phone": phone,
        "userId": userId,
      };
}

class Customer {
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

  Customer({
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
  });

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
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
      };
}
