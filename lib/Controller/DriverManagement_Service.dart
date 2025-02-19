import 'dart:convert';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';
import 'package:autofon_seller/Module/DeliverManagement_Module.dart';

class DriverManagementService extends GetxController {
  late DeliveryPersons deliveryPersons;
  int currentPage = 0;
  int totalPage = 0;
  bool scrollEnable = false;
  List persons = [];

  @override
  void onInit() {
    scrollEnable = false;
    super.onInit();
  }

  Stream instilize() async* {
    await getData();
  }

  getData() async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.deliveryPersonsSearch,
        token: HiveService.getAuthToken(),
        body: {'searchText': "", 'page': 0, 'size': 10});
    deliveryPersons = deliveryPersonsFromMap(jsonEncode(request));
    persons.clear();
    persons.addAll(deliveryPersons.data!.deliveryPersons!);

    currentPage = deliveryPersons.data!.currentPage!;
    totalPage = deliveryPersons.data!.totalPages!;
    update();
  }

  deliveryPerson(
      {required String name,
      required String phoneNumber,
      required String vehicleNumber,
      String id = ''}) async {
    final request = await ApiService.call(
        apiCallMethod: id == '' ? ApiCallMethod.post : ApiCallMethod.put,
        path: '${ApiPaths.deliveryPersons}/$id',
        token: HiveService.getAuthToken(),
        body: {
          'name': name,
          'phoneNumber': phoneNumber,
          'vehicleNumber': vehicleNumber
        });
    getData();
  }

  deleteDeliveryPerson({required String id}) async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.delete,
        path: '${ApiPaths.deliveryPersons}/$id',
        token: HiveService.getAuthToken());
    getData();
  }

  fetchNextData() async {
    if (currentPage + 1 < totalPage) {
      final request = await ApiService.call(
          apiCallMethod: ApiCallMethod.post,
          path: ApiPaths.deliveryPersonsSearch,
          token: HiveService.getAuthToken(),
          body: {'searchText': "", 'page': currentPage + 1, 'size': 10});
      final additionalData = deliveryPersonsFromMap(jsonEncode(request));

      persons.addAll(additionalData.data!.deliveryPersons!);
      currentPage = additionalData.data!.currentPage!;
      totalPage = additionalData.data!.totalPages!;
      scrollEnable = true;
      update();
    }
  }

  searchPersons({String search = ""}) async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.deliveryPersonsSearch,
        token: HiveService.getAuthToken(),
        body: {'searchText': search, 'page': 0, 'size': 10});
    deliveryPersons = deliveryPersonsFromMap(jsonEncode(request));
    persons.clear();
    persons.addAll(deliveryPersons.data!.deliveryPersons!);
    currentPage = deliveryPersons.data!.currentPage!;
    totalPage = deliveryPersons.data!.totalPages!;
    update();
  }
}
