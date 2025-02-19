import 'dart:convert';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteAccountService extends GetxController {
  String? errorMsg;

  Future<bool> deleteAccount(String password) async {
    final url =
        Uri.parse('${ApiPaths.devServerAddress}${ApiPaths.sellerUserDelete}');
    Map<String, String> headers = {};

    headers['Authorization'] = HiveService.getAuthToken();
    Map body = {'password': password};
    final request = await http.delete(url, headers: headers, body: body);
    if (request.statusCode != 200) {
      Get.snackbar('Error', jsonDecode(request.body)['message']);
      return false;
    }
    return true;
  }
}
