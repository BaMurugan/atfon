import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../Controller/Orders_Service.dart';

import 'ViewOrderCommissionNote.dart';
import 'ViewOrderDeliverCharge.dart';
import 'ViewOrderDeliveryAddress.dart';

import 'ViewOrderProductList.dart';

class ViewOrderPage extends StatefulWidget {
  String? quoteId;
  String orderId;
  ViewOrderPage({super.key, this.quoteId, required this.orderId});

  @override
  State<ViewOrderPage> createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: orderService.getViewOrderDetails(
            qteId: widget.quoteId, odrId: widget.orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final quote = orderService.sellerQuoteModule.data!;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10,
                children: [
                  Text(
                    'Order Details',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  ViewOrderDeliveryAddress(),
                  ...List.generate(
                    quote.quoteLineItems!.length,
                    (index) {
                      return ViewOrderProductList(
                          order: quote.quoteLineItems![index]);
                    },
                  ),
                  ViewOrderDeliverCharge(),
                  Text(
                    'Quote Summary',
                    textAlign: TextAlign.center,
                  ),
                  rowItems(name: 'Total Tax', value: quote.totalTax),
                  rowItems(name: 'Total Amount', value: quote.totalPrice),
                  Text(
                    'Total Commission : ${double.parse(quote.totalCommission!) + double.parse(quote.totalDeliveryChargesCommission!)}',
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ViewOrderCommissionNote(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  rowItems({required String name, required dynamic value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(name), Text('${value}')],
    );
  }
}
