import 'dart:convert';

import 'package:autofon_seller/Module/SellerOrder_Module.dart';
import 'package:autofon_seller/Module/WalletData_Module.dart';
import 'package:autofon_seller/Module/Wallet_Module.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

import '../Module/Orders_Module.dart';

class PaymentBalanceService extends GetxController {
  late Wallet wallet;
  late WalletData walletData;
  int currentPage = 1;
  int totalPage = 0;
  late OrderModule sellerOrderModule;

  List transactions = [];
  Stream<WalletData> getWallet() async* {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.get,
        path: ApiPaths.sellerWallet,
        token: HiveService.getAuthToken());
    wallet = Wallet.fromMap(request['data']);

    update();
    final request1 = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerWalletTransaction,
        token: HiveService.getAuthToken(),
        body: {
          'page': currentPage,
          'size': 15,
          'walletId': wallet.id,
        });
    walletData = WalletData.fromMap(request1['data']);

    transactions.addAll(walletData.walletTransactions);
    currentPage = walletData.currentPage;
    totalPage = walletData.totalPages;
    update();
    yield walletData;
  }

  fetchData() async {
    if (currentPage + 1 <= totalPage) {
      final request1 = await ApiService.call(
          apiCallMethod: ApiCallMethod.post,
          path: ApiPaths.sellerWalletTransaction,
          token: HiveService.getAuthToken(),
          body: {
            'page': currentPage + 1,
            'size': 10,
            'walletId': wallet.id,
          });

      WalletData wallet1 = WalletData.fromMap(request1['data']);

      transactions.addAll(wallet1.walletTransactions);
      currentPage = wallet1.currentPage;
      totalPage = wallet1.totalPages;
    }
    update();
  }

  getOrderData(String id) async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerOrdersSearch,
        token: HiveService.getAuthToken(),
        body: {
          'orderId': id,
          'page': 1,
          'size': 10,
          'statuses': [
            "Processing",
            "Dispatched",
            "Delivered",
            "Cancelled",
            "Partially Dispatched",
            "Partially Delivered"
          ]
        });
    print(request);
    sellerOrderModule = orderModuleFromMap(jsonEncode(request));
    update();
  }
}
