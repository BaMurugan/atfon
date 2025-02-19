import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriviousQuoteHistory extends StatefulWidget {
  final itemData;
  PriviousQuoteHistory({super.key, required this.itemData});

  @override
  State<PriviousQuoteHistory> createState() => _PriviousQuoteHistoryState();
}

class _PriviousQuoteHistoryState extends State<PriviousQuoteHistory> {
  @override
  Widget build(BuildContext context) {
    final itemData = widget.itemData;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(),
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    itemData.quoteLineItems.length,
                    (index) {
                      final data = itemData.quoteLineItems[index];
                      double quantity =
                          double.tryParse(data?.units ?? '0.00') ?? 0.0;
                      String formattedQuantity = quantity == quantity.toInt()
                          ? quantity.toInt().toString()
                          : quantity
                              .toStringAsFixed(8)
                              .replaceAll(RegExp(r"([.]*0+)$"), "");
                      return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.4),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        data.imageUrl!,
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                              'Quantity $formattedQuantity ${data.uom}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: columnItems(
                                      name: 'Item Price',
                                      widget: Column(
                                        children: [
                                          Text('Rs.${data.itemPrice}'),
                                          Text('(inclusive of GST)',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 10)),
                                        ],
                                      ),
                                    )),
                                    Expanded(
                                        child: columnItems(
                                            name: 'GST Rate',
                                            widget: Text(data.gstRate != null
                                                ? '${data.gstRate}%'
                                                : 'NIL'))),
                                    Expanded(
                                        child: columnItems(
                                            name: 'GST Amt',
                                            widget: Text('${data.taxAmount}'))),
                                    Expanded(
                                        child: columnItems(
                                            name: 'Total Price',
                                            widget: Text(data.itemTotalPrice))),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Click to view order Details @ ',
            ),
            Text(
              DateFormat('dd MMM yyyy hh:mm a')
                  .format(itemData.createdAt!.toLocal()),
            ),
          ],
        ),
      ),
    );
  }

  columnItems({required String name, required Widget widget}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(name), widget],
    );
  }
}
