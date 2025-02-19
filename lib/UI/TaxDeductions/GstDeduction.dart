import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/TaxDeduction_Service.dart';
import '../Orders/ViewOrder/ViewOrderPage.dart';

class GstDeduction extends StatefulWidget {
  const GstDeduction({super.key});

  @override
  State<GstDeduction> createState() => _GstDeductionState();
}

class _GstDeductionState extends State<GstDeduction> {
  final taxController = Get.find<TaxDeductionService>();
  final scrollControllerVertical = ScrollController();
  final scrollControllerHorizontal = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: taxController.gstTaxModule.data == null ||
              taxController.gstTaxModule.data!.isEmpty
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
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      decoration: BoxDecoration(border: Border.all()),
                      columns: [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Order ID')),
                        DataColumn(label: Text('Tax Rule')),
                        DataColumn(label: Text('Order Value')),
                        DataColumn(label: Text('Invoices')),
                        DataColumn(label: Text('Credits')),
                        DataColumn(label: Text('Net Value')),
                        DataColumn(label: Text('Percentage')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Seller GST')),
                      ],
                      rows: List.generate(
                        taxController.gstTaxModule.data!.length,
                        (index) {
                          return DataRow(cells: [
                            DataCell(Text(DateFormat('dd MMM yyyy').format(
                                taxController
                                    .gstTaxModule.data![index].createdAt!
                                    .toLocal()))),
                            DataCell(InkWell(
                                onTap: () {
                                  Get.to(ViewOrderPage(
                                      orderId: taxController
                                          .gstTaxModule.data![index].orderId!));
                                },
                                child: Text(
                                  taxController.gstTaxModule.data![index]
                                      .orderReferenceId!,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ))),
                            DataCell(Text(taxController
                                .gstTaxModule.data![index].taxRule!)),
                            DataCell(Text(taxController
                                .gstTaxModule.data![index].orderValue!)),
                            DataCell(Text(taxController
                                .gstTaxModule.data![index].invoices!
                                .join(', '))),
                            DataCell(Text(taxController.gstTaxModule
                                        .data![index].credits?.isEmpty ??
                                    true
                                ? '0'
                                : taxController
                                    .gstTaxModule.data![index].credits!
                                    .join(', '))),
                            DataCell(Text(taxController
                                .gstTaxModule.data![index].netValue!)),
                            DataCell(Text(taxController
                                .gstTaxModule.data![index].percentage!)),
                            DataCell(Text(taxController
                                .gstTaxModule.data![index].amount!)),
                            DataCell(Text(taxController
                                .gstTaxModule.data![index].sellerGst!)),
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
