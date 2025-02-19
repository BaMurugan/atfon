import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Controller/Orders_Service.dart';

class ToleranceDeliverCharge extends StatefulWidget {
  const ToleranceDeliverCharge({super.key});

  @override
  State<ToleranceDeliverCharge> createState() => _ToleranceDeliverChargeState();
}

class _ToleranceDeliverChargeState extends State<ToleranceDeliverCharge> {
  final orderService = Get.find<OrderService>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderService>(
      builder: (_) {
        final order = orderService.sellerOrderModule.data!;
        final quote = orderService.sellerQuoteModule.data!;
        return quote.deliveryCharges!.isNotEmpty
            ? Column(
                spacing: 5,
                children: [
                  Text('Other Charges'),
                  ...List.generate(
                    quote.deliveryCharges!.length,
                    (index) {
                      final data =
                          orderService.deliveryCharge.data!.firstWhereOrNull(
                        (element) {
                          return element.type ==
                              quote.deliveryCharges![index].type;
                        },
                      );

                      return lineItem(
                          data!.name!, quote.deliveryCharges![index].charge!);
                    },
                  ),
                  lineItem(
                      'Total Delivery Charge', quote.totalDeliveryCharge ?? ''),
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
