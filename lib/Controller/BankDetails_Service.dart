import 'dart:convert';
import 'dart:io';

import 'package:autofon_seller/Controller/Home_Service.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Module/BankDetails_Module.dart';

class BankDetailService extends GetxController {
  final homeService = Get.find<HomeService>();
  late BankDetailModule bankDetailModule;
  File? image;

  Stream getData() async* {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path:
          '${ApiPaths.sellers}/${homeService.profileData.sellerId}/${ApiPaths.sellerBankDetails}',
      token: HiveService.getAuthToken(),
    );
    bankDetailModule = bankDetailModuleFromMap(jsonEncode(request));
  }

  updateBankDetail(
      {required String bankAccountNumber,
      required String bankName,
      required String ifsc,
      required String upi_id}) async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path:
            '${ApiPaths.sellers}/${homeService.profileData.sellerId}/${ApiPaths.sellerUpdateBankDetails}',
        token: HiveService.getAuthToken(),
        body: {
          'bankAccountNumber': bankAccountNumber,
          'bankName': bankName,
          'ifsc': ifsc,
          'upi_id': upi_id,
        });
    await _uploadImage();
  }

  Future<void> _uploadImage() async {
    if (image == null) return;

    final uri = Uri.parse(
        '${ApiPaths.devServerAddress}${ApiPaths.sellers}/${homeService.profileData.sellerId}${ApiPaths.cheque}');
    final request = http.MultipartRequest('PUT', uri);
    request.headers['Authorization'] = HiveService.getAuthToken();

    request.files.add(await http.MultipartFile.fromPath('file', image!.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Upload successful!');
      } else {
        print('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while uploading: $e');
    }
  }
}
