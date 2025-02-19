import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../../Controller/Orders_Service.dart';

class ViewOrderCommissionNote extends StatefulWidget {
  const ViewOrderCommissionNote({super.key});

  @override
  State<ViewOrderCommissionNote> createState() =>
      _ViewOrderCommissionNoteState();
}

class _ViewOrderCommissionNoteState extends State<ViewOrderCommissionNote> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        final quoteData = orderService.sellerQuoteModule.data;
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
                            quoteData!.quoteLineItems!.length,
                            (index) {
                              final itemData = quoteData.quoteLineItems![index];
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
                                    Text(itemData.name!),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      spacing: 10,
                                      children: [
                                        columnItems(
                                            name: 'Qty',
                                            value:
                                                '${itemData.units} ${itemData.uom}'),
                                        columnItems(
                                            name: 'Total Amount',
                                            value: itemData.itemTotalPrice!),
                                        columnItems(
                                            name: 'Commission Rate',
                                            value: itemData.commissionRate!),
                                        columnItems(
                                            name: 'Commission Amount',
                                            value: itemData.commissionAmount!),
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
                        value: quoteData.totalDeliveryChargesCommission!),
                    rowItems(
                        name: 'Total Amount',
                        value: double.parse(quoteData.totalCommission!) +
                            double.parse(
                                quoteData.totalDeliveryChargesCommission!))
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
