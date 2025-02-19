import 'dart:convert';

import 'package:autofon_seller/Module/Quote_Module.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Other Service/HiveStoreage.dart'; // Assuming HiveService uses Hive

class QuoteService extends GetxController {
  List<Quote> quote = [];
  int currentPage = 0;
  int totalPage = 0;
  Quotes? quotes;
  late Stream<Quotes> streamControl;

  Stream instilize() async* {
    await getData();
  }

  getData() async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerQuotesSearch,
        token: HiveService.getAuthToken(),
        body: {
          'page': 1,
          'size': 10,
          'sortBy': "createdAt",
          'sortDirection': "DESC",
          'statuses': ["Draft", "Submitted", "RequoteRequested"],
        });
    quotes = quotesFromMap(jsonEncode(request));

    currentPage = quotes?.data!.currentPage ?? 0;
    totalPage = quotes?.data!.totalPages ?? 0;
    quote = quotes?.data!.quotes ?? [];
    update();
  }

  nextSetData() async {
    if (currentPage + 1 <= totalPage) {
      final request = await ApiService.call(
          apiCallMethod: ApiCallMethod.post,
          path: ApiPaths.sellerQuotesSearch,
          token: HiveService.getAuthToken(),
          body: {
            'page': currentPage + 1,
            'size': 10,
            'sortBy': "createdAt",
            'sortDirection': "DESC",
            'statuses': ["Draft", "Submitted", "RequoteRequested"],
          });
      final item = quotesFromMap(jsonEncode(request)).data!;
      currentPage = item.currentPage ?? 0;
      totalPage = item.totalPages ?? 0;
      quote.addAll(item.quotes ?? []);
      update();
    }
  }

  deleteQuote(String id) async {
    try {
      await ApiService.call(
          apiCallMethod: ApiCallMethod.delete,
          path: "${ApiPaths.sellerQuotes}/$id",
          token: HiveService.getAuthToken());

      getData();
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
