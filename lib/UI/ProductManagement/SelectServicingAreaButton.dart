import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/ProductManagement_Service.dart';
import 'ViewPincode.dart';

class SelectServicingAreaButton extends StatefulWidget {
  VoidCallback action;
  SelectServicingAreaButton({super.key, required this.action});

  @override
  State<SelectServicingAreaButton> createState() =>
      _SelectServicingAreaButtonState();
}

class _SelectServicingAreaButtonState extends State<SelectServicingAreaButton> {
  final productManagementController = Get.find<ProductManagementService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductManagementService>(
      builder: (_) => FloatingActionButton(
          backgroundColor: productManagementController.selectedProductID.isEmpty
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.secondary,
          onPressed: productManagementController.selectedProductID.isEmpty
              ? () {}
              : () {
                  productManagementController.selectedArea.clear();
                  productManagementController.update();

                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(),
                    builder: (context) {
                      return GetBuilder<ProductManagementService>(
                        builder: (_) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Select Servicing Area',
                                  textAlign: TextAlign.center),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: Checkbox(
                                    value: productManagementController
                                            .serviceArea.data!.length ==
                                        productManagementController
                                            .selectedArea.length,
                                    onChanged: (value) {
                                      if (productManagementController
                                              .serviceArea.data!.length ==
                                          productManagementController
                                              .selectedArea.length) {
                                        productManagementController.selectedArea
                                            .clear();
                                      } else {
                                        productManagementController.selectedArea
                                            .clear();
                                        for (int i = 0;
                                            i <
                                                productManagementController
                                                    .serviceArea.data!.length;
                                            i++) {
                                          productManagementController
                                              .selectedArea
                                              .add(productManagementController
                                                  .serviceArea.data![i].id);
                                        }
                                      }
                                      productManagementController.update();
                                    },
                                  )),
                                  Expanded(child: Text('Area')),
                                  Expanded(child: Text('Pincodes Added')),
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: productManagementController
                                      .serviceArea.data!.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Expanded(
                                            child: Checkbox(
                                          value: productManagementController
                                              .selectedArea
                                              .contains(
                                                  productManagementController
                                                      .serviceArea
                                                      .data![index]
                                                      .id),
                                          onChanged: (value) {
                                            if (productManagementController
                                                .selectedArea
                                                .contains(
                                                    productManagementController
                                                        .serviceArea
                                                        .data![index]
                                                        .id)) {
                                              productManagementController
                                                  .selectedArea
                                                  .remove(
                                                      productManagementController
                                                          .serviceArea
                                                          .data![index]
                                                          .id);
                                            } else {
                                              productManagementController
                                                  .selectedArea
                                                  .add(
                                                      productManagementController
                                                          .serviceArea
                                                          .data![index]
                                                          .id);
                                            }
                                            productManagementController
                                                .update();
                                          },
                                        )),
                                        Expanded(
                                            child: Text(
                                                productManagementController
                                                    .serviceArea
                                                    .data![index]
                                                    .name!)),
                                        Expanded(
                                            child: ViewPincode(
                                          pincodes: productManagementController
                                              .serviceArea
                                              .data![index]
                                              .serviceableAreas,
                                        )),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              MaterialButton(
                                onPressed: productManagementController
                                        .selectedArea.isEmpty
                                    ? () {}
                                    : () async {
                                        try {
                                          await productManagementController
                                              .selectServicingArea();
                                          widget.action();
                                          Get.back();
                                        } catch (e) {
                                          Get.snackbar('Error', e.toString());
                                        }
                                      },
                                color: productManagementController
                                        .selectedArea.isEmpty
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.secondary,
                                child: Text(
                                  'Update Product Mapping',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
          child: Icon(FontAwesomeIcons.mapLocationDot, color: Colors.white)),
    );
  }
}
