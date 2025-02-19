import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import '../../Controller/Product_Service.dart';

class AddSupplyButton extends StatefulWidget {
  VoidCallback action;
  AddSupplyButton({super.key, required this.action});

  @override
  State<AddSupplyButton> createState() => _AddSupplyButtonState();
}

class _AddSupplyButtonState extends State<AddSupplyButton> {
  final productController = Get.find<ProductService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<ProductService>(
      builder: (_) => FloatingActionButton(
        backgroundColor: productController.selectedProduct.isNotEmpty
            ? theme.colorScheme.secondary
            : theme.colorScheme.tertiary,
        onPressed: productController.selectedProduct.isNotEmpty
            ? () {
                productController.selectedArea.clear();
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(),
                  builder: (context) {
                    return GetBuilder<ProductService>(
                      builder: (_) => Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 20,
                          children: [
                            Text(
                              'Supply List',
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: Checkbox(
                                  value:
                                      productController.selectedArea.length ==
                                          productController.areas.data!.length,
                                  onChanged: (value) {
                                    if (productController.selectedArea.length ==
                                        productController.areas.data!.length) {
                                      productController.selectedArea.clear();
                                    } else {
                                      productController.selectedArea.clear();
                                      productController.selectedArea.assignAll(
                                          productController.areas.data!
                                              .map((e) => e.id));
                                    }
                                    productController.update();
                                  },
                                )),
                                Expanded(child: Text('Area')),
                                Expanded(child: Text('Pincodes Added')),
                              ],
                            ),
                            Expanded(
                                child: ListView.builder(
                              itemCount: productController.areas.data!.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: Checkbox(
                                      value: productController.selectedArea
                                          .contains(productController
                                              .areas.data![index].id),
                                      onChanged: (value) {
                                        if (productController.selectedArea
                                            .contains(productController
                                                .areas.data![index].id)) {
                                          productController.selectedArea.remove(
                                              productController
                                                  .areas.data![index].id);
                                        } else {
                                          productController.selectedArea.add(
                                              productController
                                                  .areas.data![index].id);
                                        }
                                        productController.update();
                                      },
                                    )),
                                    Expanded(
                                        child: Text(productController
                                            .areas.data![index]!.name!)),
                                    Expanded(
                                        child: ViewPincode(
                                            product: productController
                                                .areas
                                                .data![index]
                                                .serviceableAreas!))
                                  ],
                                );
                              },
                            )),
                            MaterialButton(
                              onPressed: productController
                                      .selectedArea.isNotEmpty
                                  ? () async {
                                      try {
                                        await productController.addSupplyList();
                                        Get.back();
                                        widget.action();
                                      } catch (e) {
                                        Get.snackbar('Error', e.toString());
                                      }
                                    }
                                  : () {},
                              color: productController.selectedArea.isNotEmpty
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.tertiary,
                              child: Text(
                                'Map To My Account',
                                style: theme.textTheme.titleSmall,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            : () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class ViewPincode extends StatefulWidget {
  List product;
  ViewPincode({super.key, required this.product});

  @override
  State<ViewPincode> createState() => _ViewPincodeState();
}

class _ViewPincodeState extends State<ViewPincode> {
  @override
  Widget build(BuildContext context) {
    final list = List.generate(
      widget.product.length,
      (index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            widget.product[index] ?? 'N/A',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
    );
    return InkWell(
      onTap: () {
        showPopover(
          width: MediaQuery.of(context).size.width * 0.4,
          barrierColor: Colors.transparent,
          arrowHeight: 0,
          direction: PopoverDirection.bottom,
          context: context,
          height: MediaQuery.of(context).size.height * 0.2,
          bodyBuilder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: list,
              ),
            );
          },
        );
      },
      child: Text(
        "${widget.product.length} Pincodes",
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
