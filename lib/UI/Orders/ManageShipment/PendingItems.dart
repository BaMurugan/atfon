import 'package:autofon_seller/Controller/Orders_Service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ProductListDesign.dart';

class PendingItems extends StatefulWidget {
  const PendingItems({super.key});

  @override
  State<PendingItems> createState() => _PendingItemsState();
}

class _PendingItemsState extends State<PendingItems> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderService>(
      builder: (controller) {
        final orderData = orderService.sellerOrderModule.data;
        return orderData!.pendingShipmentLineItems!.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(),
                    context: context,
                    builder: (context) {
                      return GetBuilder<OrderService>(
                        builder: (_) {
                          final deliveryCharge =
                              orderData.pendingShipmentDeliveryCharges!.fold(
                            0.0,
                            (sum, item) => sum + (item.charge ?? 0.0),
                          );

                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 10,
                              children: [
                                Text(
                                    'Pending Shipment Products & Delivery Charges'),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        orderData
                                            .pendingShipmentLineItems!.length,
                                        (index) {
                                          return ProductListDesign(
                                              itemData: orderData
                                                      .pendingShipmentLineItems![
                                                  index]);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                deliveryCharge > 0
                                    ? Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 2)),
                                        child: Text(
                                            'Remaining Delivery Charge : $deliveryCharge'),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2),
                      color: Theme.of(context).colorScheme.secondary),
                  alignment: Alignment.center,
                  child: Text('Click to view Pending Shipment Items'),
                ),
              );
      },
    );
  }
}
