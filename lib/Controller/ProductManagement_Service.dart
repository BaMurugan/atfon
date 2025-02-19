import 'dart:convert';

import 'package:autofon_seller/Controller/Home_Service.dart';
import 'package:autofon_seller/Module/ServiceArea_Module.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';
import '../Module/Brand_Module.dart';
import '../Module/Hierarchy_Module.dart';
import '../Module/Manufacturer_Module.dart';
import '../Module/MinMax_Module.dart';
import '../Module/ProductManagement_Module.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'Product_Service.dart';

class ProductManagementService extends GetxController {
  final profileData = Get.find<HomeService>();
  final productService = Get.put(ProductService());

  late int totalPages;
  late int currentPages;
  late int totalSellerProduct;
  List items = [];
  List selectedProductID = [];
  List selectedId = [];
  List selectedArea = [];
  late ServiceArea serviceArea;
  List selectedManufacturer = [];
  List selectedGroup = [];
  List selectedBrand = [];
  List selectedMinMaxPinCode = [];

  late Stream<ProductManagementModel> productController;

  late ManufacturersModel manufacturersModel;
  late BrandModel brandModel;
  late HierarchyModel hierarchyModel;
  late ServiceArea areas;
  late MinMaxModule minMaxModule;

  List<Subcategory> hierarchyModelBranches = [];

  Stream<dynamic> initialize() async* {
    selectedProductID.clear();
    selectedId.clear();

    await getServiceArea();
    await getProduct();

    await productService.getManufacturer();

    await productService.getBrand();
    await productService.getHierarchy();

    brandModel = productService.brandModel;
    hierarchyModel = productService.hierarchyModel;
    hierarchyModelBranches = productService.hierarchyModelBranches;
    manufacturersModel = productService.manufacturersModel;
    update();
    yield null;
  }

  getProduct({String nameQuery = "", int? index}) async {
    Map body = {'page': 0, 'size': 10, 'nameQuery': nameQuery};
    if (index == 0) {
      body['branchId'] = selectedGroup;
    }
    if (index == 1) {
      body['manufacturerId'] = selectedManufacturer;
    }
    if (index == 2) {
      body['brandId'] = selectedBrand;
    }

    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.post,
      path:
          "/sellers/${profileData.profileData.sellerId}${ApiPaths.productsSearch}",
      token: HiveService.getAuthToken(),
      body: body,
    );

    final productManagement = ProductManagementModel.fromMap(request['data']);
    totalPages = productManagement.totalPages!;
    currentPages = productManagement.currentPage!;
    totalSellerProduct = productManagement.totalSellerProducts!;
    items.clear();
    items.addAll(productManagement.sellerProducts!);
    update();
  }

  fetchNextPage() async {
    if (currentPages + 1 < totalPages) {
      final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path:
            "/sellers/${profileData.profileData.sellerId}${ApiPaths.productsSearch}",
        token: HiveService.getAuthToken(),
        body: {'page': currentPages + 1, 'size': 10},
      );
      final productManagement = ProductManagementModel.fromMap(request['data']);
      totalPages = productManagement.totalPages!;
      currentPages = productManagement.currentPage!;
      totalSellerProduct = productManagement.totalSellerProducts!;
      items.addAll(productManagement.sellerProducts!);
    }
    update();
  }

  getServiceArea() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: ApiPaths.sellerServiceArea,
      token: HiveService.getAuthToken(),
    );
    serviceArea = serviceAreaFromJson(jsonEncode(request));
    update();
  }

  selectServicingArea() async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path:
            '${ApiPaths.sellers}/${profileData.profileData.sellerId}${ApiPaths.sellerProductBulk}',
        token: HiveService.getAuthToken(),
        body: {
          'productIds': selectedProductID,
          'serviceAreaIds': selectedArea
        });
  }

  selectDeleteProducts() async {
    var headers = {"Content-Type": "application/json"};
    headers['Authorization'] = HiveService.getAuthToken();
    final response = await http.delete(
      Uri.parse(
          '${ApiPaths.devServerAddress}${ApiPaths.sellers}/${profileData.profileData.sellerId}${ApiPaths.sellerProductBulk}'),
      headers: headers,
      body: jsonEncode({'sellerProductIds': selectedId}),
    );
  }

  deleteProduct({required String id}) async {
    var headers = {"Content-Type": "application/json"};
    headers['Authorization'] = HiveService.getAuthToken();

    final response = await http.delete(
      Uri.parse(
          '${ApiPaths.devServerAddress}${ApiPaths.sellers}/${profileData.profileData.sellerId}${ApiPaths.sellerProductBulk}'),
      headers: headers,
      body: jsonEncode({
        'sellerProductIds': [id]
      }),
    );
  }

  getMinMax(String id) async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellers}${ApiPaths.sellerProduct}/$id',
      token: HiveService.getAuthToken(),
    );
    minMaxModule = minMaxModuleFromMap(jsonEncode(request));
  }

  setMinMax(
      {required int min, required int max, required String productId}) async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path:
            '${ApiPaths.sellers}/${profileData.profileData.sellerId}${ApiPaths.sellersProductsBulk}',
        token: HiveService.getAuthToken(),
        body: {
          'maximumQuantity': max,
          'minimumQuantity': min,
          'pincodes': selectedMinMaxPinCode,
          'productId': productId,
        });
  }
}
