import 'package:autofon_seller/Controller/Orders_Service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'ToleranceButton.dart';

class PendingShipmentItems extends StatefulWidget {
  final String id;
  PendingShipmentItems({super.key, required this.id});

  @override
  State<PendingShipmentItems> createState() => _PendingShipmentItemsState();
}

class _PendingShipmentItemsState extends State<PendingShipmentItems> {
  final orderService = Get.find<OrderService>();
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, TextEditingController> _textControllers1 = {};

  @override
  void initState() {
    // TODO: implement initState
    instilize();
    super.initState();
  }

  instilize() {
    orderService.selectedItems = [];
    orderService.selectedCharge = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<OrderService>(
          builder: (_) {
            return SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Pending Products",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    ...List.generate(
                      orderService.sellerOrderModule.data!
                          .pendingShipmentLineItems!.length,
                      (index) {
                        final data = orderService.sellerOrderModule.data!
                            .pendingShipmentLineItems![index];
                        final id = data.id;

                        if (!_textControllers.containsKey(id)) {
                          _textControllers['$id'] =
                              TextEditingController(text: "${data.units}");
                        }
                        if (data.isToleranceApplied!) {
                          _textControllers['$id'] =
                              TextEditingController(text: "${data.units}");
                        }

                        final textControl = _textControllers[id]!;
                        double quantity =
                            double.tryParse('${data.units!}' ?? '0.00') ?? 0.0;
                        String formattedQuantity = quantity == quantity.toInt()
                            ? quantity.toInt().toString()
                            : quantity
                                .toStringAsFixed(8)
                                .replaceAll(RegExp(r"([.]*0+)$"), "");
                        return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Column(
                              children: [
                                Row(spacing: 5, children: [
                                  Checkbox(
                                    value: orderService.isItemSelected(id!, 0),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value!) {
                                          orderService.addItem({
                                            'orderLineItemId': id,
                                            'units':
                                                double.parse(textControl.text),
                                          }, 0);
                                        } else {
                                          orderService.removeItem(data.id!, 0);
                                        }
                                      });
                                    },
                                  ),
                                  Image.network(
                                    data.imageUrl!,
                                    height: 100,
                                    width: 100,
                                  ),
                                  Expanded(
                                    child: Column(
                                        spacing: 5,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(data.name ?? ''),
                                          data.product!.toleranceApplicable!
                                              ? ToleranceButton(data: data)
                                              : SizedBox()
                                        ]),
                                  ),
                                ]),
                                Divider(),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Remaining Qty'),
                                        Text(
                                            "${double.tryParse(formattedQuantity ?? '0')} ${data.uom ?? ''}"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Item Price'),
                                        Text('${data.itemPrice}'),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text('Quantity'),
                                          Row(
                                            spacing: 10,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (double.parse(
                                                          textControl.text) >
                                                      0) {
                                                    textControl.text =
                                                        "${double.parse(textControl.text) - 1}";
                                                    orderService.updateItem({
                                                      'orderLineItemId': id,
                                                      'units': int.parse(
                                                          textControl.text),
                                                    }, 0);
                                                  }
                                                },
                                                child: Icon(
                                                  FontAwesomeIcons.minus,
                                                  size: 20,
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  readOnly:
                                                      data.isToleranceApplied!,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                  controller: textControl,
                                                  onTapOutside: (event) {
                                                    if (textControl
                                                        .text.isEmpty) {
                                                      textControl.text = '0';
                                                    }
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  onEditingComplete: () {
                                                    if (int.parse(
                                                            textControl.text) >
                                                        int.parse(
                                                            '${data.units}')) {
                                                      Get.snackbar("Alert",
                                                          "Please Enter a valid Quantity",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM);
                                                      textControl.text =
                                                          "${data.units}";
                                                      orderService.updateItem({
                                                        'orderLineItemId': id,
                                                        'units': int.parse(
                                                            textControl.text),
                                                      }, 0);
                                                    } else {
                                                      orderService.updateItem({
                                                        'orderLineItemId': id,
                                                        'units': int.parse(
                                                            textControl.text),
                                                      }, 0);
                                                    }
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  onChanged: (value) {
                                                    if (int.parse(value) >
                                                        int.parse(
                                                            '${data.units}')) {
                                                      Get.snackbar("Alert",
                                                          "Please Enter a valid Quantity",
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM);
                                                      textControl.text =
                                                          "${data.units}";
                                                      orderService.updateItem({
                                                        'orderLineItemId': id,
                                                        'units': int.parse(
                                                            textControl.text),
                                                      }, 0);
                                                    } else {
                                                      orderService.updateItem({
                                                        'orderLineItemId': id,
                                                        'units': int.parse(
                                                            textControl.text),
                                                      }, 0);
                                                    }
                                                  },
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (double.parse(
                                                          textControl.text) <
                                                      double.parse(
                                                          '${data.units}')) {
                                                    textControl.text =
                                                        "${double.parse(textControl.text) + 1}";
                                                    orderService.updateItem({
                                                      'orderLineItemId': id,
                                                      'units': int.parse(
                                                          textControl.text),
                                                    }, 0);
                                                  }
                                                },
                                                child: Icon(
                                                    FontAwesomeIcons.plus,
                                                    size: 20),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ));
                      },
                    ),
                    if (orderService.sellerOrderModule.data!
                        .pendingShipmentDeliveryCharges!.isNotEmpty)
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text('Delivery Charge'),
                      ),
                    ...List.generate(
                      orderService.sellerOrderModule.data!
                          .pendingShipmentDeliveryCharges!.length,
                      (index) {
                        final data = orderService.sellerOrderModule.data!
                            .pendingShipmentDeliveryCharges![index];
                        final id = data.id;

                        if (!_textControllers1.containsKey(id)) {
                          _textControllers1['$id'] = TextEditingController();
                          _textControllers1['$id']?.text = "${data.charge}";
                        }
                        final textControl = _textControllers1[id]!;

                        final item = orderService.deliveryCharge.data
                            ?.firstWhereOrNull(
                                (element) => element.type == data.type);

                        return Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Row(
                            spacing: 10,
                            children: [
                              Checkbox(
                                value: orderService.isItemSelected(data.id!, 1),
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      orderService.addItem({
                                        "charge":
                                            double.parse(textControl.text),
                                        "quoteDeliveryChargeId": "${data.id}",
                                        'selected': true,
                                        'type': "${data.type}",
                                      }, 1);
                                    } else {
                                      orderService.removeItem(data.id!, 1);
                                      textControl.text = "${data.charge}";
                                    }
                                  });
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item?.name ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Text('Remaining charge: ${data.charge}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Charge"),
                                  SizedBox(
                                    width: 100,
                                    height: 50,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      controller: textControl,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()),
                                      onTapOutside: (event) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        try {
                                          int enteredValue = int.parse(value);
                                          if (enteredValue >
                                              int.parse('${data.charge}')) {
                                            Get.snackbar(
                                              "Alert",
                                              "Please Enter a Valid Charge",
                                            );
                                            textControl.text = "${data.charge}";
                                          } else {
                                            orderService.updateItem({
                                              "quoteDeliveryChargeId": data.id,
                                              "charge": enteredValue,
                                            }, 1);
                                          }
                                        } catch (e) {
                                          Get.snackbar(
                                            "Error",
                                            "Invalid input",
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Text("(inclusive of GST)",
                                      style: TextStyle(fontSize: 10)),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        spacing: 10,
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Get.back();
                              },
                              color: Theme.of(context).colorScheme.error,
                              child: Text("Cancel",
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              onPressed: orderService.selectedItems.isEmpty
                                  ? () {}
                                  : () async {
                                      bool isLastShipment = !(orderService
                                              .sellerOrderModule
                                              .data
                                              ?.pendingShipmentLineItems!
                                              .any((lineItem) =>
                                                  !lineItem
                                                      .isToleranceApplied! &&
                                                  lineItem.units !=
                                                      orderService.selectedItems
                                                          .firstWhere(
                                                              (item) =>
                                                                  lineItem.id ==
                                                                  item[
                                                                      'orderLineItemId'],
                                                              orElse: () =>
                                                                  null)?['units']) ??
                                          false);

                                      if (orderService.selectedCharge.length !=
                                              (orderService
                                                      .sellerOrderModule
                                                      .data
                                                      ?.pendingShipmentDeliveryCharges!
                                                      .length ??
                                                  0) &&
                                          isLastShipment) {
                                        Get.snackbar(
                                          'Please select at least one delivery charge.',
                                          '',
                                          messageText: const SizedBox.shrink(),
                                        );

                                        return;
                                      }
                                      if (isLastShipment &&
                                          orderService
                                              .selectedCharge.isNotEmpty) {
                                        double totalPendingDeliveryCharges =
                                            orderService.sellerOrderModule.data
                                                    ?.pendingShipmentDeliveryCharges
                                                    ?.fold(
                                                        0,
                                                        (sum, charge) =>
                                                            sum! +
                                                            double.parse(charge
                                                                .charge
                                                                .toString())) ??
                                                0;

                                        double totalSelectedDeliveryCharges =
                                            orderService.selectedCharge.fold(
                                                0,
                                                (sum, charge) =>
                                                    sum + charge['charge']);

                                        if (totalPendingDeliveryCharges !=
                                            totalSelectedDeliveryCharges) {
                                          Get.snackbar(
                                            'Selected charges ($totalSelectedDeliveryCharges) don\'t match pending ($totalPendingDeliveryCharges).',
                                            '',
                                            messageText:
                                                const SizedBox.shrink(),
                                          );
                                          return;
                                        }
                                      }
                                      await orderService.postDatas();
                                      Get.back();
                                    },
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text("Submit",
                                  style: Theme.of(context).textTheme.bodySmall),
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
        ),
      ),
    );
  }
}
