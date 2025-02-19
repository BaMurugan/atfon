import 'dart:convert';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Module/ProfileAddress_Module.dart';
import '../Module/RewardPoints_Module.dart';
import '../Module/SellerType_Module.dart';
import '../Module/UserPoint_Module.dart';
import '../Module/User_Module.dart';
import '../Module/WalletBalance_Module.dart';
import '../Other Service/ApiService.dart';
import '../Other Service/HiveStoreage.dart';
import 'Home_Service.dart';

class ProfileService extends GetxController {
  late ProfileAddress profileAddress;
  late User user;
  late UserPoint userPoint;
  late SellerTypeModule sellerTypeModule;
  late RewardPointModule rewardPointModule;
  late WalletBalance walletBalance;

  final profile = Get.find<HomeService>();
  int emailVerifyPageNumber = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  Stream<dynamic> instilize() async* {
    await setInstilize();
    yield null;
  }

  setInstilize() async {
    await getProfileAddress();
    await getPoint();
    await getUser();
    await getSellerType();
    await getPointsTransaction();
    await getWalletBalance();
    update();
  }

  getProfileAddress() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: ApiPaths.userProfileAddress,
      token: HiveService.getAuthToken(),
    );
    profileAddress = profileAddressFromMap(jsonEncode(request));
    update();
  }

  getWalletBalance() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: ApiPaths.sellerUserWallet,
      token: HiveService.getAuthToken(),
    );
    walletBalance = walletBalanceFromJson(jsonEncode(request));
  }

  getUser() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellers}/${profile.profileData.sellerId}',
      token: HiveService.getAuthToken(),
    );
    user = userFromMap(jsonEncode(request));
  }

  getPoint() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: ApiPaths.sellerPoints,
      token: HiveService.getAuthToken(),
    );
    userPoint = userPointFromMap(jsonEncode(request));
  }

  getPointsTransaction() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: ApiPaths.sellerPointsTransaction,
      token: HiveService.getAuthToken(),
    );
    rewardPointModule = rewardPointModuleFromJson(jsonEncode(request));
    update();
  }

  getSellerType() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellerTypeChange}/${user.data!.userId}',
      token: HiveService.getAuthToken(),
    );
    sellerTypeModule = sellerTypeModuleFromMap(jsonEncode(request));
  }

  requestEdit() async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path: ApiPaths.sellerEmailUpdate,
        token: HiveService.getAuthToken(),
        body: {
          'email': emailController.text,
          'id': user.data!.userId,
          'password': passwordController.text,
          'phone': user.data!.user!.phone,
        });
  }

  verifyEdit() async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerVerifyEmail,
        token: HiveService.getAuthToken(),
        body: {
          'code': pinController.text,
          'email': emailController.text,
          'id': user.data!.userId,
          'phone': user.data!.user!.phone,
        });
  }

  updateUser({bool sellerType = false, String? requestedType}) async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path: sellerType
            ? '${ApiPaths.sellers}/${user.data!.id}/update/seller-type'
            : '${ApiPaths.sellers}/${user.data!.id}/update',
        token: HiveService.getAuthToken(),
        body: sellerType
            ? {'sellerType': requestedType}
            : {'availability': user.data!.availability});
    await profile.getUser();
  }

  updateSellerType({bool delete = false, String? requestedType}) async {
    await ApiService.call(
      apiCallMethod: delete ? ApiCallMethod.delete : ApiCallMethod.post,
      path: delete
          ? '${ApiPaths.sellerTypeChange}/${user.data!.userId}'
          : ApiPaths.sellerTypeChangeCreate,
      token: HiveService.getAuthToken(),
      body: {
        'currentType': user.data?.sellerType,
        'requestedType': requestedType,
        'sellerId': user.data!.id,
        'userId': user.data!.userId
      },
    );
  }
}
