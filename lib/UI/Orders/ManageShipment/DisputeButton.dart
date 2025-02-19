import 'package:autofon_seller/Controller/Home_Service.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../Controller/Orders_Service.dart';
import '../../../../Module/SellerOrder_Module.dart';

class DisputeButton extends StatefulWidget {
  String shipmentID;
  String referenceId;
  final List<Item> shipmentProducts;

  DisputeButton(
      {Key? key,
      required this.shipmentProducts,
      required this.shipmentID,
      required this.referenceId})
      : super(key: key);

  @override
  State<DisputeButton> createState() => _DisputeButtonState();
}

class _DisputeButtonState extends State<DisputeButton> {
  final OrderService orderService = Get.find<OrderService>();
  final homeService = Get.find<HomeService>();
  int page = 0;
  TextEditingController creditNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    creditNote({required VoidCallback voidcallback}) {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Preview Credit Note', textAlign: TextAlign.center),
                Text('Credit Note Number: ${creditNoteController.text}'),
                Text('Shipment ID: ${widget.referenceId}'),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: voidcallback,
                  child: Text('Confirm & Submit',
                      style: Theme.of(context).textTheme.bodySmall),
                )
              ],
            ),
          );
        },
      );
    }

    return InkWell(
      onTap: () {
        page = 0;
        List<Widget> entries = [];

        final List<TextEditingController> entryControllers = [];
        final List<String> itemIDs = [];
        final List<Map<String, dynamic>> disputeItems = [];
        final formKey = GlobalKey<FormState>();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(),
          builder: (context) => StatefulBuilder(
            builder: (context, setModalState) {
              void _addEntry(String id, String name, int index, String uno) {
                if (itemIDs.contains(id)) return;

                final newController = TextEditingController();
                newController.text = '';

                entryControllers.add(newController);
                itemIDs.add(id);
                disputeItems.add({'shipmentLineItemId': id, 'units': ''});

                entries.add(Column(
                  key: ValueKey(newController.hashCode),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodySmall,
                            controller: newController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                labelText: name,
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                                suffix: Text(uno)),
                            onChanged: (value) {
                              setModalState(() {
                                disputeItems[index]['units'] = value;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.trash,
                              color: Theme.of(context).colorScheme.error),
                          onPressed: () {
                            setModalState(() {
                              final removeIndex = entries.indexWhere((entry) =>
                                  (entry.key as ValueKey).value ==
                                  newController.hashCode);
                              if (removeIndex != -1) {
                                entries.removeAt(removeIndex);
                                entryControllers.removeAt(removeIndex);
                                itemIDs.removeAt(removeIndex);
                                disputeItems.removeAt(removeIndex);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ));
              }

              return Padding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SingleChildScrollView(
                          child: Form(
                        key: formKey,
                        child: Column(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Dispute Order",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                              items: widget.shipmentProducts.map((product) {
                                return DropdownMenuItem<String>(
                                  value: product.id,
                                  child: Text(product.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null && value.isNotEmpty) {
                                  final index = widget.shipmentProducts
                                      .indexWhere((item) => item.id == value);
                                  if (index != -1) {
                                    setModalState(() => _addEntry(
                                        value,
                                        widget.shipmentProducts[index].name!,
                                        disputeItems.length,
                                        widget.shipmentProducts[index].uom ??
                                            ''));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Please select an option first")),
                                  );
                                }
                              },
                              hint: Text("Select a Product"),
                            ),
                            SingleChildScrollView(
                                child: Column(children: entries)),
                            if (homeService.user.data?.sellerType == 'SB')
                              Divider(),
                            if (homeService.user.data?.sellerType == 'SB')
                              TextFormField(
                                style: Theme.of(context).textTheme.bodySmall,
                                controller: creditNoteController,
                                decoration: InputDecoration(
                                    labelText: 'Enter Credit Note Number',
                                    labelStyle:
                                        Theme.of(context).textTheme.bodySmall,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2))),
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Please Enter the Credit Note Number';
                                  }
                                  return null;
                                },
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (disputeItems.isEmpty) {
                                        Get.snackbar('Error',
                                            'Please Add Some Products to Continue');
                                        return;
                                      }

                                      for (final item in disputeItems) {
                                        final matchingItem = widget
                                            .shipmentProducts
                                            .firstWhereOrNull((product) =>
                                                product.id ==
                                                item['shipmentLineItemId']);
                                        if (matchingItem != null &&
                                            matchingItem != '') {
                                          final enteredUnits =
                                              double.tryParse(item['units']) ??
                                                  -1;
                                          final availableUnits =
                                              double.tryParse(
                                                      matchingItem.units!) ??
                                                  -1;

                                          if (enteredUnits <= 0 ||
                                              enteredUnits > availableUnits) {
                                            Get.snackbar("Alert",
                                                "Please enter valid units");
                                            return;
                                          }
                                        }
                                      }

                                      if (formKey.currentState!.validate()) {
                                        if (homeService.user.data?.sellerType ==
                                            'SB') {
                                          Get.back();
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          creditNote(
                                            voidcallback: () async {
                                              try {
                                                await orderService
                                                    .updateShipment(body: {
                                                  'disputeItems': disputeItems,
                                                  'orderId':
                                                      orderService.orderId,
                                                  'shipmentId':
                                                      widget.shipmentID,
                                                  'isSellerDispute': true
                                                }, path: '${ApiPaths.sellerOrders}${ApiPaths.sellerVerifyOrder}');

                                                await orderService.updateShipment(
                                                    path:
                                                        '${ApiPaths.sellerOrders}${ApiPaths.sellerSetCreditNoteNumber}/${widget.shipmentID}',
                                                    body: {
                                                      'creditNoteNumber':
                                                          creditNoteController
                                                              .text,
                                                    });
                                                Get.back();
                                              } catch (e) {
                                                Get.snackbar('Error',
                                                    'Something Went Wrong');
                                              }
                                            },
                                          );
                                        } else {
                                          try {
                                            await orderService.updateShipment(
                                                body: {
                                                  'disputeItems': disputeItems,
                                                  'orderId':
                                                      orderService.orderId,
                                                  'shipmentId':
                                                      widget.shipmentID,
                                                  'isSellerDispute': true
                                                },
                                                path:
                                                    '${ApiPaths.sellerOrders}${ApiPaths.sellerVerifyOrder}');
                                            Get.back();
                                          } catch (e) {
                                            Get.snackbar('Error',
                                                'Something Went Wrong');
                                          }
                                        }
                                      }
                                    },
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Text("Dispute Order",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () => Navigator.pop(context),
                                    color: Theme.of(context).colorScheme.error,
                                    child: Text("Cancel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))));
            },
          ),
        );
      },
      child: Text(
        'Dispute',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
