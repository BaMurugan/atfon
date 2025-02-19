import 'dart:convert';

import 'package:autofon_seller/Controller/Home_Service.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

import '../Module/GstTax_Module.dart';
import '../Module/ItTax_Module.dart';

class TaxDeductionService extends GetxController {
  final homeController = Get.find<HomeService>();
  int selectedNavBar = 0;
  int selectedMonth = 0;
  int selectedYear =
      DateTime.now().month <= 3 ? DateTime.now().year - 1 : DateTime.now().year;
  ItTaxModule itTaxModule = ItTaxModule();
  GstTaxModule gstTaxModule = GstTaxModule();

  Stream instilize() async* {
    await getData();
  }

  getData() async {
    String path =
        '${selectedNavBar == 0 ? ApiPaths.sellerItTax : ApiPaths.sellerGstTax}${homeController.profileData.sellerId}?financialYearFrom=$selectedYear&financialYearTo=${selectedYear + 1}';
    if (selectedMonth != 0) {
      path += '&month=${selectedMonth.toString().padLeft(2, '0')}';
    }
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: path,
      token: HiveService.getAuthToken(),
    );
    if (selectedNavBar == 0) {
      itTaxModule = itTaxModuleFromMap(jsonEncode(request));
    } else {
      gstTaxModule = gstTaxModuleFromMap(jsonEncode(request));
    }
    update();
  }
}
