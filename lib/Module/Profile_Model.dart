// To parse this JSON data, do
//
//     final profileModel = profileModelFromMap(jsonString);

import 'dart:convert';

ProfileModel profileModelFromMap(String str) =>
    ProfileModel.fromMap(json.decode(str));

String profileModelToMap(ProfileModel data) => json.encode(data.toMap());

class ProfileModel {
  bool? isSeller;
  String? sellerId;
  String? id;
  String? email;
  String? phone;
  bool? active;
  String? name;
  String? acceptedTermsId;

  ProfileModel({
    this.isSeller,
    this.sellerId,
    this.id,
    this.email,
    this.phone,
    this.active,
    this.name,
    this.acceptedTermsId,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        isSeller: json["isSeller"],
        sellerId: json["sellerId"],
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        active: json["active"],
        name: json["name"],
        acceptedTermsId: json["acceptedTermsId"],
      );

  Map<String, dynamic> toMap() => {
        "isSeller": isSeller,
        "sellerId": sellerId,
        "id": id,
        "email": email,
        "phone": phone,
        "active": active,
        "name": name,
        "acceptedTermsId": acceptedTermsId,
      };
}
