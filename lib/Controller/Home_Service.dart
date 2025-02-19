import 'dart:convert';

import 'package:autofon_seller/Module/Profile_Model.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

import '../Module/UOM_Module.dart';
import '../Module/User_Module.dart';
import 'Profile_Service.dart';

class HomeService extends GetxController {
  late ProfileModel profileData;
  late User user;
  late UomModule uom;
  int selectedHomePageIndex = 0;

  bool available = true;

  @override
  void onInit() async {
    await getProfile();
    await getUser();

    super.onInit();
  }

  getProfile() async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.get,
        path: ApiPaths.sellerProfile,
        token: HiveService.getAuthToken());
    profileData = ProfileModel.fromMap(request['data']);
    update();
  }

  getUser() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellers}/${profileData.sellerId}',
      token: HiveService.getAuthToken(),
    );
    user = userFromMap(jsonEncode(request));
    available = user.data!.availability!;
    update();
  }
}
