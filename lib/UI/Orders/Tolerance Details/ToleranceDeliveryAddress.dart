import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Controller/Orders_Service.dart';

class ToleranceDeliveryAddress extends StatefulWidget {
  const ToleranceDeliveryAddress({super.key});

  @override
  State<ToleranceDeliveryAddress> createState() =>
      _ToleranceDeliveryAddressState();
}

class _ToleranceDeliveryAddressState extends State<ToleranceDeliveryAddress> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderService>(
      builder: (_) {
        final address = orderService.sellerOrderModule.data;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Delivery Address',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                [
                  address?.deliveryAddress?.partyName,
                  address?.deliveryAddress?.addressLine1,
                  address?.deliveryAddress?.city,
                  address?.deliveryAddress?.district,
                  address?.deliveryAddress?.state,
                  address?.deliveryAddress?.pincode,
                ]
                    .where((element) => element != null && element.isNotEmpty)
                    .join(' '),
              ),
              Text('GST : ${address?.deliveryAddress?.gstNumber ?? '--'}'),
              Text('PAN : ${address?.deliveryAddress?.panNumber ?? '--'}'),
            ],
          ),
        );
      },
    );
  }
}
