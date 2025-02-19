import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/PaymentBalance_Service.dart';
import '../Orders/OrderBanner.dart';

class OrderDialog extends StatefulWidget {
  dynamic data;
  OrderDialog({super.key, required this.data});

  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  @override
  Widget build(BuildContext context) {
    final paymentBalance = Get.find<PaymentBalanceService>();
    return InkWell(
      onTap: () async {
        await paymentBalance.getOrderData(widget.data['orderId']);
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(),
          builder: (context) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: OrderBanner(
                    orders: paymentBalance.sellerOrderModule.data?.orders?[0] ??
                        []));
          },
        );
      },
      child: Text(
        widget.data['shipmentReferenceId'] ??
            widget.data['orderReferenceId'] ??
            'N/A',
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
