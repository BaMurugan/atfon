import 'package:autofon_seller/Other%20Service/ApiPath.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/Orders_Service.dart';
import 'DispatchDialog.dart';
import 'PendingShipmentItems.dart';

class ShipmentProgress extends StatefulWidget {
  const ShipmentProgress({super.key});

  @override
  State<ShipmentProgress> createState() => _ShipmentProgressState();
}

class _ShipmentProgressState extends State<ShipmentProgress> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderService>(
      builder: (_) {
        final orderData = orderService.sellerOrderModule.data;
        if (orderService.isEdit) {
          if (orderData!.shipments!.isEmpty) {
            orderService.isEdit = false;
          }
        }
        bool val = orderService.sellerOrderModule.data!.shipments!.any(
          (element) => element.status != 'Pending',
        );

        return Container(
          child: orderData!.pendingShipmentLineItems!.isEmpty && val == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: orderData.isSplitOrderCompleted!
                            ? () {}
                            : () {
                                orderService.isEdit = false;
                                orderService.updateOrder(
                                    body: {},
                                    path:
                                        '${ApiPaths.sellerUpdateSplitOrder}/${orderService.orderId}');
                              },
                        child: Text('Complete',
                            style: TextStyle(
                                color: orderData.isSplitOrderCompleted!
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Colors.blue))),
                    InkWell(
                        onTap: orderData.isSplitOrderCompleted!
                            ? () {}
                            : () {
                                orderService.isEdit = true;
                                orderService.update();
                              },
                        child: Text('Edit',
                            style: TextStyle(
                                color: orderData.isSplitOrderCompleted!
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Colors.blue)))
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (orderData.shipments!.isEmpty)
                      DispatchDialog(
                          allinOneShipment: true,
                          titleWidget: Text('Dispatch All in One Shipment',
                              style: TextStyle(color: Colors.green))),
                    if (orderData!.pendingShipmentLineItems!.isNotEmpty)
                      InkWell(
                          onTap: () {
                            orderService.update();
                            Get.to(PendingShipmentItems(
                              id: '',
                            ));
                          },
                          child: Text('Create Shipment',
                              style: TextStyle(color: Colors.blue)))
                  ],
                ),
        );
      },
    );
  }
}
