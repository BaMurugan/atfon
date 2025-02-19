import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Controller/Orders_Service.dart';
import '../../../../Controller/Home_Service.dart';

class AddressFields extends StatefulWidget {
  const AddressFields({super.key});

  @override
  State<AddressFields> createState() => _AddressFieldsState();
}

class _AddressFieldsState extends State<AddressFields> {
  final orderService = Get.find<OrderService>();
  final homeService = Get.find<HomeService>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderService>(builder: (_) {
      final orderData = orderService.sellerOrderModule.data;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Order ID : ${orderData?.referenceId ?? ''}'),
                Text(
                    'Order Date : ${DateFormat('dd MMM yyyy').format(orderData!.createdAt!.toLocal())}'),
                Text(
                    'Expected Delivery Date : ${DateFormat('dd MMM yyyy').format(orderData.quote!.quoteRequest!.deliveryPreference!.expectedDeliveryDate!.toLocal())}'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: orderData.quote?.quoteRequest?.selfPickup ?? false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Shipping Address"),
                      Text("Self Pickup"),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Shipping Address'),
                      Text([
                        orderData.deliveryAddress?.partyName,
                        orderData.deliveryAddress?.addressLine1,
                        orderData.deliveryAddress?.city,
                        orderData.deliveryAddress?.district,
                        orderData.deliveryAddress?.state,
                        orderData.deliveryAddress?.pincode
                      ]
                          .where((element) =>
                              element != null && element.isNotEmpty)
                          .join(', ')),
                      Text(
                        'GST Number : ${orderData.deliveryAddress?.gstNumber ?? ''}',
                      ),
                      Text(
                          'PAN Number : ${orderData.deliveryAddress?.panNumber ?? ''}'),
                      Text(
                          'Expected Delivery Time : ${orderData.quote?.quoteRequest?.deliveryPreference?.expectedDeliveryTime ?? ''}'),
                    ],
                  ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Billing Address : '),
                Text([
                  orderData.billingAddress?.partyName,
                  orderData.billingAddress?.addressLine1,
                  orderData.billingAddress?.city,
                  orderData.billingAddress?.district,
                  orderData.billingAddress?.state,
                  orderData.billingAddress?.pincode
                ]
                    .where((element) => element != null && element.isNotEmpty)
                    .join(', ')),
                Text(
                  'GST Number : ${orderData.billingAddress?.gstNumber ?? ''}',
                ),
                Text(
                    'PAN Number : ${orderData.billingAddress?.panNumber ?? ''}')
              ],
            ),
          ),
        ],
      );
    });
  }
}
