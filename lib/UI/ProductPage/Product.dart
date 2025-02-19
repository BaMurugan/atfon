import 'package:autofon_seller/Controller/Product_Service.dart';
import 'package:autofon_seller/Module/Products_Module.dart';
import 'package:autofon_seller/UI/ProductPage/FilterButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'AddSupplyButton.dart';
import 'ProductData.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final productController = Get.put(ProductService());
  final outLine = const OutlineInputBorder(borderSide: BorderSide(width: 2));
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(fetchData);
    super.initState();
  }

  customButton(
      {Color? color,
      required Widget title,
      Color? background,
      VoidCallback? onTap}) {
    return Expanded(
        flex: 2,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                border: Border.all(color: color ?? Colors.black, width: 2),
                color: background),
            child: title,
          ),
        ));
  }

  fetchData() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      productController.fetchNextPage();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const outline = OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black, width: 3.5, style: BorderStyle.solid));
    return Scaffold(
      floatingActionButton: AddSupplyButton(
        action: () {
          setState(() {});
        },
      ),
      body: StreamBuilder(
        stream: productController.instilize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    "Something went Wrong Please Try Again Later ${snapshot.error.toString()}"));
          }
          return GetBuilder<ProductService>(
            builder: (_) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: TextField(
                            style: Theme.of(context).textTheme.titleSmall,
                            decoration: InputDecoration(
                                suffixIcon:
                                    Icon(FontAwesomeIcons.magnifyingGlass),
                                label: Text("Search Product",
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                enabledBorder: outline,
                                focusedBorder: outline),
                            onChanged: (value) {
                              productController.getProducts(text: value);
                            })),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(children: [
                          customButton(
                              background:
                                  Theme.of(context).colorScheme.secondary,
                              color: Theme.of(context).colorScheme.secondary,
                              title: const Text("Select All"),
                              onTap: () {
                                productController.selectedProduct.clear();

                                productController.selectedProduct.addAll(
                                  productController.products
                                      .where((data) => !data.isDiscontinued!)
                                      .map((data) => data.id),
                                );

                                productController.update();
                              }),
                          const SizedBox(width: 3),
                          customButton(
                              color: Theme.of(context).colorScheme.primary,
                              title: const Text("Clear"),
                              onTap: () {
                                productController.selectedProduct.clear();
                                productController.update();
                              }),
                          Expanded(child: FilterButton())
                        ])),
                    Text(
                      '${productController.products.isEmpty ? '0' : 1}-${productController.products.length} of ${productController.totalItems} that are not in your list',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: productController.products.isEmpty
                          ? Center(child: Text("No products available"))
                          : RawScrollbar(
                              thumbColor:
                                  Theme.of(context).colorScheme.secondary,
                              trackVisibility: true,
                              thumbVisibility: true,
                              controller: scrollController,
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: productController.products.length,
                                itemBuilder: (context, index) {
                                  Product item =
                                      productController.products[index];
                                  String? manufacture;
                                  for (int i = 0;
                                      i <
                                          productController
                                              .manufacturersModel.data!.length;
                                      i++) {
                                    if (productController
                                            .manufacturersModel.data![i].id ==
                                        item.manufacturerId) {
                                      manufacture = productController
                                          .manufacturersModel.data![i].name;
                                    }
                                  }
                                  return ProductData(
                                    item: item,
                                    manufacture: manufacture!,
                                  );
                                },
                              ),
                            ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
