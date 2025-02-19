import 'package:autofon_seller/UI/ProductManagement/ManagementData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/ProductManagement_Service.dart';
import '../../Module/ProductManagement_Module.dart';
import 'DeleteButton.dart';
import 'ProductManagementFilter.dart';
import 'SelectServicingAreaButton.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  final controller = Get.put(ProductManagementService());
  ScrollController scrollController = ScrollController();
  customButton({Color? color, required Widget title, Color? background}) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(color: color ?? Colors.black, width: 2),
          color: background),
      child: title,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(fetchData);
    super.initState();
  }

  fetchData() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      controller.fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    const outline = OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.black, width: 3.5, style: BorderStyle.solid),
    );
    return Scaffold(
      floatingActionButton: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SelectServicingAreaButton(
            action: () {
              setState(() {});
            },
          ),
          DeleteButton(
            action: () {
              setState(() {});
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
            ));
          }

          return GetBuilder<ProductManagementService>(
            builder: (_) => Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: TextField(
                    style: Theme.of(context).textTheme.titleSmall,
                    decoration: InputDecoration(
                      suffixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                      label: Text(
                        "Search Product",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      enabledBorder: outline,
                      focusedBorder: outline,
                    ),
                    onChanged: (value) {
                      controller.getProduct(nameQuery: value);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                              onTap: () {
                                controller.selectedProductID.clear();
                                controller.selectedId.clear();
                                controller.selectedProductID.addAll(
                                  controller.items
                                      .where((item) =>
                                          !item.product.isDiscontinued)
                                      .map((item) => item.productId),
                                );
                                controller.selectedId.addAll(
                                  controller.items
                                      .where((item) =>
                                          !item.product.isDiscontinued)
                                      .map((item) => item.id),
                                );

                                controller.update();
                              },
                              child: customButton(
                                  background:
                                      Theme.of(context).colorScheme.secondary,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  title: const Text("Select All")))),
                      const SizedBox(width: 3),
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                              onTap: () {
                                controller.selectedProductID.clear();
                                controller.update();
                              },
                              child: customButton(
                                  color: Theme.of(context).colorScheme.primary,
                                  title: const Text("Clear")))),
                      Expanded(
                        child: ManagementFilterButton(),
                      ),
                    ],
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  '${controller.items.isEmpty ? '0' : 1}-${controller.items.length} of ${controller.totalSellerProduct} that are in your list',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Expanded(
                  child: RawScrollbar(
                    thumbColor: Theme.of(context).colorScheme.secondary,
                    trackVisibility: true,
                    thumbVisibility: true,
                    controller: scrollController,
                    radius: Radius.circular(10),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        SellerProduct item = controller.items[index];
                        List areaName = [];

                        Map<String, String> serviceAreaMap = {
                          for (var area in controller.serviceArea.data!)
                            area.id!: area.name!
                        };
                        for (var id in item.serviceAreaIds!) {
                          if (serviceAreaMap.containsKey(id)) {
                            areaName.add(serviceAreaMap[id]!);
                          }
                        }

                        return ManagementData(
                          item: item,
                          areaName: areaName,
                          action: () {
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
