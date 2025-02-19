import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/AreaManagemet_Service.dart';

class PincodeManagement extends StatefulWidget {
  PincodeManagement({super.key});

  @override
  State<PincodeManagement> createState() => _PincodeManagementState();
}

class _PincodeManagementState extends State<PincodeManagement> {
  final areaManagementController = Get.find<AreaManagementService>();
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  bool selected = false;
  @override
  void initState() {
    scrollController.addListener(fetchData);
    super.initState();
  }

  fetchData() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      areaManagementController.getMore();
    }
  }

  void toggleSelectAll() {
    if (selected) {
      for (var pincode in areaManagementController.allPincodes!) {
        if (!areaManagementController.selectedPincode
            .contains(pincode.pincode)) {
          areaManagementController.selectedPincode.add(pincode.pincode);
        }
      }
    } else {
      for (var pincode in areaManagementController.allPincodes!) {
        areaManagementController.selectedPincode.remove(pincode.pincode);
      }
    }

    areaManagementController.update();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AreaManagementService>(
      builder: (controller) {
        if (controller.allPincodes.isEmpty) {
          return Center(child: Text('No data available'));
        }
        return Container(
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Checkbox(
                      value: areaManagementController.allPincodes.every((e) =>
                          areaManagementController.selectedPincode
                              .contains(e.pincode)),
                      onChanged: (v) {
                        selected = !areaManagementController.allPincodes.every(
                            (e) => areaManagementController.selectedPincode
                                .contains(e.pincode));

                        toggleSelectAll();
                      },
                    ),
                    Expanded(child: Text('Pincode')),
                    Expanded(child: Text('District')),
                    Expanded(child: Text('Sub District')),
                  ]),
            ),
            Expanded(
                child: Scrollbar(
                    trackVisibility: true,
                    thumbVisibility: true,
                    interactive: true,
                    controller: scrollController,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        controller: scrollController,
                        child: Scrollbar(
                            trackVisibility: true,
                            thumbVisibility: true,
                            controller: scrollController1,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: scrollController1,
                              child: Column(
                                  children: List.generate(
                                areaManagementController.allPincodes.length,
                                (index) {
                                  final pincode = areaManagementController
                                      .allPincodes[index];
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Checkbox(
                                          value: areaManagementController
                                              .selectedPincode
                                              .contains(pincode.pincode),
                                          onChanged: (value) {
                                            if (areaManagementController
                                                .selectedPincode
                                                .contains(pincode.pincode)) {
                                              areaManagementController
                                                  .selectedPincode
                                                  .remove(pincode.pincode);
                                            } else {
                                              areaManagementController
                                                  .selectedPincode
                                                  .add(pincode.pincode);
                                            }
                                            areaManagementController.update();
                                          },
                                        ),
                                        Expanded(
                                            child: Text(pincode.pincode ?? "")),
                                        Expanded(
                                            child:
                                                Text(pincode.district ?? "")),
                                        Expanded(
                                            child:
                                                Text(pincode.subDistrict ?? ""))
                                      ],
                                    ),
                                  );
                                },
                              )),
                            )))))
          ]),
        );
      },
    );
  }
}
