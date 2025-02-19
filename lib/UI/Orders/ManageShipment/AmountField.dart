import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/Orders_Service.dart';

class AmountField extends StatefulWidget {
  const AmountField({super.key});

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    final orderData = orderService.sellerOrderModule.data;
    final quateData = orderService.sellerQuoteModule.data;
    return GetBuilder<OrderService>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              lineItem(
                'Total Bill(Inclusive of GST)',
                (double.parse(quateData?.totalPrice ?? '0.00') -
                        double.parse(
                            orderData?.quote?.totalDeliveryCharge ?? '0.00'))
                    .toStringAsFixed(2),
              ),
              lineItem('GST(12%)', orderData?.quote?.totalTax ?? ''),
              lineItem(
                  'Other Charges', orderData?.quote?.totalDeliveryCharge ?? ''),
              Divider(),
              lineItem('Order Total', orderData?.totalPrice ?? '')
            ],
          ),
        );
      },
    );
  }

  lineItem(dynamic key, dynamic value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$key'),
        Text('$value'),
      ],
    );
  }
}
