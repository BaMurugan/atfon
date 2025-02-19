import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/TaxDeduction_Service.dart';
import '../Orders/ViewOrder/ViewOrderPage.dart';

class ItDeduction extends StatefulWidget {
  const ItDeduction({super.key});

  @override
  State<ItDeduction> createState() => _ItDeductionState();
}

class _ItDeductionState extends State<ItDeduction> {
  final taxController = Get.find<TaxDeductionService>();
  final scrollControllerVertical = ScrollController();
  final scrollControllerHorizontal = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: taxController.itTaxModule.data == null ||
              taxController.itTaxModule.data!.isEmpty
          ? Center(child: Text('No data found'))
          : RawScrollbar(
              thumbColor: Theme.of(context).colorScheme.secondary,
              thumbVisibility: true,
              radius: Radius.circular(10),
              controller: scrollControllerVertical,
              child: SingleChildScrollView(
                controller: scrollControllerVertical,
                scrollDirection: Axis.vertical,
                child: RawScrollbar(
                  thumbColor: Theme.of(context).colorScheme.secondary,
                  thumbVisibility: true,
                  radius: Radius.circular(10),
                  controller: scrollControllerHorizontal,
                  child: SingleChildScrollView(
                    controller: scrollControllerHorizontal,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      decoration: BoxDecoration(border: Border.all()),
                      columns: [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: InkWell(child: Text('Order ID'))),
                        DataColumn(label: Text('Tax Rule')),
                        DataColumn(label: Text('Order Value')),
                        DataColumn(label: Text('Invoices')),
                        DataColumn(label: Text('Credits')),
                        DataColumn(label: Text('Net Value')),
                        DataColumn(label: Text('Percentage')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Seller Pan')),
                      ],
                      rows: List.generate(
                        taxController.itTaxModule.data!.length,
                        (index) {
                          return DataRow(cells: [
                            DataCell(Text(DateFormat('dd MMM yyyy').format(
                                taxController
                                    .itTaxModule.data![index].createdAt!
                                    .toLocal()))),
                            DataCell(InkWell(
                                onTap: () {
                                  Get.to(ViewOrderPage(
                                      orderId: taxController
                                          .itTaxModule.data![index].orderId!));
                                },
                                child: Text(
                                    taxController.itTaxModule.data![index]
                                        .orderReferenceId!,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)))),
                            DataCell(Text(taxController
                                .itTaxModule.data![index].taxRule!)),
                            DataCell(Text(taxController
                                .itTaxModule.data![index].orderValue!)),
                            DataCell(Text(taxController
                                .itTaxModule.data![index].invoices!
                                .join(', '))),
                            DataCell(Text(taxController.itTaxModule.data![index]
                                        .credits?.isEmpty ??
                                    true
                                ? '0'
                                : taxController
                                    .itTaxModule.data![index].credits!
                                    .join(', '))),
                            DataCell(Text(taxController
                                .itTaxModule.data![index].netValue!)),
                            DataCell(Text(taxController
                                .itTaxModule.data![index].percentage!)),
                            DataCell(Text(taxController
                                .itTaxModule.data![index].amount!)),
                            DataCell(Text(taxController
                                .itTaxModule.data![index].sellerPan!)),
                          ]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
