import 'dart:convert';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

import '../Module/ProductDescription_Module.dart';

class ProductDescriptionService extends GetxController {
  late ProductDescriptionModule productDescriptionModule;
  Stream instilize(id) async* {
    await getData(id);
  }

  getData(String id) async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.products}/$id',
      token: HiveService.getAuthToken(),
    );
    productDescriptionModule =
        productDescriptionModuleFromMap(jsonEncode(request));
    update();
  }
}
