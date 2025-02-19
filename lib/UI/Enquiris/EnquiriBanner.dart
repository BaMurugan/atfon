import 'dart:async';

import 'package:autofon_seller/Controller/Home_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Module/Enquirie_Module.dart';
import '../../../Controller/Enquiri_Service.dart';
import '../Quote Quotation/QuoteQuotationPage.dart';

class EnquiriBanner extends StatefulWidget {
  QuoteEnquiry quote;
  EnquiriBanner({super.key, required this.quote});

  @override
  State<EnquiriBanner> createState() => _EnquiriBannerState();
}

class _EnquiriBannerState extends State<EnquiriBanner> {
  String time = "";
  Timer? _timer;

  final enquiriServiceController = Get.find<EnquiriService>();
  final homeService = Get.find<HomeService>();

  @override
  void initState() {
    super.initState();
    time = _formatTimeDifference(widget.quote.validUntil!);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final newTime = _formatTimeDifference(widget.quote.validUntil!);
      if (time != newTime) {
        setState(() {
          time = newTime;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuoteEnquiry quote = widget.quote;
    ThemeData color = Theme.of(context);
    bool hasEvent =
        (quote.status == "Open" && quote.quoteRequestStatus != 'Closed');
    final screen = MediaQuery.of(context).size;

    productList() {
      List<Widget> entity = [];
      for (int i = 0; i < quote.quoteEnquiryItems!.length; i++) {
        double quantity =
            double.tryParse(quote.quoteEnquiryItems![i].units ?? '0.00') ?? 0.0;
        String formattedQuantity = quantity == quantity.toInt()
            ? quantity.toInt().toString()
            : quantity.toStringAsFixed(8).replaceAll(RegExp(r"([.]*0+)$"), "");

        entity.add(Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: screen.width,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Image.network(
                    quote.quoteEnquiryItems![i].imageUrl!,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    productDialogList(
                        "Name", quote.quoteEnquiryItems![i].name!),
                    const SizedBox(height: 10),
                    productDialogList("Manufacturer",
                        quote.quoteEnquiryItems![i].manufacturerName!),
                    const SizedBox(height: 10),
                    productDialogList("Quantity",
                        "$formattedQuantity ${quote.quoteEnquiryItems![i].uom}"),
                  ],
                ),
              ),
            ],
          ),
        ));
      }
      showModalBottomSheet(
        shape: RoundedRectangleBorder(),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: screen.height * 0.6,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: entity,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return GestureDetector(
      onTap: hasEvent
          ? () {
              productList();
            }
          : () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: hasEvent ? color.primaryColor : color.colorScheme.tertiary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildInfoText(
                "Received Date",
                DateFormat('dd MMM yyyy')
                    .format(DateTime.parse("${quote.createdAt}")),
                context),
            buildInfoText("No of Products",
                "${quote.quoteEnquiryItems!.length}", context),
            buildInfoText(
                "Delivery Pincode",
                "${quote.deliveryPincode ?? quote.selfPickupPincode} ${quote.distance != null && quote.distance != '0.00' ? '( ${quote.distance} Km )' : ""}",
                context),
            hasEvent
                ? buildInfoText("Valid Until", time, context)
                : buildInfoText(
                    "Validity",
                    DateFormat('dd MMM yyyy')
                        .format(quote.validUntil!.toLocal()),
                    context),
            buildInfoText(
                "Enquiry Type",
                quote.previousQuoteId == null ? 'New' : 'Re-Requested',
                context),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Expected Delivery",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    expectedData(
                        'Date',
                        DateFormat('dd MMM yyyy').format(quote
                            .deliveryPreference!.expectedDeliveryDate!
                            .toLocal())),
                    expectedData('Time',
                        quote.deliveryPreference!.expectedDeliveryTime!),
                  ],
                ),
              ],
            ),
            quote.selfPickup!
                ? Text("Self Pickup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary))
                : SizedBox(),
            MaterialButton(
              color: color.colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: hasEvent
                  ? () async {
                      final id = await enquiriServiceController.createQuote(
                          quoteId: quote.id!);
                      Get.to(QuoteQuotationPage(quotationId: id));
                      enquiriServiceController.getData();
                      setState(() {});
                    }
                  : () {},
              child: Text(
                "Accept",
                style: TextStyle(
                  fontSize: 20,
                  color: color.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoText(String key, dynamic value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              key,
            ),
          ),
          Expanded(
            child: Text(
              "$value",
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeDifference(DateTime validUntil) {
    final now = DateTime.now();
    final difference = validUntil.difference(now);

    if (difference.isNegative) {
      _timer?.cancel();
      enquiriServiceController.getData();
      return '';
    }

    return [
      if (difference.inDays > 0) '${difference.inDays}d' else '0d',
      if (difference.inHours % 24 > 0) '${difference.inHours % 24}h' else '0h',
      if (difference.inMinutes % 60 > 0)
        '${difference.inMinutes % 60}m'
      else
        '0m',
      '${difference.inSeconds % 60}s',
    ].join(' ');
  }

  productDialogList(String key, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("$key : "),
        Text(value),
      ],
    );
  }

  expectedData(String key, String value) {
    return Column(
      children: [
        Text(
          key,
        ),
        Text(value)
      ],
    );
  }
}
