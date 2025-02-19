import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Controller/Orders_Service.dart';
import '../../../../Other Service/ApiPath.dart';

class BuyerDisputeButton extends StatefulWidget {
  dynamic order;
  BuyerDisputeButton({super.key, required this.order});

  @override
  State<BuyerDisputeButton> createState() => _BuyerDisputeButtonState();
}

class _BuyerDisputeButtonState extends State<BuyerDisputeButton> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Container(
        alignment: Alignment.center,
        child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(),
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 10, vertical: 10),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: Column(spacing: 10, children: [
                          Text('Dispute Order'),
                          ...List.generate(
                            order.disputeLineItems.length,
                            (index) {
                              final itemData = order.disputeLineItems[index];
                              TextEditingController control =
                                  TextEditingController(
                                      text:
                                          '${itemData.units} ${itemData.uom}');
                              return Column(spacing: 10, children: [
                                Text(itemData.productName),
                                TextField(
                                  controller: control,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2))),
                                )
                              ]);
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () async {
                                await orderService.updateShipment(
                                    path:
                                        '${ApiPaths.sellerOrders}${ApiPaths.disputeOrder}',
                                    body: {
                                      'isRejected': false,
                                      'orderId': order.orderId,
                                      'shipmentId': order.id,
                                      'shipmentReferenceId': order.referenceId,
                                    });
                                Get.back();
                              },
                              child: Text('Accept',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                          )
                        ]));
                  });
            },
            child: Text('Dispute Received',
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.error))));
  }
}
