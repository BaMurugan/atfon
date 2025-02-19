import 'dart:convert';

import 'package:autofon_seller/Module/DecimalPlaces_Module.dart';
import 'package:autofon_seller/Module/Orders_Module.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Module/DeliverManagement_Module.dart';
import '../Module/DeliveryCharge_Module.dart';
import '../Module/Invoice_Module.dart';
import '../Module/SellerOrder_Module.dart';
import '../Module/SellerQuote_Module.dart';
import '../Module/Shipment_Module.dart';
import '../Other Service/ApiService.dart';

class OrderService extends GetxController {
  late OrderModule orderModule;
  bool allInOneShipment = false;
  double totalAmount = 0;
  double totalTax = 0;
  double totalCommission = 0;
  int currentPage = 0;
  int totalPage = 0;
  String quoteId = '';
  String orderId = '';
  List orders = [];
  List selectedItems = [];
  List selectedCharge = [];
  bool isEdit = false;
  bool isStarted = false;
  double ltq = 0;
  double utq = 0;
  late DeliveryChargeModule deliveryCharge;
  late SellerQuoteModule sellerQuoteModule;
  late SellerOrderModule sellerOrderModule;
  late DeliveryPersons deliveryPersons;
  int selectedDeliverPerson = 0;
  TextEditingController invoiceName = TextEditingController();
  TextEditingController creditNote = TextEditingController();
  late DecimalPlaceModule decimalPlaceModule;

  Stream instilize() async* {
    await getData();
    await getDelivery();
  }

  Stream getViewOrderDetails({String? qteId, required String odrId}) async* {
    if (qteId != null) quoteId = qteId;
    orderId = odrId;
    totalAmount = 0;
    totalTax = 0;
    totalCommission = 0;
    selectedDeliverPerson = 0;
    isEdit = false;

    await getSellerOrder(odrId);
    qteId = sellerOrderModule.data!.quoteId!;
    await getSellerQuote(qteId);
    await getDeliveryPersons();
    await getDelivery();
  }

