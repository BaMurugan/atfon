import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../../Controller/Orders_Service.dart';

class ToleranceCommissionNote extends StatefulWidget {
  const ToleranceCommissionNote({super.key});

  @override
  State<ToleranceCommissionNote> createState() =>
      _ToleranceCommissionNoteState();
}

class _ToleranceCommissionNoteState extends State<ToleranceCommissionNote> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        final quoteData = orderService.sellerQuoteModule.data;
        final orderData = orderService.sellerOrderModule.data;
        double commissionAmount = 0;
        List<Map<String, dynamic>> names = [];

        for (int i = 0; i < orderData!.allShipmentItems!.length; i++) {
          var item = orderData.allShipmentItems![i];

          int index =
              names.indexWhere((element) => element['name'] == item.name);

          if (index == -1) {
            // If item not found, add a new entry
            names.add({
              'name': item.name,
              'totalAmount': double.parse(item.itemTotalPrice!),
              'commissonRate': item.commissionRate,
              'qty': double.parse(item.units!),
              'commissionAmount': double.parse(item.commissionAmount!)
            });
          } else {
            // If item exists, update the existing entry
            names[index]['totalAmount'] += double.parse(item.itemTotalPrice!);
            names[index]['qty'] += double.parse(item.units!);
            names[index]['commissionAmount'] +=
                double.parse(item.commissionAmount!);
          }

          commissionAmount += double.parse(item.commissionAmount!);
        }

        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(),
          builder: (context) {
            return GetBuilder<OrderService>(
              builder: (_) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    Text('Commission Note', textAlign: TextAlign.center),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            names!.length,
                            (index) {
                              final itemData = names![index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(itemData['name']!),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      spacing: 10,
                                      children: [
                                        columnItems(
                                            name: 'Qty',
                                            value: double.parse(
                                                    '${itemData['qty']}')
                                                .toStringAsFixed(2)),
                                        columnItems(
                                            name: 'Total Amount',
                                            value: double.parse(
                                                    '${itemData['totalAmount']!}')
                                                .toStringAsFixed(2)),
                                        columnItems(
                                            name: 'Commission Rate',
                                            value: double.parse(
                                                    '${itemData['commissonRate']!}')
                                                .toStringAsFixed(2)),
                                        columnItems(
                                            name: 'Commission Amount',
                                            value: double.parse(
                                                    '${itemData['commissionAmount']!}')
                                                .toStringAsFixed(2)),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    rowItems(
                        name: 'Other Charges',
                        value: quoteData?.totalDeliveryChargesCommission!),
                    rowItems(
                        name: 'Total Amount',
                        value: (double.parse(
                                    quoteData?.totalDeliveryChargesCommission ??
                                        '0') +
                                commissionAmount)
                            .toStringAsFixed(2))
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Text(
        'Commission Note',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  rowItems({required String name, required dynamic value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(name), Text('${value}')],
    );
  }

  columnItems({required String name, required dynamic value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name.split(' ').join('\n'),
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: null,
        ),
        Text(
          '$value',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
