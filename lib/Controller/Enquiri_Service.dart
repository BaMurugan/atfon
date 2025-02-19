import 'dart:convert';

import 'package:autofon_seller/Module/Enquirie_Module.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

class EnquiriService extends GetxController {
  late Enquirie quoteEnquiry;
  List<QuoteEnquiry> enquiry = [];
  int currentPage = 0;
  int totalPage = 0;

  Stream instilize() async* {
    await getData();
  }

  getData() async {
    enquiry = [];

    Map request = await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerSearchEnquiries,
      token: HiveService.getAuthToken(),
      body: {
        'size': 10,
        'page': 1,
        'statuses': ["Open"],
        'sortBy': "createdAt",
        'sortDirection': "DESC"
      },
    );
    quoteEnquiry = enquirieFromMap(jsonEncode(request));

    enquiry.addAll(quoteEnquiry.data!.quoteEnquiries!);
    currentPage = quoteEnquiry.data!.currentPage!;
    totalPage = quoteEnquiry.data!.totalPages!;

    update();
  }

  fetchNextData() async {
    if (currentPage + 1 <= totalPage) {
      Map request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerSearchEnquiries,
        token: HiveService.getAuthToken(),
        body: {
          'size': 10,
          'page': currentPage + 1,
          'statuses': ["Open"],
          'sortBy': "createdAt",
          'sortDirection': "DESC"
        },
      );
      final item = enquirieFromMap(jsonEncode(request)).data;
      enquiry.addAll(item!.quoteEnquiries!);
      currentPage = item.currentPage!;
      totalPage = item.totalPages!;
      update();
      return;
    }
  }

  createQuote({required String quoteId}) async {
    final data = await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerQuotesCreateQuote,
      token: HiveService.getAuthToken(),
      body: {'quoteEnquiryId': quoteId},
    );
    update();
    getData();
    return data['data']['id'];
  }
}
