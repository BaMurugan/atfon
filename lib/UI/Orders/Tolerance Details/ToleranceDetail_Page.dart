import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../Controller/Orders_Service.dart';
import 'ToleranceDeliveryAddress.dart';
import 'ToleranceDeliveryCharge.dart';
import 'ToleranceProductList.dart';
import 'TolerenceCommessionNote.dart';

class ToleranceDetailPage extends StatefulWidget {
  String quoteId;
  String orderId;
  ToleranceDetailPage(
      {super.key, required this.quoteId, required this.orderId});

  @override
  State<ToleranceDetailPage> createState() => _ToleranceDetailPageState();
}

class _ToleranceDetailPageState extends State<ToleranceDetailPage> {
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
          final order = orderService.sellerOrderModule.data!;
          final quote = orderService.sellerQuoteModule.data!;
          orderService.sellerOrderModule.data!.allShipmentItems!
              .sort((a, b) => a.productId!.compareTo(b.productId!));
          List<Map<String, dynamic>> quotes = [];

          for (int i = 0;
              i < orderService.sellerOrderModule.data!.allShipmentItems!.length;
              i++) {
            final data =
                orderService.sellerOrderModule.data!.allShipmentItems![i];

            int index =
                quotes.indexWhere((e) => e['productId'] == data.productId);

            if (index == -1) {
              quotes.add({
                'productId': data.productId,
                'name': data.name,
                'uom': data.uom,
                'units': double.parse(data.units ?? '0'),
                'itemPrice': double.parse(data.itemPrice ?? '0'),
                'gstRate': data.gstRate != null
                    ? double.tryParse(data.gstRate!)
                    : null,
                'taxAmount': double.parse(data.taxAmount ?? '0'),
                'itemTotalPrice': double.parse(data.itemTotalPrice ?? '0'),
                'imageUrl': data.imageUrl ?? '',
                'commissionAmount':
                    double.parse(data.commissionAmount ?? '0.0'),
              });
            } else {
              quotes[index]['units'] += double.parse(data.units ?? '0');

              quotes[index]['taxAmount'] +=
                  double.parse(data.taxAmount ?? '0.0');
              quotes[index]['itemTotalPrice'] +=
                  double.parse(data.itemTotalPrice ?? '0.0');

              quotes[index]['commissionAmount'] +=
                  double.parse(data.commissionAmount ?? '0.0');
            }
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10,
                children: [
                  Text(
                    'Tolerance Order Details',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  ToleranceDeliveryAddress(),
                  ...List.generate(
                    quotes.length,
                    (index) {
                      final data = quotes[index];
                      orderService.totalAmount += data['itemTotalPrice'];
                      orderService.totalTax += data['taxAmount'];
                      orderService.totalCommission += data['commissionAmount']!;
                      print(
                          "units type: ${quotes[index]['units'].runtimeType},");
                      print(
                          "itemPrice type: ${quotes[index]['itemPrice'].runtimeType},");
                      print(
                          "taxAmount type: ${quotes[index]['taxAmount'].runtimeType},");
                      print(
                          "itemTotalPrice type: ${quotes[index]['itemTotalPrice'].runtimeType}, ");

                      return ToleranceProductList(order: data);
                      // return Container();
                    },
                  ),
                  ToleranceDeliverCharge(),
                  Text(
                    'Quote Summary',
                    textAlign: TextAlign.center,
                  ),
                  rowItems(
                      name: 'Total Tax',
                      value: orderService.totalTax.toStringAsFixed(2)),
                  rowItems(
                      name: 'Total Amount',
                      value: (orderService.totalAmount +
                              double.parse(quote.totalDeliveryCharge!))
                          .toStringAsFixed(2)),
                  Text(
                    'Total Commission : ${orderService.totalCommission.toStringAsFixed(2)}',
                    textAlign: TextAlign.left,
                  ),
                  ToleranceCommissionNote(),
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
