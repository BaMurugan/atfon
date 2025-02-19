import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../../Controller/Orders_Service.dart';

class ViewOrderProductList extends StatefulWidget {
  dynamic order;
  ViewOrderProductList({super.key, required this.order});

  @override
  State<ViewOrderProductList> createState() => _ViewOrderProductListState();
}

class _ViewOrderProductListState extends State<ViewOrderProductList> {
  final orderService = Get.find<OrderService>();

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    double quantity = double.tryParse(order.units ?? '0.00') ?? 0.0;
    String formattedQuantity = quantity == quantity.toInt()
        ? quantity.toInt().toString()
        : quantity.toStringAsFixed(8).replaceAll(RegExp(r"([.]*0+)$"), "");
    return GetBuilder<OrderService>(
      builder: (_) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(width: 2.4),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image(
                    image: NetworkImage(
                      order.imageUrl!,
                    ),
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(order.name!),
                        Text('Quantity $formattedQuantity ${order.uom}'),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: rowItems(
                      name: 'Item Price',
                      widget: Column(
                        children: [
                          Text(order.itemPrice),
                          Text('(inclusive of GST)',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: rowItems(
                        name: 'GST Rate',
                        widget: Text(
                            '${order.gstRate != null ? '${order.gstRate}%' : order.gstRate ?? 'NIL'}')),
                  ),
                  Expanded(
                    child: rowItems(
                        name: 'GST Amount',
                        widget: Text('${order.taxAmount ?? 'NIL'}')),
                  ),
                  Expanded(
                      child: rowItems(
                          name: 'Total Price',
                          widget: Text(order.itemTotalPrice))),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  rowItems({required String name, required Widget widget}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(name, textAlign: TextAlign.center), widget],
    );
  }
}
