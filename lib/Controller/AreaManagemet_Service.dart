import 'dart:convert';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Module/Pincode_Module.dart';
import '../Module/ServiceArea_Module.dart';
import '../Module/Area_Module.dart';

class AreaManagementService extends GetxController {
  ServiceArea sellerServiceArea = ServiceArea();
  List filteredList = [];
  List allStates = [];
  List selectedPincode = [];
  List allDistrict = [];
  String? state;
  String? district;
  List allPincodes = [];
  PincodeModule? pincode;
  dynamic query;

  int currentPage = 0;
  int totalPage = 0;

  Stream instilize({dynamic item}) async* {
    state = null;
    district = null;

    allDistrict.clear();
    allStates.clear();
    allPincodes.clear();
    currentPage = 0;
    totalPage = 0;

    await getServiceAreas();
    await getAllDropDownData();
    filteredList = sellerServiceArea.data!;
  }

  onChange() async {
    await getServiceAreas();
  }

  Stream getEditingData(dynamic item) async* {
    await getServiceAreas();
    await getAllDropDownData();
    state = item.state != '' && item.state != null ? item.state : null;
    district =
        item.district != '' && item.district != null ? item.district : null;
    query = item.serviceableAreas;

    await getAllDropDownData();

    currentPage = 0;
    totalPage = 0;
    update();
  }

  getServiceAreas() async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.get,
        path: ApiPaths.sellerServiceArea,
        token: HiveService.getAuthToken());
    sellerServiceArea = serviceAreaFromJson(jsonEncode(request));
    filteredList = sellerServiceArea.data!;
    update();
  }

  //delete the pincodes
  deletePincode(String id) async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.delete,
        path: '${ApiPaths.sellerServiceArea}/$id',
        token: HiveService.getAuthToken());
    await getServiceAreas();
    update();
  }

  getAllDropDownData() async {
    Map body = {};

    if (state != null) {
      body['state'] = [state];
    }
    if (district != null) {
      body['districts'] = [district];
    }
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.pincodesHierarchy,
      token: HiveService.getAuthToken(),
      body: body,
    );
    final data = areaModuleFromMap(jsonEncode(request));
    if (state != null) {
      allDistrict = data.data!.results!;
    } else {
      allStates = data.data!.results!;
    }
    getPincodes();
    update();
  }

  getPincodes() async {
    Map body = {'page': 0, 'size': 20};
    if (query != "") {
      body['query'] = query;
    }

    if (state == null) return;
    if (state != null) {
      body['states'] = [state];
    }
    if (district != null) {
      body['districts'] = [district];
    }

    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path: ApiPaths.pincodeSearch,
      token: HiveService.getAuthToken(),
      body: body,
    );

    final temp = pincodeModuleFromJson(jsonEncode(request));
    currentPage = temp.data!.currentPage!;
    totalPage = temp.data!.totalPages!;
    allPincodes.clear();
    allPincodes.addAll(temp.data!.pincodes!);

    update();
  }

  getMore() async {
    if (currentPage + 1 < totalPage) {
      Map body = {'page': currentPage + 1, 'size': 20};
      if (state == null) return;

      if (state != null) {
        body['states'] = [state];
      }
      if (query != '') {
        body['query'] = query;
      }
      if (district != null) {
        body['districts'] = [district];
      }

      final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path: ApiPaths.pincodeSearch,
        token: HiveService.getAuthToken(),
        body: body,
      );

      final temp = pincodeModuleFromJson(jsonEncode(request));
      currentPage = temp.data!.currentPage!;
      totalPage = temp.data!.totalPages!;
      allPincodes.addAll(temp.data!.pincodes!);

      update();
    }
  }

  saveAll(String name, {bool isEdit = false, String? id}) async {
    final request = await ApiService.call(
        apiCallMethod:isEdit?ApiCallMethod.put: ApiCallMethod.post,
        path: isEdit
            ? '${ApiPaths.sellerServiceArea}/$id'
            : ApiPaths.sellerServiceArea,
        token: HiveService.getAuthToken(),
        body: {
          'district': district ?? '',
          'name': name,
          'serviceableAreas': selectedPincode,
          'state': state ?? ''
        });

    await onChange();
    update();
  }
}
