import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Controller/Orders_Service.dart';

class QuotedDetailsButton extends StatefulWidget {
  dynamic orders;
  QuotedDetailsButton({super.key, required this.orders});

  @override
  State<QuotedDetailsButton> createState() => _QuotedDetailsButtonState();
}

class _QuotedDetailsButtonState extends State<QuotedDetailsButton> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    final orders = widget.orders;
    return MaterialButton(
      onPressed: orders.status == 'Cancelled'
          ? () {}
          : () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(),
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Quote Details',
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  orders.quote.quoteLineItems.length,
                                  (index) {
                                    final itemData =
                                        orders.quote.quoteLineItems[index];
                                    double quantity = double.tryParse(
                                            itemData.units ?? '0.00') ??
                                        0.0;
                                    String formattedQuantity =
                                        quantity == quantity.toInt()
                                            ? quantity.toInt().toString()
                                            : quantity
                                                .toStringAsFixed(8)
                                                .replaceAll(
                                                    RegExp(r"([.]*0+)$"), "");
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              itemData.product.imageUrl,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Column(
                                              spacing: 2,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(itemData.product.name),
                                                SizedBox(height: 4),
                                                Text(
                                                    'Size: ${formattedQuantity} ${itemData.uom}'),
                                                Text(
                                                    'Price (incl. GST): Rs. ${itemData.itemPrice}'),
                                                Text(
                                                    'GST Rate: ${itemData.gstRate}%'),
                                                Text(
                                                    'GST Amount: Rs. ${itemData.taxAmount}'),
                                                Text(
                                                    'Total Price: Rs. ${itemData.itemTotalPrice}'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                ...List.generate(
                                  orders.quote.deliveryCharges.length,
                                  (index) {
                                    final deliveryCharge =
                                        orders.quote.deliveryCharges[index];
                                    final deliverType = orderService
                                        .deliveryCharge.data!
                                        .firstWhere((element) =>
                                            element.type ==
                                            deliveryCharge.type);
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: Text(deliverType.name!)),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('${deliveryCharge.charge}'),
                                              Text('(inclusive of GST)'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                            'Delivery Date and Time :\n${DateFormat('dd MMM yyyy').format(orders.quote?.quoteRequest?.deliveryPreference.sellerExpectedDeliveryDate?.toLocal() ?? orders.quote.quoteRequest.deliveryPreference.expectedDeliveryDate.toLocal())}, (${orders.quote.quoteRequest.deliveryPreference.sellerExpectedDeliveryTime ?? orders.quote.quoteRequest.deliveryPreference.expectedDeliveryTime})'),
                        Text('Total Price : ${orders.totalPrice}'),
                      ],
                    ),
                  );
                },
              );
            },
      color: Theme.of(context).colorScheme.secondary,
      child: Text(
        'Quoted',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
