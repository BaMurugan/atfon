import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/ProductManagement_Service.dart';

class UpdateMinMax extends StatefulWidget {
  String id;
  String productId;
  UpdateMinMax({super.key, required this.id, required this.productId});

  @override
  State<UpdateMinMax> createState() => _UpdateMinMaxState();
}

class _UpdateMinMaxState extends State<UpdateMinMax> {
  final productManagementController = Get.find<ProductManagementService>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const outline = OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.black, width: 3.5, style: BorderStyle.solid),
    );
    return GetBuilder<ProductManagementService>(
      builder: (controller) {
        return SizedBox(
          width: double.infinity,
          child: MaterialButton(
            onPressed: () async {
              final minController = TextEditingController();
              final maxController = TextEditingController();
              productManagementController.selectedMinMaxPinCode.clear();
              productManagementController.update();
              await productManagementController.getMinMax(widget.id);
              showModalBottomSheet(
                shape: RoundedRectangleBorder(),
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return GetBuilder<ProductManagementService>(
                    builder: (_) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Form(
                            key: formKey,
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                    textAlign: TextAlign.center,
                                    'Update Min/Max Quantity for Pincodes'),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: productManagementController
                                              .minMaxModule.data!.length ==
                                          productManagementController
                                              .selectedMinMaxPinCode.length,
                                      onChanged: (value) {
                                        if (productManagementController
                                                .minMaxModule.data!.length ==
                                            productManagementController
                                                .selectedMinMaxPinCode.length) {
                                          productManagementController
                                              .selectedMinMaxPinCode
                                              .clear();
                                        } else {
                                          productManagementController
                                              .selectedMinMaxPinCode
                                              .clear();
                                          for (var element
                                              in productManagementController
                                                  .minMaxModule.data!) {
                                            productManagementController
                                                .selectedMinMaxPinCode
                                                .add(element.pincode);
                                          }
                                        }
                                        productManagementController.update();
                                      },
                                    ),
                                    Expanded(child: Text("All Pincodes")),
                                    Expanded(child: Text("Minimum Quantity")),
                                    Expanded(child: Text("Maximum Quantity")),
                                  ],
                                ),
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: productManagementController
                                      .minMaxModule.data!.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          value: productManagementController
                                              .selectedMinMaxPinCode
                                              .contains(
                                                  productManagementController
                                                      .minMaxModule
                                                      .data![index]
                                                      .pincode),
                                          onChanged: (value) {
                                            if (productManagementController
                                                .selectedMinMaxPinCode
                                                .contains(
                                                    productManagementController
                                                        .minMaxModule
                                                        .data![index]
                                                        .pincode)) {
                                              productManagementController
                                                  .selectedMinMaxPinCode
                                                  .remove(
                                                      productManagementController
                                                          .minMaxModule
                                                          .data![index]
                                                          .pincode);
                                            } else {
                                              productManagementController
                                                  .selectedMinMaxPinCode
                                                  .add(
                                                      productManagementController
                                                          .minMaxModule
                                                          .data![index]
                                                          .pincode);
                                            }
                                            productManagementController
                                                .update();
                                          },
                                        ),
                                        Expanded(
                                            child: Text(
                                                "${productManagementController.minMaxModule.data![index].pincode}")),
                                        Expanded(
                                            child: Text(
                                                "${productManagementController.minMaxModule.data![index].minimumQuantity} ${productManagementController.minMaxModule.data?[index].product?.uom ?? ''}")),
                                        Expanded(
                                            child: Text(
                                                "${productManagementController.minMaxModule.data![index].maximumQuantity} ${productManagementController.minMaxModule.data?[index].product?.uom ?? ''}")),
                                      ],
                                    );
                                  },
                                )),
                                TextFormField(
                                  style: Theme.of(context).textTheme.titleSmall,
                                  controller: minController,
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Minimum Quantity",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    enabledBorder: outline,
                                    focusedBorder: outline,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter the Minimum Quantity';
                                    }
                                  },
                                ),
                                TextFormField(
                                  style: Theme.of(context).textTheme.titleSmall,
                                  controller: maxController,
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Maximum Quantity",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    enabledBorder: outline,
                                    focusedBorder: outline,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter the Maximum Quantity';
                                    }
                                  },
                                ),
                                MaterialButton(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Text(
                                    'Save',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      if (int.parse(minController.text) >
                                          int.parse(maxController.text)) {
                                        Get.snackbar('Error',
                                            'Minimum Quantity cannot be greater than Maximum Quantity.');
                                        return;
                                      }
                                      print('');
                                      if (productManagementController
                                          .selectedMinMaxPinCode.isEmpty) {
                                        Get.snackbar('Error',
                                            'Product ID or pincodes are missing.');
                                        return;
                                      }
                                      try {
                                        await productManagementController
                                            .setMinMax(
                                                max: int.parse(
                                                    maxController.text),
                                                min: int.parse(
                                                    minController.text),
                                                productId: widget.productId);
                                        Get.back();
                                      } catch (e) {
                                        Get.snackbar('Error', e.toString());
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'Update Min Max',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        );
      },
    );
  }
}
