import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../Controller/QuoteQuotation_Service.dart';

class DeliveryCharges extends StatefulWidget {
  const DeliveryCharges({super.key});

  @override
  State<DeliveryCharges> createState() => _DeliveryChargesState();
}

class _DeliveryChargesState extends State<DeliveryCharges> {
  final quoteQuotationService = Get.find<QuoteQuotationService>();
  late bool selectedDeliverType;

  @override
  void initState() {
    selectedDeliverType = quoteQuotationService
        .quoteQuotationModule.data!.deliveryCharges!.isEmpty;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    );
    return GetBuilder<QuoteQuotationService>(
      builder: (_) {
        if (quoteQuotationService.preview) {
          selectedDeliverType = quoteQuotationService
              .quoteQuotationModule.data!.deliveryCharges!.isEmpty;
        }
        return Column(
          children: [
            RadioListTile<bool>(
              value: true,
              groupValue: selectedDeliverType,
              onChanged: quoteQuotationService.preview
                  ? (value) {}
                  : (value) async {
                      selectedDeliverType = value!;

                      quoteQuotationService.update();
                      await quoteQuotationService
                          .updateQuote({'deliveryCharges': []});
                    },
              title: Text('Free Delivery',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            RadioListTile<bool>(
              value: false,
              groupValue: selectedDeliverType,
              onChanged: quoteQuotationService.preview
                  ? (value) {}
                  : (value) {
                      selectedDeliverType = value!;
                      quoteQuotationService.update();
                    },
              title: Text('Enter Delivery Charge',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            selectedDeliverType == false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      quoteQuotationService.preview
                          ? SizedBox()
                          : quoteQuotationService.deliveryCharge.data!.length !=
                                  quoteQuotationService.quoteQuotationModule
                                      .data!.deliveryCharges!.length
                              ? MaterialButton(
                                  onPressed: () {
                                    TextEditingController deliverCharge =
                                        TextEditingController();
                                    String? selectItem;
                                    List pendingDeliveryCharges = [];
                                    for (var deliveryCharge
                                        in quoteQuotationService
                                            .deliveryCharge.data!) {
                                      bool isPresent = quoteQuotationService
                                          .quoteQuotationModule
                                          .data!
                                          .deliveryCharges!
                                          .any((existingCharge) =>
                                              existingCharge.type ==
                                              deliveryCharge.type);

                                      if (!isPresent) {
                                        pendingDeliveryCharges
                                            .add(deliveryCharge);
                                      }
                                    }
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return GetBuilder<
                                            QuoteQuotationService>(
                                          builder: (_) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(),
                                              title:
                                                  Text('Add Delivery Charges'),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    DropdownButton(
                                                      isExpanded: true,
                                                      hint: Text(
                                                        'Select Delivery Type',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                      items:
                                                          pendingDeliveryCharges
                                                              .map((charge) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: charge.type,
                                                          child:
                                                              Text(charge.name),
                                                        );
                                                      }).toList(),
                                                      value: selectItem,
                                                      onChanged: (value) {
                                                        selectItem = value;
                                                        quoteQuotationService
                                                            .update();
                                                      },
                                                    ),
                                                    TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      controller: deliverCharge,
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'^\d*\.?\d*$')),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        12),
                                                        focusedBorder:
                                                            outlineBorder,
                                                        enabledBorder:
                                                            outlineBorder,
                                                        focusedErrorBorder:
                                                            outlineBorder,
                                                        errorBorder:
                                                            outlineBorder,
                                                      ),
                                                      onTapOutside:
                                                          (event) async {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                      },
                                                    ),
                                                    MaterialButton(
                                                      onPressed: () async {
                                                        await quoteQuotationService
                                                            .addQuote({
                                                          'type': selectItem,
                                                          'charge':
                                                              double.parse(
                                                                  deliverCharge
                                                                      .text)
                                                        }, addURL: '/delivery-charges');

                                                        Get.back();
                                                      },
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      child: Text(
                                                        'Add',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Text(
                                    'Add Delivery Charge',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                )
                              : SizedBox(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            (quoteQuotationService
                                    .quoteQuotationModule.data!.deliveryCharges!
                                  ..sort(
                                    (a, b) => a.id!.compareTo(b.id!),
                                  ))
                                .length,
                            (index) {
                              final deliveryCharge = quoteQuotationService
                                  .quoteQuotationModule
                                  .data!
                                  .deliveryCharges![index];
                              final deliverType = quoteQuotationService
                                  .deliveryCharge.data!
                                  .firstWhere((element) =>
                                      element.type == deliveryCharge.type);
                              TextEditingController controller =
                                  TextEditingController();
                              controller.text = deliveryCharge.charge!;

                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: quoteQuotationService.preview
                                    ? Row(
                                        children: [
                                          Expanded(
                                              child: Text(deliverType.name!,
                                                  textAlign: TextAlign.start)),
                                          Expanded(
                                              child:
                                                  Text('Rs.${controller.text}'))
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            deliverType.name!,
                                            textAlign: TextAlign.start,
                                          ),
                                          quoteQuotationService.preview
                                              ? SizedBox()
                                              : Row(
                                                  spacing: 10,
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        controller: controller,
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'^\d*\.?\d*$')),
                                                        ],
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          12),
                                                          focusedBorder:
                                                              outlineBorder,
                                                          enabledBorder:
                                                              outlineBorder,
                                                          focusedErrorBorder:
                                                              outlineBorder,
                                                          errorBorder:
                                                              outlineBorder,
                                                        ),
                                                        onEditingComplete:
                                                            () async {
                                                          await quoteQuotationService
                                                              .updateQuote({
                                                            'charge':
                                                                double.parse(
                                                                    controller
                                                                        .text),
                                                            'type':
                                                                deliveryCharge
                                                                    .type
                                                          }, addURL: '/delivery-charges/${deliveryCharge.id}');
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                        },
                                                        onTapOutside:
                                                            (event) async {},
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                      child: Icon(
                                                          FontAwesomeIcons
                                                              .trash,
                                                          color: Colors.white),
                                                      onPressed: () async {
                                                        await quoteQuotationService
                                                            .deleteQuote(
                                                                addURL:
                                                                    '/delivery-charges/${deliveryCharge.id}');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        );
      },
    );
  }
}
