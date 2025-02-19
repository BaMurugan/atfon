import 'dart:io';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SellerProductService extends GetxController {
  PlatformFile? image;
  PlatformFile? brouchure;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subcategoryController = TextEditingController();
  TextEditingController relatedGroupController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController alternateUOMController = TextEditingController();
  TextEditingController gstRateController = TextEditingController();
  TextEditingController hsnCodeController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  TextEditingController bisStandardController = TextEditingController();
  TextEditingController sectorTypeController = TextEditingController();
  TextEditingController variantController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController manufacturerProductController = TextEditingController();

  instilize() {
    image = null;
    brouchure = null;
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    categoryController = TextEditingController();
    subcategoryController = TextEditingController();
    relatedGroupController = TextEditingController();
    uomController = TextEditingController();
    alternateUOMController = TextEditingController();
    gstRateController = TextEditingController();
    hsnCodeController = TextEditingController();
    sizeController = TextEditingController();
    registrationController = TextEditingController();
    bisStandardController = TextEditingController();
    sectorTypeController = TextEditingController();
    variantController = TextEditingController();
    manufacturerController = TextEditingController();
    brandController = TextEditingController();
    manufacturerProductController = TextEditingController();
    update();
  }

  Future<void> uploadProduct() async {
    final url = Uri.parse(
        '${ApiPaths.devServerAddress}${ApiPaths.sellerProductSeller}');

    var request = http.MultipartRequest('POST', url);

    request.fields['name'] = nameController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['categoryName'] = categoryController.text;
    request.fields['subcategoryName'] = subcategoryController.text;
    request.fields['branchName'] = brandController.text;
    request.fields['relatedGroupName'] = relatedGroupController.text;
    request.fields['uom'] = uomController.text;
    request.fields['alternateUom'] = alternateUOMController.text;
    request.fields['gstRate'] = gstRateController.text;
    request.fields['hsnCode'] = hsnCodeController.text;
    request.fields['size'] = sizeController.text;
    request.fields['registeredOrPl'] = registrationController.text;
    request.fields['bisStandard'] = bisStandardController.text;
    request.fields['sectorType'] = sectorTypeController.text;
    request.fields['relatedGroup'] = relatedGroupController.text;
    request.fields['toleranceApplicable'] = 'false';
    request.fields['quantity'] = manufacturerProductController.text;
    if (image != null) {
      var imageFile = File(image!.path!);
      var imageStream = http.ByteStream(imageFile.openRead());
      var imageLength = await imageFile.length();

      request.files.add(http.MultipartFile(
        'imageUrl',
        imageStream,
        imageLength,
        filename: image!.name,
      ));
    }
    if (brouchure != null) {
      var brouchureFile = File(brouchure!.path!);
      var brouchureStream = http.ByteStream(brouchureFile.openRead());
      var brouchureLength = await brouchureFile.length();

      request.files.add(http.MultipartFile(
        'brouchureOrSpec',
        brouchureStream,
        brouchureLength,
        filename: brouchure!.name,
      ));
    }

    request.headers.addAll({
      'Authorization': HiveService.getAuthToken(),
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Request Successful');
      var responseData = await response.stream.bytesToString();
      print('Response: $responseData');
    } else {
      print('Error: ${response.statusCode}');
      var errorData = await response.stream.bytesToString();
      print('Error Response: $errorData');
    }
  }
}
