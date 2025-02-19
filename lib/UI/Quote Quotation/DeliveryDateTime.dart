import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Controller/QuoteQuotation_Service.dart';

class DeliveryDateTime extends StatefulWidget {
  const DeliveryDateTime({super.key});

  @override
  State<DeliveryDateTime> createState() => _DeliveryDateTimeState();
}

class _DeliveryDateTimeState extends State<DeliveryDateTime> {
  final quoteQuotationService = Get.find<QuoteQuotationService>();

  @override
  Widget build(BuildContext context) {
    final quoteData = quoteQuotationService.quoteQuotationModule.data;
    final deliveryPreference = quoteData?.quoteRequest?.deliveryPreference;

    return GetBuilder<QuoteQuotationService>(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioListTile<String>(
            value: 'buyer',
            title: Text(
              'Buyer Expected Delivery Date & Time',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            groupValue: quoteQuotationService.selectedOption,
            onChanged: quoteQuotationService.preview
                ? null
                : (value) {
                    if (value != null) {
                      print(value.runtimeType);
                      setState(() {
                        quoteQuotationService.selectedOption = value;
                      });
                    }
                  },
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
            ),
            child: Text(
              '${DateFormat('dd/MM/yyyy').format(deliveryPreference!.expectedDeliveryDate!.toLocal())} (${deliveryPreference.expectedDeliveryTime})',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          RadioListTile<String>(
            value: 'seller',
            groupValue: quoteQuotationService.selectedOption,
            title: Text('Seller Expected Delivery Date & Time',
                style: Theme.of(context).textTheme.bodySmall),
            onChanged: quoteQuotationService.preview
                ? null
                : (value) {
                    if (value != null) {
                      quoteQuotationService.selectedOption = value;
                      quoteQuotationService.update();
                    }
                  },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: quoteQuotationService.preview
                    ? () {}
                    : () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 36500)),
                        );
                        if (date != null) {
                          quoteQuotationService.selectedDate = date;

                          await quoteQuotationService.updateQuote({
                            'deliveryPreference': {
                              'sellerExpectedDeliveryDate':
                                  quoteQuotationService.selectedDate!
                                      .toUtc()
                                      .toIso8601String()
                            }
                          });
                          quoteQuotationService.update();
                        }
                      },
                child: Text(
                  quoteQuotationService.selectedDate == null
                      ? 'Select Date'
                      : DateFormat('dd/MM/yyyy')
                          .format(quoteQuotationService.selectedDate!),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                style: Theme.of(context).textTheme.bodySmall,
                value: quoteQuotationService.selectedTimeSlot,
                hint: Text(
                  'Select Time Slot',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                items: quoteQuotationService.preview
                    ? [
                        if (quoteQuotationService.selectedTimeSlot != null)
                          DropdownMenuItem(
                              value: quoteQuotationService.selectedTimeSlot,
                              child:
                                  Text(quoteQuotationService.selectedTimeSlot!))
                      ]
                    : [
                        "6 AM - 9 AM",
                        "9 AM - 12 PM",
                        "12 PM - 3 PM",
                        "3 PM - 6 PM",
                        "6 PM - 9 PM",
                        "9 PM - 12 AM",
                        "12 AM - 3 AM",
                        "3 AM - 6 AM",
                      ]
                        .map((label) =>
                            DropdownMenuItem(value: label, child: Text(label)))
                        .toList(),
                onChanged: quoteQuotationService.preview
                    ? (value) {}
                    : (value) async {
                        quoteQuotationService.selectedTimeSlot = value;
                        quoteQuotationService.update();
                        await quoteQuotationService.updateQuote({
                          'deliveryPreference': {
                            'sellerExpectedDeliveryTime':
                                quoteQuotationService.selectedTimeSlot
                          }
                        });
                      },
              ),
            ],
          )
        ],
      ),
    );
  }
}
