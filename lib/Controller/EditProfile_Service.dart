import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Module/GSTSearch_Module.dart';
import '../Module/ProfileAddress_Module.dart';
import '../Other Service/ApiPath.dart';
import '../Other Service/ApiService.dart';
import '../Other Service/HiveStoreage.dart';
import '../UI/Map/Controller/Mapview_Service.dart';
import 'Home_Service.dart';
import 'Profile_Service.dart';

class EditProfileService extends GetxController {
  final homeService = Get.find<HomeService>();
  final profileService = Get.find<ProfileService>();
  final mapviewservice = Get.put(MapViewService());
  bool isLocationChange = false;
  late ProfileAddress profileAddress;
  late GstSearchModule gstSearchModule;
  PlatformFile? pdfGstFile;
  PlatformFile? pdfPanFile;
  List gstAddresses = [];

  int selectedAddressIndex = 0;
  bool enableDropDown = false;

  TextEditingController gstNumberController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController partyNameController = TextEditingController();
  TextEditingController addressLineOneController = TextEditingController();
  TextEditingController addressLineTwoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController alternativePhoneNumberOneController =
      TextEditingController();
  TextEditingController alternativePhoneNumberTwoController =
      TextEditingController();

  instilize() {
    profileAddress = profileService.profileAddress;
    gstNumberController.text = profileAddress.data?[0].gstNumber ?? '';
    addressNameController.text = profileAddress.data?[0].addressName ?? '';
    partyNameController.text = profileAddress.data?[0].partyName ?? '';
    addressLineOneController.text = profileAddress.data?[0].addressLine1 ?? '';
    addressLineTwoController.text = profileAddress.data?[0].addressLine2 ?? '';
    cityController.text = profileAddress.data?[0].city ?? '';
    districtController.text = profileAddress.data?[0].district ?? '';
    stateController.text = profileAddress.data?[0].state ?? '';
    pinCodeController.text = profileAddress.data?[0].pincode ?? '';
    phoneNumberController.text = profileAddress.data?[0].phone ?? '';
    panNumberController.text = profileAddress.data?[0].panNumber ?? '';
    alternativePhoneNumberOneController.text =
        profileService.user.data?.alternatePhoneOne ?? '';
    alternativePhoneNumberTwoController.text =
        profileService.user.data?.alternatePhoneTwo ?? '';
  }

  uploadPDF() async {
    if (pdfGstFile != null) {
      final uri = Uri.parse(
          '${ApiPaths.devServerAddress}${ApiPaths.userAddress}/${profileAddress.data![0].id}/seller');
      final request = http.MultipartRequest('PUT', uri);
      request.headers['Authorization'] = HiveService.getAuthToken();

      request.files
          .add(await http.MultipartFile.fromPath('file', pdfGstFile!.path!));
      final response = await request.send();
    }
    if (pdfPanFile != null) {
      final uri = Uri.parse(
          '${ApiPaths.devServerAddress}${ApiPaths.userAddress}/${profileAddress.data![0].id}/seller/pan');
      final request = http.MultipartRequest('PUT', uri);
      request.headers['Authorization'] = HiveService.getAuthToken();

      request.files
          .add(await http.MultipartFile.fromPath('file', pdfPanFile!.path!));
      final response = await request.send();
    }
  }

  searchGST() async {
    selectedAddressIndex = 0;
    gstAddresses = [];
    enableDropDown = false;

    update();
    final request = await ApiService.call(
      apiCallMethod: ApiCallMethod.get,
      path: '${ApiPaths.sellerGstSearch}/${gstNumberController.text.trim()}',
      token: HiveService.getAuthToken(),
    );

    gstSearchModule = gstSearchModuleFromMap(jsonEncode(request));
    partyNameController.text = gstSearchModule.data?.tradeName ?? "";
    panNumberController.text =
        gstSearchModule.data!.gstin?.substring(2, 12) ?? '';
    if (gstSearchModule.data!.addresses!.length == 1) {
      updateField(selectedAddressIndex);
    } else {
      enableDropDown = true;
      gstAddresses = gstSearchModule.data!.addresses!;
    }
    update();
  }

  updateField(int index) {
    addressLineOneController.text = [
      gstSearchModule.data?.addresses?[index].floorNumber,
      gstSearchModule.data?.addresses?[index].buildingNumber,
      gstSearchModule.data?.addresses?[index].buildingName,
      gstSearchModule.data?.addresses?[index].street,
      gstSearchModule.data?.addresses?[index].location,
      gstSearchModule.data?.addresses?[index].state,
      gstSearchModule.data?.addresses?[index].pincode,
    ].where((part) => part != null && part.trim().isNotEmpty).join(', ');

    cityController.text =
        gstSearchModule.data!.addresses?[index].district ?? '';
    districtController.text =
        gstSearchModule.data!.addresses?[index].district ?? '';
    stateController.text = gstSearchModule.data!.addresses?[index].state ?? '';
    pinCodeController.text =
        gstSearchModule.data!.addresses?[index].pincode ?? '';
    update();
  }

  updateUserName() async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path: ApiPaths.sellerUsersUpdateName,
        token: HiveService.getAuthToken(),
        body: {'name': partyNameController.text});
  }

  updateCompanyName() async {
    await ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path:
            '${ApiPaths.sellers}/${profileService.profile.profileData.sellerId}/update',
        token: HiveService.getAuthToken(),
        body: {
          'companyName': partyNameController.text,
          'alternatePhoneOne': alternativePhoneNumberOneController.text,
          'alternatePhoneTwo': alternativePhoneNumberTwoController.text,
        });
  }

  updateUserAddress() async {
    await ApiService.call(
      apiCallMethod: ApiCallMethod.put,
      path:
          '${ApiPaths.userAddress}/${profileService.profileAddress.data![0].id}',
      token: HiveService.getAuthToken(),
      body: {
        'addressLine_1': addressLineOneController.text,
        'addressLine_2': addressLineTwoController.text,
        'addressName': addressNameController.text,
        'city': cityController.text,
        'defaultAddress': true,
        'district': districtController.text,
        'gstNumber': gstNumberController.text,
        'mapLocation':
            jsonEncode({'lat': mapviewservice.lat, 'lng': mapviewservice.lng}),
        'panNumber': panNumberController.text,
        'partyName': partyNameController.text,
        'phone': phoneNumberController.text,
        'pincode': pinCodeController.text,
        'profileAddress': true,
        'state': stateController.text,
      },
    );
  }

  saveUpdate() async {
    await updateUserName();
    await updateCompanyName();
    await updateUserAddress();
    await uploadPDF();
    await profileService.setInstilize();
    await homeService.getProfile();
    profileService.update();
  }
}
