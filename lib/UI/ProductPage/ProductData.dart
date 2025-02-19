import 'package:flutter/material.dart';
import 'package:autofon_seller/Module/Products_Module.dart';
import 'package:get/get.dart';

import '../../Controller/Product_Service.dart';
import '../ProductDescription/ProductDescription_Page.dart';

class ProductData extends StatefulWidget {
  Product item;
  String manufacture;
  ProductData({super.key, required this.manufacture, required this.item});

  @override
  State<ProductData> createState() => _ProductDataState();
}

class _ProductDataState extends State<ProductData> {
  final productController = Get.find<ProductService>();
  @override
  Widget build(BuildContext context) {
    Product item = widget.item;
    String manufacture = widget.manufacture;
    return GetBuilder<ProductService>(
      builder: (_) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            color: item.isDiscontinued!
                ? Theme.of(context).colorScheme.tertiary
                : null,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 3)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3),
              ),
              child: Image.network(item.imageUrl!, height: 100, width: 100),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    if (item.isDiscontinued!) {
                      Get.snackbar(
                        'Product is discontinued',
                        '',
                        messageText: const SizedBox.shrink(),
                      );
                    }
                    if (!item.isDiscontinued!) {
                      Get.to(ProductDescriptionPage(id: item.id!));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  item.name!,
                                  style: Theme.of(context).textTheme.titleSmall,
                                )),
                            if (!item.isDiscontinued!)
                              Checkbox(
                                value: productController.selectedProduct
                                    .contains(item.id),
                                onChanged: (value) {
                                  if (productController.selectedProduct
                                      .contains(item.id)) {
                                    productController.selectedProduct
                                        .remove(item.id);
                                  } else {
                                    productController.selectedProduct
                                        .add(item.id);
                                  }
                                  productController.update();
                                },
                              )
                          ],
                        ),
                        Text("Manufacturer : $manufacture",
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
