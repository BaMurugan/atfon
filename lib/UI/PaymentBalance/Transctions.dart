import 'package:autofon_seller/UI/PaymentBalance/OrderDialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/PaymentBalance_Service.dart';

class TransctionsWidget extends StatefulWidget {
  Map? data;
  TransctionsWidget({super.key, this.data});

  @override
  State<TransctionsWidget> createState() => _TransctionsWidgetState();
}

class _TransctionsWidgetState extends State<TransctionsWidget> {
  final paymentBalance = Get.put(PaymentBalanceService());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(fetchData);
    super.initState();
  }

  fetchData() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      paymentBalance.fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Map data = widget.data ?? {};

    return GetBuilder<PaymentBalanceService>(
      builder: (controller) => Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "Current Ledger balance: Rs.${paymentBalance.wallet.balance}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Reference ID')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Debit')),
                      DataColumn(label: Text('Credit')),
                      DataColumn(label: Text('Amount')),
                    ],
                    rows: paymentBalance.transactions.map((data) {
                      bool type = data['walletBalance'] == "0.00";
                      Color color = type ? Colors.red : Colors.green;
                      return DataRow(cells: [
                        DataCell(OrderDialog(data: data)),
                        DataCell(Text(
                          data['createdAt'] != null
                              ? DateFormat('dd MMM yyyy')
                                  .format(DateTime.parse(data['createdAt']!))
                              : 'N/A',
                        )),
                        DataCell(Text(data['type'] ?? 'N/A')),
                        DataCell(Text("Rs.${data['debit']}")),
                        DataCell(Text("Rs. ${data['credit']}")),
                        DataCell(Text(
                          "Rs. ${data['walletBalance']}",
                          style: TextStyle(color: color),
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
