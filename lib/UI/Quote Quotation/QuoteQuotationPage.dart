import 'package:autofon_seller/Other%20Service/ApiPath.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Controller/QuoteQuotation_Service.dart';
import 'CommissionNoteButton.dart';
import 'DeliveryCharge.dart';
import 'DeliveryDateTime.dart';
import 'PriviousQuoteHistory.dart';
import 'QuotationValidity.dart';
import 'QuoteProductsList.dart';

class QuoteQuotationPage extends StatefulWidget {
  String quotationId;
  QuoteQuotationPage({super.key, required this.quotationId});

  @override
  State<QuoteQuotationPage> createState() => _QuoteQuotationPageState();
}

class _QuoteQuotationPageState extends State<QuoteQuotationPage> {
  final quoteQuotationService = Get.put(QuoteQuotationService());
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: quoteQuotationService.instilize(widget.quotationId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return GetBuilder<QuoteQuotationService>(builder: (_) {
              final quoteData = quoteQuotationService.quoteQuotationModule.data;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quotation',
                          style: Theme.of(context).textTheme.bodyLarge),
                      if (quoteData!.distance != '0.00')
                        Text(
                            'Other Charges: ${quoteData.quoteRequest!.deliveryAddress!.pincode!}/ Approx ${quoteData.distance} Km'),
                      Form(
                        key: formKey,
                        child: Column(
                          spacing: 5,
                          children: List.generate(
                            (quoteData.quoteLineItems!
                                  ..sort((a, b) => a.id!.compareTo(b.id!)))
                                .length,
                            (index) {
                              return QuoteProductsList(
                                quoteData: quoteData.quoteLineItems![index],
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: quoteData.isUnloadPartyScope,
                            onChanged: quoteQuotationService.preview
                                ? (value) {}
                                : (value) {
                                    quoteData.isUnloadPartyScope =
                                        !quoteData.isUnloadPartyScope!;
                                    quoteQuotationService.updateQuote({
                                      'isUnloadPartyScope':
                                          quoteData.isUnloadPartyScope
                                    });
                                    quoteQuotationService.update();
                                  },
                          ),
                          Text('Is Unload Party Scope')
                        ],
                      ),
                      if (quoteQuotationService.quoteQuotationModule.data!
                              .previousQuotes!.isNotEmpty &&
                          quoteQuotationService.preview != true)
                        Text('History'),
                      if (quoteQuotationService.quoteQuotationModule.data!
                              .previousQuotes!.isNotEmpty &&
                          quoteQuotationService.preview != true)
                        ...List.generate(
                          quoteQuotationService.quoteQuotationModule.data!
                              .previousQuotes!.length,
                          (index) {
                            final itemData = quoteQuotationService
                                .quoteQuotationModule
                                .data!
                                .previousQuotes![index];
                            return PriviousQuoteHistory(
                              itemData: itemData,
                            );
                          },
                        ),
                      QuotationValidity(),
                      DeliveryDateTime(),
                      DeliveryCharges(),
                      Column(
                        spacing: 3,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          lineItem('No of Items:',
                              '${quoteData.quoteLineItems!.length}'),
                          lineItem('Total Commission',
                              'Rs. ${(double.parse(quoteData.totalCommission!) + double.parse(quoteData.totalDeliveryChargesCommission!)).toStringAsFixed(2)}'),
                          lineItem('Total Tax', 'Rs. ${quoteData.totalTax}'),
                          lineItem(
                              'Total Amount', 'Rs. ${quoteData.totalPrice}'),
                          CommissionNoteButton()
                        ],
                      ),
                      quoteQuotationService.show
                          ? quoteQuotationService.preview == false
                              ? MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      bool continueStep = quoteData
                                          .quoteLineItems!
                                          .any((item) => !item.excluded!);
                                      final hasZeroCharge = quoteData
                                          .deliveryCharges!
                                          .firstWhereOrNull((item) =>
                                              double.parse(item.charge!) <= 0);

                                      if (hasZeroCharge != null) {
                                        Get.snackbar('Error',
                                            'Delivery Charge must be greater than Zero');
                                        return;
                                      }

                                      if (quoteQuotationService
                                              .selectedOption ==
                                          'buyer') {
                                        quoteQuotationService.updateQuote({
                                          'deliveryPreference': {
                                            'sellerExpectedDeliveryDate': null,
                                            'sellerExpectedDeliveryTime': null
                                          }
                                        });
                                      }
                                      if (quoteQuotationService
                                              .selectedOption ==
                                          'seller') {
                                        if (quoteQuotationService
                                                .selectedDate ==
                                            null) {
                                          Get.snackbar('Error',
                                              'Select Seller Expected Delivery Date');
                                          return;
                                        }
                                        if (quoteQuotationService
                                                .selectedTimeSlot ==
                                            null) {
                                          Get.snackbar('Error',
                                              'Select Seller Expected Delivery Time');
                                          return;
                                        }
                                      }
                                      if (continueStep == false) {
                                        Get.snackbar('Error',
                                            'Please Select any one Quotation Order Item');
                                        return;
                                      }
                                      if (quoteQuotationService
                                              .selectedQuotation ==
                                          null) {
                                        Get.snackbar('Error',
                                            'Please Select Quotation Validity Period');
                                        return;
                                      }
                                      quoteQuotationService.preview = true;
                                    }

                                    quoteQuotationService.update();
                                  },
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Text('Preview',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                )
                              : Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () {
                                          quoteQuotationService.preview = false;
                                          quoteQuotationService.update();
                                        },
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        child: Text('Cancel',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ),
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () async {
                                          await quoteQuotationService.addQuote(
                                              {},
                                              addURL: ApiPaths.sellerSubmit);
                                          Get.back();
                                        },
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        child: Text('Submit',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ),
                                    ),
                                  ],
                                )
                          : SizedBox(),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  lineItem(String title, String value) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        Expanded(child: Text(value)),
      ],
    );
  }
}
