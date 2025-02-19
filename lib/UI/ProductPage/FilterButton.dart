import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:autofon_seller/Controller/Product_Service.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  final controller = Get.find<ProductService>();
  List filteredList = [];
  int filterIndex = 0;
  @override
  Widget build(BuildContext context) {
    List filterList = [
      controller.hierarchyModelBranches,
      controller.manufacturersModel.data,
      controller.brandModel.data,
    ];

    customButton({Color? color, required Widget title, Color? background}) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.35,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
        decoration: BoxDecoration(
            border: Border.all(
              color: color ?? Colors.black,
              width: 1,
            ),
            color: background),
        child: title,
      );
    }

    clearSelect() {
      controller.selectedManufacturer.clear();
      controller.selectedGroup.clear();
      controller.selectedBrand.clear();
      controller.update();
    }

    showBottomDialog() {
      filteredList = filterList[filterIndex];

      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(),
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return GetBuilder<ProductService>(
                builder: (_) => Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      spacing: 20,
                      children: [
                        Text(
                          "Filter",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        TextField(
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            labelText:
                                'Search ${filterIndex == 0 ? 'Group' : filterIndex == 1 ? 'Manufacture' : 'Brand'}',
                            labelStyle: Theme.of(context).textTheme.bodySmall,
                            suffix: Icon(FontAwesomeIcons.magnifyingGlass,
                                size: 18),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                          ),
                          onChanged: (value) {
                            filteredList = [];
                            for (int i = 0;
                                i < filterList[filterIndex].length;
                                i++) {
                              final data = filterList[filterIndex][i];
                              if (data.name.toLowerCase().contains(value)) {
                                filteredList.add(data);
                              }
                            }
                            setState(() {});
                          },
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Column(
                                spacing: 10,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    spacing: 10,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          filterIndex = 0;
                                          clearSelect();
                                          filteredList =
                                              filterList[filterIndex];

                                          setState(() {});
                                        },
                                        child: customButton(
                                          title: Text(
                                            'Group',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                          background: filterIndex == 0
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Colors.white,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          filterIndex = 1;
                                          clearSelect();
                                          filteredList =
                                              filterList[filterIndex];

                                          setState(() {});
                                        },
                                        child: customButton(
                                          title: Text(
                                            'Manufacturer',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                          background: filterIndex == 1
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Colors.white,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          filterIndex = 2;
                                          clearSelect();
                                          filteredList =
                                              filterList[filterIndex];

                                          setState(() {});
                                        },
                                        child: customButton(
                                          title: Text(
                                            'Brand',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                          background: filterIndex == 2
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    spacing: 10,
                                    children: [
                                      InkWell(
                                        onTap: (controller.selectedManufacturer
                                                    .isEmpty &&
                                                controller
                                                    .selectedBrand.isEmpty &&
                                                controller
                                                    .selectedGroup.isEmpty)
                                            ? () {}
                                            : () {
                                                controller.getProducts(
                                                    index: filterIndex);

                                                Get.back();
                                              },
                                        child: customButton(
                                          title: Text(
                                            'Apply',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          background: (controller
                                                      .selectedManufacturer
                                                      .isEmpty &&
                                                  controller
                                                      .selectedBrand.isEmpty &&
                                                  controller
                                                      .selectedGroup.isEmpty)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .tertiary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.getProducts();
                                          clearSelect();
                                          Get.back();
                                        },
                                        child: customButton(
                                          title: Text(
                                            'Clear',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          background: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: filteredList.length,
                                    itemBuilder: (context, index) {
                                      return CheckboxListTile(
                                        title: Text(
                                          "${filteredList[index].name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                        value: filterIndex == 0
                                            ? controller.selectedGroup.contains(
                                                filteredList[index].id)
                                            : filterIndex == 1
                                                ? controller
                                                    .selectedManufacturer
                                                    .contains(
                                                        filteredList[index].id)
                                                : controller.selectedBrand
                                                    .contains(
                                                        filteredList[index].id),
                                        onChanged: (value) {
                                          if (filterIndex == 0) {
                                            if (value == true) {
                                              controller.selectedGroup
                                                  .add(filteredList[index].id);
                                            } else {
                                              controller.selectedGroup.remove(
                                                  filteredList[index].id);
                                            }
                                          } else if (filterIndex == 1) {
                                            if (value == true) {
                                              controller.selectedManufacturer
                                                  .add(filteredList[index].id);
                                            } else {
                                              controller.selectedManufacturer
                                                  .remove(
                                                      filteredList[index].id);
                                            }
                                          } else {
                                            if (value == true) {
                                              controller.selectedBrand
                                                  .add(filteredList[index].id);
                                            } else {
                                              controller.selectedBrand.remove(
                                                  filteredList[index].id);
                                            }
                                          }
                                          setState(() {});
                                          controller.update();
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
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
    }

    return InkWell(
      onTap: () {
        showBottomDialog();
      },
      child: customButton(
          color: Theme.of(context).colorScheme.primary,
          title: Icon(Icons.tune)),
    );
  }
}
