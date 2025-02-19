import 'dart:convert';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

import '../Module/Inquiries_Module.dart';

class InquirieService extends GetxController {
  late InquiriesModule inquiriesModule;
  List userInquiries = [];
  int currentPage = 0;
  int totalPage = 0;

  Stream<dynamic> getData() async* {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerInquiriesSearch,
        token: HiveService.getAuthToken(),
        body: {'page': 0, 'size': 10});
    inquiriesModule = inquiriesModuleFromMap(jsonEncode(request));
    userInquiries.clear();
    userInquiries.addAll(inquiriesModule.data!.userInquiries!);
    totalPage = inquiriesModule.data!.totalPages!;
    currentPage = inquiriesModule.data!.currentPage!;

    yield inquiriesModule;
  }

  addInquirie({required String category, required String message}) async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerInquiries,
        token: HiveService.getAuthToken(),
        body: {'category': category, 'message': message});
  }

  fetchDeta() async {
    if (currentPage + 1 < totalPage) {
      final request = await ApiService.call(
          apiCallMethod: ApiCallMethod.post,
          path: ApiPaths.sellerInquiriesSearch,
          token: HiveService.getAuthToken(),
          body: {'page': currentPage + 1, 'size': 10});
      final newInquiriesModule = inquiriesModuleFromMap(jsonEncode(request));
      userInquiries.addAll(newInquiriesModule.data!.userInquiries!);
      totalPage = newInquiriesModule.data!.totalPages!;
      currentPage = newInquiriesModule.data!.currentPage!;
    }
    update();
  }
}
