import 'package:autofon_seller/Controller/Home_Service.dart';
import 'package:autofon_seller/Module/Invoice_Module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Controller/Orders_Service.dart';

class ShipmentInvoice extends StatefulWidget {
  String shipment;
  ShipmentInvoice({super.key, required this.shipment});

  @override
  State<ShipmentInvoice> createState() => _ShipmentInvoiceState();
}

class _ShipmentInvoiceState extends State<ShipmentInvoice> {
  final shipmentInvoice = Get.find<OrderService>();
  final homeService = Get.find<HomeService>();
  late InvoiceModule invoiceModule;
  bool isLoading = true;
  dynamic data;

  @override
  void initState() {
    instilize();
    super.initState();
  }

  instilize() async {
    invoiceModule = await shipmentInvoice.getInvoice(widget.shipment);
    isLoading = false;
    data = invoiceModule.data;
    setState(() {});
  }

  invoiceButton({required String? data, required String name}) {
    return data != null && data != ""
        ? MaterialButton(
            onPressed: () {
              launchUrl(Uri.parse(data),
                  mode: LaunchMode.externalNonBrowserApplication);
            },
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Text('Loading ...', textAlign: TextAlign.center)
          : Column(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (homeService.user.data?.sellerType == 'SB')
                  invoiceButton(
                      data: data.creditNoteInvoiceFileUrl, name: "Credit Note"),
                invoiceButton(
                    data: data.serviceBillFileUrl, name: "Service Bill"),
                invoiceButton(
                    data: data.transitInvoiceFileUrl, name: "Transit Invoice"),
                invoiceButton(
                    data: data.sbFinalInvoiceFileUrl, name: "Final Invoice"),
                invoiceButton(
                    data: data.debitNoteInvoiceFileUrl, name: 'Debit Note C'),
                invoiceButton(
                    data: data.disputeDebitNoteInvoiceFileUrl,
                    name: "Debit Note D"),
              ],
            ),
    );
  }
}
