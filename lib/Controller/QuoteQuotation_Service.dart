import 'dart:convert';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Module/DeliveryCharge_Module.dart';
import '../Module/QuoteQuotation_Module.dart';
import 'Quote_Service.dart';

class QuoteQuotationService extends GetxController {
  late QuoteQuotationModule quoteQuotationModule;
  late DeliveryChargeModule deliveryCharge;
  late String quoteId;
  String? selectedQuotation;
  DateTime? selectedDate;
  String? selectedTimeSlot;
  String selectedOption = 'buyer';

  bool preview = false;
  bool show = true;
  Stream instilize(String id) async* {
    quoteId = id;
    selectedQuotation = null;
    selectedDate = null;
    selectedTimeSlot = null;
    selectedOption = 'buyer';

    await getData();

    await getDelivery();
  }

  getData() async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.get,
        path: '${ApiPaths.sellerQuotes}/$quoteId',
        token: HiveService.getAuthToken());
    quoteQuotationModule = quoteQuotationModuleFromMap(jsonEncode(request));

    show = true;
    if (quoteQuotationModule.data!.status == 'Submitted') {
      show = false;
      preview = true;
      if (quoteQuotationModule.data!.quoteRequest!.deliveryPreference!
              .sellerExpectedDeliveryDate !=
          null) {
        selectedDate = quoteQuotationModule
            .data!.quoteRequest!.deliveryPreference!.sellerExpectedDeliveryDate!
            .toLocal();
        selectedOption = 'seller';
      }
      if (quoteQuotationModule.data!.quoteRequest!.deliveryPreference!
              .sellerExpectedDeliveryTime !=
          null) {
        selectedTimeSlot = quoteQuotationModule.data!.quoteRequest!
            .deliveryPreference!.sellerExpectedDeliveryTime!;
      }
    }

    update();
  }

  getDelivery() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: ApiPaths.deliveryChargesType,
      token: HiveService.getAuthToken(),
    );
    deliveryCharge = deliveryChargeModuleFromMap(jsonEncode(request));
    update();
  }

  updateQuoteItem({
    required Map body,
    required String id,
  }) async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path: '${ApiPaths.sellerUpdateQuoteLineItem}/$id',
        token: HiveService.getAuthToken(),
        body: body);
    await getData();
    update();
  }

  updateQuote(Map body, {String? addURL}) async {
    String url = '${ApiPaths.sellerQuotes}/$quoteId';
    if (addURL != null) {
      url = url + addURL;
    }

    try {
      final request = await ApiService.call(
          apiCallMethod: ApiCallMethod.put,
          path: url,
          token: HiveService.getAuthToken(),
          body: body);

      await getData();
    } catch (e) {
      print(e.toString());
    }
    update();
  }

  updateUOM(Map body, {String? addURL}) async {
    String url = '${ApiPaths.sellerQuotes}';
    if (addURL != null) {
      url = url + addURL;
    }

    try {
      final request = await ApiService.call(
          apiCallMethod: ApiCallMethod.put,
          path: url,
          token: HiveService.getAuthToken(),
          body: body);
      await getData();
    } catch (e) {
      print(e.toString());
    }
  }

  deleteQuote({String addURL = ''}) async {
    String url = '${ApiPaths.sellerQuotes}/$quoteId';
    if (addURL != '') {
      url = url + addURL;
    }
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.delete,
      path: url,
      token: HiveService.getAuthToken(),
    );
    await getData();
  }

  addQuote(Map body, {String addURL = ''}) async {
    String url = '${ApiPaths.sellerQuotes}/$quoteId';
    if (addURL != '') {
      url = url + addURL;
    }
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: url,
        token: HiveService.getAuthToken(),
        body: body);
    await getData();
  }
}
