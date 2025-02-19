import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/SelfPickUp_Service.dart';
import 'SelfPickUp_Operations.dart';

class SelfPickUpPage extends StatefulWidget {
  const SelfPickUpPage({super.key});

  @override
  State<SelfPickUpPage> createState() => _SelfPickUpPageState();
}

class _SelfPickUpPageState extends State<SelfPickUpPage> {
  final selfPickController = Get.put(SelfPickUpService());
  GlobalKey<_SelfPickUpPageState> parentKey = GlobalKey();

  callSetState() {
    parentKey.currentState?.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<dynamic>(
          stream: selfPickController.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Unable to get Data Please Try Again"));
            }
            return GetBuilder<SelfPickUpService>(
              builder: (_) {
                List pincodes = [];
                var itemData = selfPickController.selfPickUpModule.data!;
                try {
                  pincodes
                      .addAll(itemData.sellerSelfPickupPincodes![0].pincodes!);

                  pincodes.removeWhere((element) => element == "");
                } catch (e) {}

                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 2,
                          ))),
                          child: Text("Self Pick Up"),
                        ),
                        selfPickController.selfPickUpModule.data!
                                .sellerSelfPickupPincodes!.isEmpty
                            ? SelfPickUpOperations(
                                onUpdate: () {
                                  setState(() {});
                                },
                                label: "Add New Self Pickup Pincode",
                                add: true,
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  spacing: 10,
                                  children: [
                                    lineItems(
                                        key: "Name",
                                        value:
                                            "${itemData.sellerSelfPickupPincodes![0].name}"),
                                    lineItems(
                                        key: "Pincodes",
                                        value: pincodes.join(", ")),
                                    SelfPickUpOperations(
                                      onUpdate: () {
                                        setState(() {});
                                      },
                                      add: false,
                                      label: 'Edit',
                                      name: itemData
                                          .sellerSelfPickupPincodes![0].name,
                                      id: itemData
                                          .sellerSelfPickupPincodes![0].id!,
                                      pincode1: itemData
                                              .sellerSelfPickupPincodes?[0]
                                              .pincodes?[0] ??
                                          '',
                                      pincode2: itemData
                                              .sellerSelfPickupPincodes?[0]
                                              .pincodes?[1] ??
                                          '',
                                      pincode3: itemData
                                              .sellerSelfPickupPincodes?[0]
                                              .pincodes?[2] ??
                                          '',
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: MaterialButton(
                                        color: Colors.red,
                                        onPressed: () async {
                                          await selfPickController.updateData(
                                              edit: false,
                                              id: itemData
                                                  .sellerSelfPickupPincodes![0]
                                                  .id!);
                                          setState(() {});
                                        },
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Text(
                                          "Delete",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  lineItems({required String key, required String value}) {
    return Row(
      children: [
        Expanded(
          child: Text(key),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}
