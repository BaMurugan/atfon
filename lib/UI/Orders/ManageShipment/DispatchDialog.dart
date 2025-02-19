import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/Home_Service.dart';
import '../../../../Controller/Orders_Service.dart';
import '../../../Other Service/ApiPath.dart';

class DispatchDialog extends StatefulWidget {
  String? id;
  Widget titleWidget;
  bool? allinOneShipment;
  DispatchDialog(
      {super.key,
      required this.titleWidget,
      this.id,
      this.allinOneShipment = false});

  @override
  State<DispatchDialog> createState() => _DispatchDialogState();
}

class _DispatchDialogState extends State<DispatchDialog> {
  int page = 0;
  final orderService = Get.find<OrderService>();
  final homeService = Get.find<HomeService>();
  final formKey = GlobalKey<FormState>();
  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 2.0),
    borderRadius: BorderRadius.circular(8.0),
  );
  textField(String label, TextEditingController controller,
      {bool readOnly = true}) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodySmall,
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        focusedBorder: outlineBorder,
        enabledBorder: outlineBorder,
        focusedErrorBorder: outlineBorder,
        errorBorder: outlineBorder,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Select the $label';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderService>(builder: (controller) {
      return InkWell(
          onTap: () {
            if (orderService.sellerOrderModule.data!.isSplitOrderCompleted ==
                    false &&
                widget.allinOneShipment == false) {
              Get.snackbar('Error', 'Complete the split of remaining products');
              return;
            }
            if (widget.allinOneShipment == true) {
              allInOneDialog();
              return;
            }
            dispatchDialog();
          },
          child: widget.titleWidget);
    });
  }

  dispatchDialog() {
    page = 0;
    orderService.selectedDeliverPerson = 0;
    orderService.invoiceName.clear();
    orderService.creditNote.clear();
    orderService.update();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(),
        builder: (context) {
          return GetBuilder<OrderService>(builder: (controller) {
            return StatefulBuilder(builder: (context, setState) {
              return Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: SingleChildScrollView(
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: page == 0
                              ? Form(
                                  key: formKey,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      spacing: 10,
                                      children: [
                                        Text('Dispatch Shipment',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        textField('Invoice Number',
                                            orderService.invoiceName,
                                            readOnly: false),
                                        MaterialButton(
                                          onPressed: () {
                                            selectDeliveryPerson();
                                          },
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          child: Text(
                                              'Click Here to Select Delivery Person\'s',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ),
                                        DropdownButton(
                                          items: List.generate(
                                            orderService.deliveryPersons.data!
                                                .deliveryPersons!.length,
                                            (index) {
                                              final itemData = orderService
                                                  .deliveryPersons
                                                  .data!
                                                  .deliveryPersons![index];
                                              return DropdownMenuItem(
                                                value: index,
                                                child: Text(
                                                    '${itemData.name}-${itemData.phoneNumber}-${itemData.vehicleNumber}'),
                                              );
                                            },
                                          ),
                                          isExpanded: true,
                                          value: orderService
                                              .selectedDeliverPerson,
                                          onChanged: (value) {
                                            orderService.selectedDeliverPerson =
                                                value!;
                                            orderService.update();
                                          },
                                        ),
                                        textField(
                                            'Name',
                                            TextEditingController(
                                                text: orderService
                                                        .deliveryPersons
                                                        .data!
                                                        .deliveryPersons!
                                                        .isNotEmpty
                                                    ? orderService
                                                        .deliveryPersons
                                                        .data!
                                                        .deliveryPersons![
                                                            orderService
                                                                .selectedDeliverPerson]
                                                        .name
                                                    : '')),
                                        textField(
                                            'Phone Number',
                                            TextEditingController(
                                                text: orderService
                                                        .deliveryPersons
                                                        .data!
                                                        .deliveryPersons!
                                                        .isNotEmpty
                                                    ? orderService
                                                        .deliveryPersons
                                                        .data!
                                                        .deliveryPersons![
                                                            orderService
                                                                .selectedDeliverPerson]
                                                        .phoneNumber
                                                    : '')),
                                        textField(
                                            'Vehicle Number',
                                            TextEditingController(
                                                text: orderService
                                                        .deliveryPersons
                                                        .data!
                                                        .deliveryPersons!
                                                        .isNotEmpty
                                                    ? orderService
                                                        .deliveryPersons
                                                        .data!
                                                        .deliveryPersons![
                                                            orderService
                                                                .selectedDeliverPerson]
                                                        .vehicleNumber
                                                    : '')),
                                        MaterialButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                page = 1;
                                                setState(() {});
                                              }
                                            },
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            child: Text(
                                              'Preview',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ))
                                      ]))
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                      Text('Preview Dispatch Details',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 5,
                                        children: [
                                          Text(
                                              'Invoice Number: ${orderService.invoiceName.text}'),
                                          Text(
                                              'Delivery Person: ${orderService.deliveryPersons.data!.deliveryPersons![orderService.selectedDeliverPerson].name}'),
                                          Text(
                                              'Phone Number: ${orderService.deliveryPersons.data!.deliveryPersons![orderService.selectedDeliverPerson].phoneNumber}'),
                                          Text(
                                              'Vehicle Number: ${orderService.deliveryPersons.data!.deliveryPersons![orderService.selectedDeliverPerson].vehicleNumber}'),
                                        ],
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          spacing: 10,
                                          children: [
                                            Expanded(
                                              child: MaterialButton(
                                                onPressed: () {
                                                  page = 0;
                                                  setState(() {});
                                                },
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                child: Text(
                                                  'Back',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: MaterialButton(
                                                    onPressed: () async {
                                                      final data = orderService
                                                              .deliveryPersons
                                                              .data!
                                                              .deliveryPersons![
                                                          orderService
                                                              .selectedDeliverPerson];
                                                      Map body = {
                                                        'deliveryPersonContact':
                                                            '${data.phoneNumber}',
                                                        'deliveryPersonName':
                                                            '${data.name}',
                                                        'deliveryVehicleNo':
                                                            '${data.vehicleNumber}',
                                                        'invoiceDate': DateTime
                                                                .now()
                                                            .toUtc()
                                                            .toIso8601String(),
                                                        'invoiceNumber':
                                                            orderService
                                                                .invoiceName
                                                                .text,
                                                      };
                                                      if (widget.id != null) {
                                                        body['shipmentId'] =
                                                            widget.id;
                                                      }

                                                      await orderService
                                                          .updateShipment(
                                                              path:
                                                                  '${ApiPaths.sellerOrders}/${orderService.sellerOrderModule.data!.id}/dispatch',
                                                              body: body);
                                                      if (widget
                                                              .allinOneShipment ==
                                                          false) {
                                                        await orderService
                                                            .updateShipment(
                                                                path:
                                                                    '${ApiPaths.sellerOrders}${ApiPaths.sellerSendDeliveryConfirmation}',
                                                                body: {
                                                              'shipmentId':
                                                                  widget.id,
                                                            });
                                                      }
                                                      orderService
                                                              .allInOneShipment =
                                                          true;
                                                      orderService.update();
                                                      Get.back();
                                                    },
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    child: Text(
                                                      'Confirm & Dispatch',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    )))
                                          ])
                                    ]))));
            });
          });
        });
  }

  allInOneDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(),
          content: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                Text('Are you sure you want to dispatch all in one shipment?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 10,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text('Cancel'),
                    ),
                    InkWell(
                      onTap: () async {
                        Get.back();
                        await Future.delayed(Duration(seconds: 1));
                        dispatchDialog();
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  selectDeliveryPerson() {
    showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<OrderService>(
          builder: (_) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.8, // Set a proper width
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        children: [
                          TextField(
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: InputDecoration(
                              labelText: 'Search Delivery Person',
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              focusedBorder: outlineBorder,
                              enabledBorder: outlineBorder,
                              focusedErrorBorder: outlineBorder,
                            ),
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) {
                              orderService.getDeliveryPersons(
                                  personName: value);
                              orderService.update();
                            },
                          ),
                          SizedBox(height: 10),
                          Flexible(
                            child: ListView.builder(
                              itemCount: orderService.deliveryPersons.data
                                  ?.deliveryPersons!.length,
                              itemBuilder: (context, index) {
                                final itemData = orderService.deliveryPersons
                                    .data?.deliveryPersons![index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(itemData!.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                      Expanded(
                                        child: Text(itemData.phoneNumber!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                      Expanded(
                                        child: Text(itemData.vehicleNumber!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                    ],
                                  ),
                                );
                              },
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
      },
    );
  }
}
