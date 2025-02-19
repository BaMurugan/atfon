import 'dart:convert';

import 'package:autofon_seller/Controller/AreaManagemet_Service.dart';
import 'package:autofon_seller/Controller/Home_Service.dart';
import 'package:autofon_seller/Module/Brand_Module.dart';
import 'package:autofon_seller/Module/Hierarchy_Module.dart';
import 'package:autofon_seller/Module/Manufacturer_Module.dart';
import 'package:autofon_seller/Module/Products_Module.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';

import '../Module/ServiceArea_Module.dart';

class ProductService extends GetxController {
  final areaController = Get.put(AreaManagementService());
  final getProfile = Get.find<HomeService>();
  int currentPage = 0;
  int totalPages = 0;
  int totalItems = 0;
  List<Product> products = [];
  List selectedProduct = [];
  List selectedArea = [];
  List selectedGroup = [];
  List selectedManufacturer = [];
  List selectedBrand = [];

  late ManufacturersModel manufacturersModel;
  late BrandModel brandModel;
  late HierarchyModel hierarchyModel;
  late ServiceArea areas;
  List<Subcategory> hierarchyModelBranches = [];

  Stream<dynamic> instilize() async* {
    await areaController.getServiceAreas();
    areas = areaController.sellerServiceArea;

    await getProducts();
    await getManufacturer();
    await getBrand();
    await getHierarchy();
    update();
  }

  getProducts({String text = '', int? index}) async {
    Map body = {
      'excludeSellerId': getProfile.profileData.sellerId,
      'nameQuery': text,
      'page': 0,
      'size': 30
    };
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
        path: ApiPaths.productsSearch,
        token: HiveService.getAuthToken(),
        body: body);

    final productModel = productModelFromMap(jsonEncode(request));
    products.clear();
    products.addAll(productModel.data?.products ?? []);
    currentPage = productModel.data?.currentPage ?? 0;
    totalPages = productModel.data?.totalPages ?? 0;
    totalItems = productModel.data!.totalProducts!;
    update();
  }

  getManufacturer() async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.get,
        path: ApiPaths.manufacturers,
        token: HiveService.getAuthToken());
    manufacturersModel = manufacturersModelFromMap(jsonEncode(request));
    manufacturersModel.data?.sort((a, b) =>
        a.name!.trim().toLowerCase().compareTo(b.name!.trim().toLowerCase()));
    update();
  }

  getBrand() async {
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: ApiPaths.brands,
      token: HiveService.getAuthToken(),
    );

    brandModel = brandModelFromMap(jsonEncode(request));
    brandModel.data?.sort((a, b) =>
        a.name!.trim().toLowerCase().compareTo(b.name!.trim().toLowerCase()));
    update();
  }

  getHierarchy() async {
    hierarchyModelBranches.clear();
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.get,
        path: ApiPaths.productsHierarchy,
        token: HiveService.getAuthToken());
    hierarchyModel = hierarchyModelFromMap(jsonEncode(request));

    hierarchyModel.data?.forEach((subcategory) {
      subcategory.subcategories?.forEach((branch) {
        if (branch.branches != null) {
          hierarchyModelBranches.addAll(branch.branches!);
        }
      });
    });
    hierarchyModelBranches.sort((a, b) =>
        a.name!.trim().toLowerCase().compareTo(b.name!.trim().toLowerCase()));

    update();
  }

  fetchNextPage() async {
    if (currentPage + 1 < totalPages) {
      final request = await ApiService.call(
          apiCallMethod: ApiCallMethod.post,
          path: ApiPaths.productsSearch,
          token: HiveService.getAuthToken(),
          body: {
            'excludeSellerId': getProfile.profileData.sellerId,
            'nameQuery': "",
            'page': currentPage + 1,
            'size': 30,
          });

      final productModel = productModelFromMap(jsonEncode(request));
      products.addAll(productModel.data?.products ?? []);
      currentPage = productModel.data!.currentPage!;
      totalPages = productModel.data!.totalPages!;
      update();
    }
  }

  addSupplyList() async {
    final request = await ApiService.call(
        apiCallMethod: ApiCallMethod.post,
        path:
            '${ApiPaths.sellers}/${getProfile.profileData.sellerId}${ApiPaths.sellerProductBulk}',
        token: HiveService.getAuthToken(),
        body: {'productIds': selectedProduct, 'serviceAreaIds': selectedArea});
  }
}
