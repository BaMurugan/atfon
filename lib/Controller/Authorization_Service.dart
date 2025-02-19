import 'dart:convert';

import 'package:autofon_seller/Module/GSTSearch_Module.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Module/Profile_Model.dart';
import '../Other Service/ApiPath.dart';
import '../Other Service/ApiService.dart';
import '../Other Service/HiveStoreage.dart';
import 'Home_Service.dart';

class AuthService extends GetxController {
  TextEditingController phoneNumber = TextEditingController();
  late GstSearchModule gstSearchModule;
  TextEditingController gstNumber = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController companyAddress = TextEditingController();
  TextEditingController panNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController referral = TextEditingController();
  TextEditingController pinController = TextEditingController();
  int selectedAddressIndex = 0;
  List addresses = [];
  int resetPasswordPage = 0;
  String? enteredNumber;
  final homeController = Get.put(HomeService());
  ProfileModel? profileData;

  signupInstilize() {
    phoneNumber = TextEditingController();
    gstSearchModule = GstSearchModule();
    gstNumber = TextEditingController();
    companyName = TextEditingController();
    panNumber = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    referral = TextEditingController();
    companyAddress = TextEditingController();
    selectedAddressIndex = 0;
    addresses = [];
    resetPasswordPage = 0;
    update();
  }

  getUser(String phoneNumber, String password) async {
    final data = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerSignIn,
        body: {
          'phone': "+91$phoneNumber",
          'password': password,
        });

    HiveService.saveAuthToken(data['accessToken']);
    await homeController.getProfile();
    profileData = homeController.profileData;
    update();
  }

  existingUser() async {
    await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: ApiPaths.sellerProfile,
      token: HiveService.getAuthToken(),
    );

    await homeController.getProfile();
  }

  resetPasswordRequest() async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerResetPassword,
        body: {
          'phone': '+91${phoneNumber.text}',
        });
  }

  requestChangePassword(String code, String password) async {
    await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerSearchConfirmPassword,
      body: {
        'phone': '+91${phoneNumber.text}',
        'code': code,
        'newPassword': password,
      },
    );
  }

  requestOTP() async {
    await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerSignInWithOTP,
      body: {'phone': '+91${phoneNumber.text}'},
    );
  }

  verifyOTP(String otp) async {
    final data = await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerSignInOTP,
      body: {
        'phone': '+91${phoneNumber.text}',
        'otp': otp,
      },
    );

    HiveService.saveAuthToken(data['accessToken']);
    await homeController.getProfile();
  }

  gstSearch() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellerGstSearch}/${gstNumber.text.trim()}',
    );

    gstSearchModule = gstSearchModuleFromMap(jsonEncode(request));
    selectedAddressIndex = 0;
    addresses = gstSearchModule.data!.addresses!;
    update();
    if (gstSearchModule.data!.addresses!.length == 1) {
      updateAddress();
    }
    addresses = gstSearchModule.data!.addresses!;
    companyName.text = gstSearchModule.data!.legalName!;
    panNumber.text = gstSearchModule.data!.gstin!.substring(2, 12);

    update();
  }

  updateAddress() {
    final indexAddress = addresses[selectedAddressIndex];
    final List<String> addressParts = [
      indexAddress.floorNumber,
      indexAddress.buildingNumber,
      indexAddress.buildingName,
      indexAddress.street,
      indexAddress.location,
      '${indexAddress.state}-${indexAddress.pincode}'
    ];

    final formattedAddress =
        addressParts.where((part) => part.trim().isNotEmpty).join(', ');
    companyAddress.text = formattedAddress;
    update();
  }

  signUpRequest() async {
    await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerSignUp,
      body: {
        'acceptedTermsId': "af3d3f10-5d8c-4d36-89ca-a7340f7c4590",
        'address': {
          'addressLine_1': companyAddress.text,
          'addressLine_2': "",
          'city': addresses[selectedAddressIndex].district,
          'district': addresses[selectedAddressIndex].district,
          'gstNumber': gstNumber.text,
          'partyName': companyName.text,
          'pincode': addresses[selectedAddressIndex].pincode,
          'state': addresses[selectedAddressIndex].state,
        },
        'companyName': companyName.text,
        'gst': gstNumber.text,
        'pan': panNumber.text,
        'password': password.text,
        'phone': "+91${phoneNumber.text}",
      },
    );
    enteredNumber = phoneNumber.text;
  }

  confirmSignUp() async {
    await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerConfirmSignUp,
      body: {'code': pinController.text, 'phone': '+91${phoneNumber.text}'},
    );
    enteredNumber = phoneNumber.text;

    update();
  }

  resendrequestOTP() async {
    await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerResendCode,
      body: {'phone': '+91${phoneNumber.text}'},
    );
  }
}
