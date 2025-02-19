import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Controller/QuoteQuotation_Service.dart';

class QuoteInvoiceButton extends StatefulWidget {
  const QuoteInvoiceButton({super.key});

  @override
  State<QuoteInvoiceButton> createState() => _QuoteInvoiceButtonState();
}

class _QuoteInvoiceButtonState extends State<QuoteInvoiceButton> {
  final quoteQuotationService = Get.find<QuoteQuotationService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuoteQuotationService>(
      builder: (_) => MaterialButton(
        onPressed: () {},
        color: Theme.of(context).colorScheme.secondary,
        child: Text('Download Invoice'),
      ),
    );
  }
}
