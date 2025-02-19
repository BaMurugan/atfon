import 'package:autofon_seller/UI/ProductManagement/UpdateMinMax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/ProductManagement_Service.dart';
import '../../Module/ProductManagement_Module.dart';
import '../ProductDescription/ProductDescription_Page.dart';
import 'ViewPincode.dart';

class ManagementData extends StatefulWidget {
  SellerProduct item;
  List areaName;
  VoidCallback action;
  ManagementData(
      {super.key,
      required this.item,
      required this.areaName,
      required this.action});

  @override
  State<ManagementData> createState() => _ManagementDataState();
}

class _ManagementDataState extends State<ManagementData> {
  final productManagementController = Get.find<ProductManagementService>();

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    List areaName = widget.areaName;
    final product = item.product;

    return GetBuilder<ProductManagementService>(
      builder: (_) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3.5,
            color: Theme.of(context).colorScheme.primary,
          ),
          color: item.product!.isDiscontinued!
              ? Theme.of(context).colorScheme.tertiary
              : null,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
              child: Image.network(
                product!.imageUrl!,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.to(ProductDescriptionPage(id: product.id!));
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(product.name!,
                                style: Theme.of(context).textTheme.titleSmall),
                          ),
                          if (!item.product!.isDiscontinued!)
                            Checkbox(
                              value: productManagementController
                                  .selectedProductID
                                  .contains(item.productId),
                              onChanged: (value) {
                                if (!productManagementController
                                    .selectedProductID
                                    .contains(item.productId)) {
                                  productManagementController.selectedProductID
                                      .add(item.productId);
                                  productManagementController.selectedId
                                      .add(item.id);
                                } else {
                                  productManagementController.selectedProductID
                                      .remove(item.productId);
                                  productManagementController.selectedId
                                      .remove(item.id);
                                }

                                productManagementController.update();
                              },
                            )
                        ],
                      ),
                      Text(
                          "${getBranchName(subCategories: product.subcategoryId!, branchId: product.branchId!) ?? ''}",
                          style: Theme.of(context).textTheme.bodySmall),
                      Text("Serviceable Areas : ${areaName.join(', ')}",
                          style: Theme.of(context).textTheme.bodySmall),
                      ViewPincode(pincodes: item.serviceableAreas),
                      if (!item.product!.isDiscontinued!)
                        UpdateMinMax(id: item.id!, productId: item.productId!),
                      if (item.product!.isDiscontinued!)
                        MaterialButton(
                          onPressed: () async {
                            await productManagementController.deleteProduct(
                                id: item.id!);
                            widget.action();
                          },
                          color: Theme.of(context).colorScheme.error,
                          child: Text('Delete',
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getBranchName({required int subCategories, required int branchId}) {
    for (int k = 0;
        k < productManagementController.hierarchyModel.data!.length;
        k++) {
      for (int i = 0;
          i <
              productManagementController
                  .hierarchyModel.data![k].subcategories!.length;
          i++) {
        if (subCategories ==
            productManagementController
                .hierarchyModel.data![k].subcategories![i].id) {
          for (int j = 0;
              j <
                  productManagementController.hierarchyModel.data![k]
                      .subcategories![i].branches!.length;
              j++) {
            if (productManagementController.hierarchyModel.data![k]
                    .subcategories![i].branches![j].id ==
                branchId) {
              return productManagementController
                  .hierarchyModel.data![k].subcategories![i].branches![j].name;
            }
          }
        }
      }
    }

    return null;
  }
}
