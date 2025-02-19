import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../Controller/Orders_Service.dart';
import 'ManageShipment/ManageShipment_Page.dart';
import 'Quoted/QuotedDetailsButton.dart';
import 'Tolerance Details/ToleranceDetail_Page.dart';
import 'ViewOrder/ViewOrderPage.dart';

class OrderDetails extends StatefulWidget {
  dynamic orders;
  OrderDetails({super.key, required this.orders});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final orderService = Get.find<OrderService>();
  Timer? time;
  bool isToleranceApplied = false;
  int seconds = 0;
  bool show = true;
  @override
  void initState() {
    seconds =
        DateTime.now().difference(widget.orders.createdAt.toLocal()).inSeconds;
    checkTolerance();
    if (seconds < 60) {
      show = false;
      seconds = 60 - seconds;
      startTimer();
    }

    super.initState();
  }

  checkTolerance() {
    final order = widget.orders;
    final data =
        order.orderLineItems.any((e) => e.isToleranceApplied == true) ?? false;
    isToleranceApplied = (order.isSplitOrderCompleted && data);
  }

  @override
  void dispose() {
    time?.cancel();
    super.dispose();
  }

  startTimer() {
    time = Timer(
      Duration(seconds: seconds),
      () {
        show = true;
        orderService.update();
        time?.cancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = widget.orders;

    return GetBuilder<OrderService>(
      builder: (_) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: orders.status != 'Cancelled'
              ? Colors.white
              : Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 3),
          boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)],
        ),
        child: Column(
          spacing: 7,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            lineItems('Order ID', orders.referenceId),
            lineItems('No Of Shipments', orders.shipmentsLength),
            lineItems('No Of Products', orders.lineItemsCount),
            lineItems('Value (inclusive of GST)', orders.totalPrice),
            lineItems('Status', orders.status),
            lineItems(
              'Expected Delivery Date',
              DateFormat('dd MMM yyyy').format(orders.quote?.quoteRequest
                      ?.deliveryPreference.sellerExpectedDeliveryDate
                      ?.toLocal() ??
                  orders.quote.quoteRequest.deliveryPreference
                      .expectedDeliveryDate
                      .toLocal()),
            ),
            lineItems(
                'Expected Delivery Time',
                orders.quote.quoteRequest.deliveryPreference
                        .sellerExpectedDeliveryTime ??
                    orders.quote.quoteRequest.deliveryPreference
                        .expectedDeliveryTime),
            if (orders.quote.quoteRequest.selfPickup)
              Text(
                'Self Pickup',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            MaterialButton(
              onPressed: orders.status == 'Cancelled'
                  ? () {}
                  : () {
                      Get.to(ViewOrderPage(
                          quoteId: orders.quoteId, orderId: orders.id));
                    },
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                'View Order',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            if (isToleranceApplied)
              MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: orders.status == 'Cancelled'
                    ? () {}
                    : () {
                        Get.to(ToleranceDetailPage(
                            quoteId: orders.quoteId, orderId: orders.id));
                      },
                child: Text('Tolerance Details',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            QuotedDetailsButton(orders: orders),
            if (orders.status != 'Delivered' &&
                show &&
                orders.status != 'Cancelled')
              MaterialButton(
                onPressed: () {
                  Get.to(ManageShipmentPage(
                      quoteId: orders.quoteId, orderId: orders.id));
                },
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  'Manage Shipment',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
          ],
        ),
      ),
    );
  }

  lineItems(dynamic key, dynamic value) {
    return Row(
      children: [
        Expanded(child: Text('$key')),
        Expanded(child: Text('$value'))
      ],
    );
  }
}
