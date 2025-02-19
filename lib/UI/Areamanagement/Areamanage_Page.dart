import 'package:autofon_seller/Module/Area_Module.dart';
import 'package:autofon_seller/Module/Pincode_Module.dart';
import 'package:autofon_seller/UI/Areamanagement/AddareaPage.dart';
import 'package:autofon_seller/UI/Areamanagement/AreaManagementExpandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/AreaManagemet_Service.dart';
import '../../Module/ServiceArea_Module.dart';

class AreaManagePage extends StatefulWidget {
  const AreaManagePage({super.key});

  @override
  State<AreaManagePage> createState() => _AreaManagePageState();
}

class _AreaManagePageState extends State<AreaManagePage> {
  final areaManagementController = Get.put(AreaManagementService());
  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const outline = OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.black, width: 3.5, style: BorderStyle.solid),
    );
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            areaManagementController.selectedPincode.clear();
            Get.to(AddArea(action: () {
              setState(() {});
            }));
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: areaManagementController.instilize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                      "Something went wrong please try again later ${snapshot.error}"));
            }

            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Area Management',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextField(
                      style: Theme.of(context).textTheme.labelSmall,
                      decoration: InputDecoration(
                        suffixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                        label: Text(
                          "Search by Area or Pincode",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        enabledBorder: outline,
                        focusedBorder: outline,
                      ),
                      onChanged: (value) {
                        List filterItems = [];

                        for (int i = 0;
                            i <
                                areaManagementController
                                    .sellerServiceArea.data!.length;
                            i++) {
                          final data = areaManagementController
                              .sellerServiceArea.data![i];
                          final areaName = data.name ?? '';
                          final serviceableAreas =
                              data.serviceableAreas?.join(' ') ?? '';

                          if ('$areaName $serviceableAreas'
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            filterItems.add(data);
                          }

                          areaManagementController.filteredList = filterItems;
                        }

                        areaManagementController.update();
                      },
                    ),
                    Expanded(
                      child: GetBuilder<AreaManagementService>(
                          builder: (controller) => ListView.builder(
                                itemCount: areaManagementController
                                    .filteredList.length,
                                itemBuilder: (context, index) {
                                  Datum items = areaManagementController
                                      .filteredList[index];
                                  return AreaExpandable(item: items);
                                },
                              )),
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