  getSellerOrder(String id) async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellerOrders}/$id',
      token: HiveService.getAuthToken(),
    );
    sellerOrderModule = sellerOrderModuleFromMap(jsonEncode(request));

    totalCommission = sellerOrderModule.data!.allShipmentDeliveryCharges!
        .fold(0.0, (sum, item) => sum + double.parse(item.commissionAmount!));
    update();
  }

  getDeliveryPersons({String personName = ''}) async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.deliveryPersonsSearch,
        token: HiveService.getAuthToken(),
        body: {'searchText': personName, 'page': 0, 'size': 500});
    deliveryPersons = deliveryPersonsFromMap(jsonEncode(request));
    update();
  }

  getSellerQuote(String id) async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellerQuotes}/$id',
      token: HiveService.getAuthToken(),
    );

    sellerQuoteModule = sellerQuoteModuleFromMap(jsonEncode(request));
    update();
  }

  getDelivery() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: ApiPaths.deliveryChargesType,
      token: HiveService.getAuthToken(),
    );

    deliveryCharge = deliveryChargeModuleFromMap(jsonEncode(request));
  }

  getData() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.sellerOrdersSearch,
      token: HiveService.getAuthToken(),
      body: {
        'orderId': null,
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
      },
    );
    orderModule = orderModuleFromMap(jsonEncode(request));
    currentPage = orderModule.data!.currentPage!;
    totalPage = orderModule.data!.totalPages!;
    orders = orderModule.data!.orders!;
    update();
  }

  fetchNextPage() async {
    if (isStarted) {
      return;
    }
    isStarted = true;

    if (currentPage + 1 <= totalPage) {
      final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.sellerOrdersSearch,
        token: HiveService.getAuthToken(),
        body: {
          'orderId': null,
          'page': currentPage + 1,
          'size': 10,
          'statuses': [
            "Processing",
            "Dispatched",
            "Delivered",
            "Cancelled",
            "Partially Dispatched",
            "Partially Delivered"
          ]
        },
      );
      final orderRequest = orderModuleFromMap(jsonEncode(request));
      currentPage = orderRequest.data!.currentPage!;
      totalPage = orderRequest.data!.totalPages!;
      orders.addAll(orderRequest.data!.orders!);
      update();
    }
    isStarted = false;
  }

  getShipmentData(String id) async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellerOrders}/$id/${ApiPaths.sellerShipmentInvoice}',
      token: HiveService.getAuthToken(),
    );
    ShipmentModule shipmentModule = shipmentModuleFromMap(jsonEncode(request));
    return shipmentModule;
  }

  updateOrder({String? path, Map? body}) async {
    String url = ApiPaths.sellerOrders;
    body ??= {};
    if (path != null) {
      url += path;
    }

    await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path: url,
        token: HiveService.getAuthToken(),
        body: body);
    await getSellerQuote(quoteId);
    await getSellerOrder(orderId);
    update();
  }

  deleteShipment(String id) async {
    await ApiService.call(
      apiCallMethod: ApiCallMethod.delete,
      path: '${ApiPaths.sellerShipments}/$id',
      token: HiveService.getAuthToken(),
    );
    await getSellerQuote(quoteId);
    await getSellerOrder(orderId);
    update();
  }

  updateShipment({required String path, Map? body}) async {
    await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: path,
      token: HiveService.getAuthToken(),
      body: body ?? {},
    );
    await getSellerQuote(quoteId);
    await getSellerOrder(orderId);
    update();
  }

  bool isItemSelected(String itemId, int ind) {
    if (ind == 0) {
      return selectedItems.any((item) => item['orderLineItemId'] == itemId);
    } else {
      return selectedCharge
          .any((item) => item['quoteDeliveryChargeId'] == itemId);
    }
  }

  void addItem(Map<String, dynamic> item, int ind) {
    if (ind == 0) {
      selectedItems.add(item);
    } else {
      selectedCharge.add(item);
    }

    update();
  }

  void removeItem(String itemId, int ind) {
    if (ind == 0) {
      selectedItems.removeWhere((item) => item['orderLineItemId'] == itemId);
    } else {
      selectedCharge
          .removeWhere((item) => item['quoteDeliveryChargeId'] == itemId);
    }
    update();
  }

  void updateItem(Map<String, dynamic> item, int ind) {
    if (ind == 0) {
      for (int i = 0; i < selectedItems.length; i++) {
        if (selectedItems[i]['id'] == item['id']) {
          selectedItems[i]['units'] = item['units'];
        }
      }
      update();
    } else {
      final element = selectedCharge.firstWhere(
        (element) =>
            element['quoteDeliveryChargeId'] == item['quoteDeliveryChargeId'],
        orElse: () => null,
      );
      if (element != null) {
        element['charge'] = item['charge'];
      }
    }

    update();
  }

  postDatas() async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: "/shipments",
        token: HiveService.getAuthToken(),
        body: {
          'deliveryCharges': selectedCharge,
          'orderId': orderId,
          'shipmentItems': selectedItems
        });

    await getSellerQuote(quoteId);
    await getSellerOrder(orderId);
    update();
  }

  uom() async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.get,
        path: '/uom-values',
        token: HiveService.getAuthToken());
  }

  getInvoice(String id) async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellerShipments}/$id/invoices',
      token: HiveService.getAuthToken(),
    );
    final invoiceModule = invoiceModuleFromJson(jsonEncode(request));
    return invoiceModule;
  }

  updateTolerance(String id, String quantity) async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path: '${ApiPaths.sellerOrderUpdateTolerance}/$id',
        token: HiveService.getAuthToken(),
        body: {'quantity': quantity});
    await getSellerQuote(quoteId);
    await getSellerOrder(orderId);
  }

  getDecimalPlace(String uom) async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellerUomValue}$uom',
      token: HiveService.getAuthToken(),
    );
    decimalPlaceModule = decimalPlaceModuleFromJson(jsonEncode(request));

    update();
  }

  void getTolerance(String id, dynamic selectedItem) {
    final orderDetail = sellerOrderModule.data;
    final matchedProduct = orderDetail?.orderLineItems!
        .firstWhere((orderLineItem) => orderLineItem.id == id);

    final completedShipments = orderDetail?.orderLineItems!
        .where((orderLineItem) =>
            !(orderDetail.pendingShipmentLineItems
                    ?.any((x) => x.id == orderLineItem.id) ??
                false) ||
            orderLineItem.isToleranceApplied!)
        .map((selectedLineItem) => selectedLineItem.id)
        .toList();

    final toleranceAppliedTotalPrice = orderDetail?.orderLineItems!.fold(
          matchedProduct?.itemTotalPrice ?? 0.0,
          (acc, orderLineItem) => orderLineItem.isToleranceApplied!
              ? double.parse(acc.toString()) +
                  double.parse(orderLineItem.itemTotalPrice ?? 0.0.toString())
              : acc,
        ) ??
        0.0;

    final filteredCompletedShipments =
        orderDetail?.orderLineItems?.where((orderLineItem) {
              final isInPending = orderDetail.pendingShipmentLineItems
                      ?.any((x) => x.id == orderLineItem.id) ??
                  false;
              return !isInPending && !orderLineItem.isToleranceApplied!;
            }).toList() ??
            [];

    final filteredCompletedTotalPrice = filteredCompletedShipments.fold(
        0.0,
        (acc, orderLineItem) =>
            acc +
            (double.parse(orderLineItem.itemTotalPrice ?? '0.0'.toString())));

    final finalTotalPrice =
        double.parse(toleranceAppliedTotalPrice.toString()) +
            double.parse(filteredCompletedTotalPrice.toString());

    final completedShipmentsTotalPrice = orderDetail?.shipments!.fold(0.0,
            (acc, lineItem) {
          final lineItemTotal =
              lineItem.shipmentLineItems!.fold(0.0, (accc, shipmentLineItem) {
            if (completedShipments!
                    .contains(shipmentLineItem.orderLineItemId) ||
                shipmentLineItem.orderLineItemId == selectedItem.id) {
              return accc +
                  ((double.parse('${shipmentLineItem.itemTotalPrice}') ?? 0.0));
            }
            return accc;
          });
          return acc + lineItemTotal;
        }) ??
        0.0;

    final totalPrice = orderDetail?.pendingShipmentLineItems!.fold(
          completedShipmentsTotalPrice,
          (acc, lineItem) => lineItem.isToleranceApplied!
              ? acc + (double.parse(lineItem.itemTotalPrice.toString()) ?? 0.0)
              : acc,
        ) ??
        completedShipmentsTotalPrice;

    double totalOrderedValue = orderDetail?.orderLineItems?.fold(
            0.0,
            (acc, curr) =>
                double.parse(acc.toString()) +
                (double.parse(curr.itemTotalPrice!) ?? 0.0)) ??
        0.0;

    if ((orderDetail?.quote?.deliveryCharges?.length ?? 0) > 0) {
      final totalDeliveryCharges = orderDetail?.quote?.deliveryCharges?.fold(
              0.0,
              (acc, curr) =>
                  acc + (double.parse(curr.charge.toString()) ?? 0.0)) ??
          0.0;
      totalOrderedValue += totalDeliveryCharges;
    }

    final lowerToleranceConfigDecimal = 0.05;
    final upperToleranceConfigDecimal = 0.05;

    ltq = (totalOrderedValue * -lowerToleranceConfigDecimal +
            finalTotalPrice -
            totalPrice) /
        (double.parse(selectedItem.itemPrice.toString()) ?? 1);

    utq = (totalOrderedValue * upperToleranceConfigDecimal +
            finalTotalPrice -
            totalPrice) /
        (double.parse(selectedItem!.itemPrice.toString()) ?? 1);
  }
}
