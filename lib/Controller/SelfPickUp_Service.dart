import 'dart:convert';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

import '../Module/SelfPickUp_Module.dart';

class SelfPickUpService extends GetxController {
  late SelfPickUpModule selfPickUpModule;

  Stream<void> getData() async* {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.selfPickUpPincodeSearch,
      token: HiveService.getAuthToken(),
      body: {'searchText': "", 'page': 0, 'size': 40},
    );
    selfPickUpModule = selfPickUpModuleFromMap(jsonEncode(request));
    print("called");
    update();
    return;
  }

  updateData({required String id, Map? body, required bool edit}) async {
    final request = await ApiService.call(
        apiCallMethod: edit ? ApiCallMethod.put : ApiCallMethod.delete,
        path: "${ApiPaths.selfPickUpPincode}/$id",
        token: HiveService.getAuthToken(),
        body: body);

    update();
  }

  addData(String name, List pincodes) async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.selfPickUpPincode,
        token: HiveService.getAuthToken(),
        body: {'name': name, 'pincodes': pincodes});

    update();
  }
}
