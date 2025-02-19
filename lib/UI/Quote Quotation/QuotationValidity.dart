import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/QuoteQuotation_Service.dart';

class QuotationValidity extends StatefulWidget {
  const QuotationValidity({super.key});

  @override
  State<QuotationValidity> createState() => _QuotationValidityState();
}

class _QuotationValidityState extends State<QuotationValidity> {
  final quoteQuotationService = Get.find<QuoteQuotationService>();

  String time = "Loading...";
  Timer? timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          validUntil();
        });
      } else {
        timer.cancel();
      }
    });
  }

  validUntil() {
    final validtime =
        quoteQuotationService.quoteQuotationModule.data!.validUntil!.toLocal();
    final currentTime = DateTime.now();
    final difference = validtime.difference(currentTime);

    if (difference.isNegative) {
      timer?.cancel();
      time = 'Expired';
    } else if (difference.inHours > 0) {
      time = '${difference.inHours} Hours left';
    } else if (difference.inMinutes > 0) {
      time = '${difference.inMinutes} Minutes left';
    } else {
      time = '${difference.inSeconds} Seconds left';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuoteQuotationService>(
      builder: (controller) {
        if (quoteQuotationService.preview == true) {
          startTimer();
        }
        return Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quotation Validity Period'),
            quoteQuotationService.preview
                ? Text(time,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w900,
                    ))
                : DropdownButtonFormField<String>(
                    value: quoteQuotationService.selectedQuotation,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    hint: const Text(
                      "Quotation Validity Period",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    icon: const Icon(Icons.arrow_drop_down, size: 24),
                    isExpanded: true,
                    items: quoteQuotationService.preview
                        ? (quoteQuotationService.selectedQuotation != null
                            ? [
                                DropdownMenuItem(
                                  value:
                                      quoteQuotationService.selectedQuotation,
                                  child: Text(
                                    quoteQuotationService.selectedQuotation!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ]
                            : []) // Handle null `selected` gracefully
                        : [
                            "1Hr",
                            "3Hrs",
                            "6Hrs",
                            "9Hrs",
                            "12Hrs",
                            "18Hrs",
                            "1Day",
                            "2Day",
                            "3Day",
                            "4Day",
                            "5Day",
                          ]
                            .map((label) => DropdownMenuItem(
                                  value: label,
                                  child: Text(
                                    label,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ))
                            .toList(),
                    onChanged: quoteQuotationService.preview
                        ? null // Disable `onChanged` when in preview mode
                        : (value) {
                            setState(
                              () {
                                quoteQuotationService.selectedQuotation = value;
                                DateTime validUntil;
                                DateTime now = DateTime.now().toUtc();
                                switch (value) {
                                  case "1Hr":
                                    validUntil = now.add(Duration(hours: 1));
                                    break;
                                  case "3Hrs":
                                    validUntil = now.add(Duration(hours: 3));
                                    break;
                                  case "6Hrs":
                                    validUntil = now.add(Duration(hours: 6));
                                    break;
                                  case "9Hrs":
                                    validUntil = now.add(Duration(hours: 9));
                                    break;
                                  case "12Hrs":
                                    validUntil = now.add(Duration(hours: 12));
                                    break;
                                  case "18Hrs":
                                    validUntil = now.add(Duration(hours: 18));
                                    break;
                                  case "1Day":
                                    validUntil = now.add(Duration(days: 1));
                                    break;
                                  case "2Day":
                                    validUntil = now.add(Duration(days: 2));
                                    break;
                                  case "3Day":
                                    validUntil = now.add(Duration(days: 3));
                                    break;
                                  case "4Day":
                                    validUntil = now.add(Duration(days: 4));
                                    break;
                                  case "5Day":
                                    validUntil = now.add(Duration(days: 5));
                                    break;
                                  default:
                                    validUntil = now;
                                }
                                quoteQuotationService.updateQuote(
                                  {
                                    "validUntil": "$validUntil",
                                  },
                                );
                              },
                            );
                          },
                  ),
          ],
        );
      },
    );
  }
}
