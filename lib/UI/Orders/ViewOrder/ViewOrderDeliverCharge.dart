import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Controller/Orders_Service.dart';

class ViewOrderDeliverCharge extends StatefulWidget {
  const ViewOrderDeliverCharge({super.key});

  @override
  State<ViewOrderDeliverCharge> createState() => _ViewOrderDeliverChargeState();
}

class _ViewOrderDeliverChargeState extends State<ViewOrderDeliverCharge> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderService>(
      builder: (_) {
        final order = orderService.sellerQuoteModule.data!;
        return order.deliveryCharges!.isNotEmpty
            ? Column(
                spacing: 5,
                children: [
                  Text('Other Charges'),
                  ...List.generate(
                    order.deliveryCharges!.length,
                    (index) {
                      final data =
                          orderService.deliveryCharge.data!.firstWhereOrNull(
                        (element) {
                          return element.type ==
                              order.deliveryCharges![index].type;
                        },
                      );
                      return lineItem(
                          data!.name!, order.deliveryCharges![index].charge!);
                    },
                  ),
                  lineItem('Total Other Charges', order.totalDeliveryCharge!)
                ],
              )
            : SizedBox();
      },
    );
  }

  lineItem(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(key),
        Text(value),
      ],
    );
  }
}
