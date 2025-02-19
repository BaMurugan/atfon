import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/SellerProduct_Service.dart';

class SellerProductsPage extends StatefulWidget {
  const SellerProductsPage({super.key});

  @override
  State<SellerProductsPage> createState() => _SellerProductsPageState();
}

class _SellerProductsPageState extends State<SellerProductsPage> {
  final sellerProductService = Get.put(SellerProductService());

  @override
  void initState() {
    sellerProductService.instilize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(width: 3.5),
    );
    textField(
        {required String label,
        Function(String)? onChanged,
        Widget? prefix,
        Widget? suffix,
        required TextEditingController controller}) {
      return TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          prefix: prefix,
          suffix: prefix,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          enabledBorder: outline,
          errorBorder: outline,
          focusedErrorBorder: outline,
          focusedBorder: outline,
        ),
        onChanged: onChanged,
      );
    }

    uploadField({required String label, bool image = true}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          MaterialButton(
            onPressed: () async {
              final result =
                  await FilePicker.platform.pickFiles(type: FileType.any);

              if (result == null || result.files.isEmpty) return;
              if (image) {
                sellerProductService.image = result.files.first;
              } else {
                sellerProductService.brouchure = result.files.first;
              }
            },
            color: Theme.of(context).colorScheme.secondary,
            child: Text('Choose File',
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        body: GetBuilder<SellerProductService>(
          builder: (_) => Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 20,
              children: [
                Text('Enter Product Details',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      children: [
                        textField(
                            label: 'Name',
                            controller: sellerProductService.nameController),
                        textField(
                            label: 'Description',
                            controller:
                                sellerProductService.descriptionController),
                        textField(
                            label: 'Category',
                            controller:
                                sellerProductService.categoryController),
                        textField(
                            label: 'Subcategory',
                            controller:
                                sellerProductService.subcategoryController),
                        textField(
                            label: 'Related Group',
                            controller:
                                sellerProductService.relatedGroupController),
                        textField(
                            label: 'UOM',
                            controller: sellerProductService.uomController),
                        textField(
                            label: 'Alternate UOM',
                            controller:
                                sellerProductService.alternateUOMController),
                        textField(
                            label: 'GST Rate',
                            controller: sellerProductService.gstRateController),
                        textField(
                            label: 'HSN Code',
                            controller: sellerProductService.hsnCodeController),
                        textField(
                            label: 'Size',
                            controller: sellerProductService.sizeController),
                        textField(
                            label: 'Registration',
                            controller:
                                sellerProductService.registrationController),
                        uploadField(label: 'Upload Image'),
                        uploadField(label: 'Upload Brouchure', image: false),
                        textField(
                            label: 'BIS Standard',
                            controller:
                                sellerProductService.bisStandardController),
                        textField(
                            label: 'Sector Type',
                            controller:
                                sellerProductService.sectorTypeController),
                        textField(
                            label: 'Variant',
                            controller: sellerProductService.variantController),
                        textField(
                            label: 'Manufacturer',
                            controller:
                                sellerProductService.manufacturerController),
                        textField(
                            label: 'Brand',
                            controller: sellerProductService.brandController),
                        textField(
                            label: 'Manufacturer Product',
                            controller: sellerProductService
                                .manufacturerProductController),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    try {
                      await sellerProductService.uploadProduct();
                    } catch (e) {
                      Get.snackbar('Error', e.toString());
                    }
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text('Submit',
                      style: Theme.of(context).textTheme.bodySmall),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
