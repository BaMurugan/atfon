// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  Data? data;
  String? message;

  User({
    this.data,
    this.message,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
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
  String? companyName;
  String? userId;
  String? gst;
  String? pan;
  String? bankName;
  String? bankAccountNumber;
  String? ifsc;
  String? upiId;
  dynamic bankFileName;
  dynamic alternatePhoneOne;
  dynamic alternatePhoneTwo;
  dynamic location;
  dynamic sellerPoints;
  bool? availability;
  bool? approved;
  dynamic invoicingType;
  String? sellerType;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  UserClass? user;

  Data({
    this.id,
    this.companyName,
    this.userId,
    this.gst,
    this.pan,
    this.bankName,
    this.bankAccountNumber,
    this.ifsc,
    this.upiId,
    this.bankFileName,
    this.alternatePhoneOne,
    this.alternatePhoneTwo,
    this.location,
    this.sellerPoints,
    this.availability,
    this.approved,
    this.invoicingType,
    this.sellerType,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        companyName: json["companyName"],
        userId: json["userId"],
        gst: json["gst"],
        pan: json["pan"],
        bankName: json["bankName"],
        bankAccountNumber: json["bankAccountNumber"],
        ifsc: json["ifsc"],
        upiId: json["upi_id"],
        bankFileName: json["bankFileName"],
        alternatePhoneOne: json["alternatePhoneOne"],
        alternatePhoneTwo: json["alternatePhoneTwo"],
        location: json["location"],
        sellerPoints: json["sellerPoints"],
        availability: json["availability"],
        approved: json["approved"],
        invoicingType: json["invoicingType"],
        sellerType: json["sellerType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        user: json["user"] == null ? null : UserClass.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "companyName": companyName,
        "userId": userId,
        "gst": gst,
        "pan": pan,
        "bankName": bankName,
        "bankAccountNumber": bankAccountNumber,
        "ifsc": ifsc,
        "upi_id": upiId,
        "bankFileName": bankFileName,
        "alternatePhoneOne": alternatePhoneOne,
        "alternatePhoneTwo": alternatePhoneTwo,
        "location": location,
        "sellerPoints": sellerPoints,
        "availability": availability,
        "approved": approved,
        "invoicingType": invoicingType,
        "sellerType": sellerType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "user": user?.toMap(),
      };
}

class UserClass {
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

  UserClass({
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

  factory UserClass.fromMap(Map<String, dynamic> json) => UserClass(
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
