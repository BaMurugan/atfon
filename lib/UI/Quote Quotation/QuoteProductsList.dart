import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Controller/Home_Service.dart';
import '../../../Controller/QuoteQuotation_Service.dart';

class QuoteProductsList extends StatefulWidget {
  dynamic quoteData;
  QuoteProductsList({super.key, required this.quoteData});

  @override
  State<QuoteProductsList> createState() => _QuoteProductsListState();
}

class _QuoteProductsListState extends State<QuoteProductsList> {
  final quoteQuotationService = Get.find<QuoteQuotationService>();
  final homeService = Get.find<HomeService>();
  final FocusNode _focusNode = FocusNode();
  bool isFirst = true;
  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 2.0),
    borderRadius: BorderRadius.circular(8.0),
  );
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textEditingController.text = widget.quoteData.itemPrice.toString();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        textEditingController.clear();
      } else if (!_focusNode.hasFocus && textEditingController.text.isEmpty) {
        textEditingController.text = widget.quoteData.itemPrice.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuoteQuotationService>(
      builder: (_) {
        final quoteData = widget.quoteData;
        if (isFirst) {
          textEditingController.text = quoteData.itemPrice.toString();
          isFirst = false;
        }

        double quantity = double.tryParse(quoteData?.units ?? '0.00') ?? 0.0;
        String formattedQuantity = quantity == quantity.toInt()
            ? quantity.toInt().toString()
            : quantity.toStringAsFixed(8).replaceAll(RegExp(r"([.]*0+)$"), "");

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(width: 2.4),
              borderRadius: BorderRadius.circular(5),
              color: (quoteData.serviceableMinMaxQuantityExceeded ||
                      (quoteData.isSellerProduct == false))
                  ? Theme.of(context).colorScheme.tertiary
                  : null),
          child: (quoteData.serviceableMinMaxQuantityExceeded ||
                  (quoteData.isSellerProduct == false))
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  color: Theme.of(context).colorScheme.tertiary,
                  child: Text(
                    '${(quoteData.isSellerProduct == false) ? 'Not available in your Product List' : ''} ${quoteData.serviceableMinMaxQuantityExceeded ? 'Min Max Limit Exceeded' : ''} ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ))
              : quoteData.excluded
                  ? Container(
                      color: Theme.of(context).colorScheme.tertiary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Excluded from quote'),
                          Checkbox(
                            value:
                                (quoteData.serviceableMinMaxQuantityExceeded ||
                                        (quoteData.isSellerProduct == false))
                                    ? false
                                    : !quoteData.excluded,
                            onChanged: quoteQuotationService.preview ||
                                    (quoteData
                                            .serviceableMinMaxQuantityExceeded ||
                                        (quoteData.isSellerProduct == false))
                                ? (value) {}
                                : (value) async {
                                    quoteData.excluded = !quoteData.excluded;
                                    quoteQuotationService.update();
                                    await quoteQuotationService.updateQuoteItem(
                                        body: {
                                          'excluded': quoteData.excluded,
                                          'itemPrice': 0
                                        },
                                        id: quoteData.id);
                                  },
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Image(
                              image: NetworkImage(
                                quoteData.imageUrl!,
                              ),
                              height: 100,
                              width: 100,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    quoteData.name!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                      'Quantity $formattedQuantity ${quoteData.uom}'),
                                  if (quoteData.uomValue != '' &&
                                      quoteData.alternateUomValue != '' &&
                                      quoteQuotationService.preview == false)
                                    MaterialButton(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      child: Text('Change UOM',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      onPressed: () {
                                        showChangerUOMDialog();
                                      },
                                    ),
                                ],
                              ),
                            ),
                            if (!quoteQuotationService.preview)
                              Checkbox(
                                value: (quoteData
                                            .serviceableMinMaxQuantityExceeded ||
                                        (quoteData.isSellerProduct == false))
                                    ? false
                                    : !quoteData.excluded,
                                onChanged: quoteQuotationService.preview ||
                                        (quoteData
                                                .serviceableMinMaxQuantityExceeded ||
                                            (quoteData.isSellerProduct ==
                                                false))
                                    ? (value) {}
                                    : (value) async {
                                        quoteData.excluded =
                                            !quoteData.excluded;
                                        quoteQuotationService.update();
                                        await quoteQuotationService
                                            .updateQuoteItem(body: {
                                          'excluded': quoteData.excluded,
                                          'itemPrice': 0
                                        }, id: quoteData.id);
                                      },
                              ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: columnItems(
                              name: 'Item Price',
                              widget: Column(
                                children: [
                                  quoteQuotationService.preview
                                      ? Text('Rs.${textEditingController.text}')
                                      : TextFormField(
                                          style: TextStyle(fontSize: 14),
                                          controller: textEditingController,
                                          focusNode: _focusNode,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'^\d*\.?\d*$')),
                                          ],
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 12),
                                            focusedBorder: outlineBorder,
                                            enabledBorder: outlineBorder,
                                            focusedErrorBorder: outlineBorder,
                                            errorBorder: outlineBorder,
                                          ),
                                          validator: (value) {
                                            if (double.parse(quoteData.itemPrice
                                                        .trim()) <=
                                                    0 &&
                                                widget.quoteData.excluded ==
                                                    false) {
                                              return 'Enter the Price';
                                            }
                                            return null;
                                          },
                                          onEditingComplete: () async {
                                            await quoteQuotationService
                                                .updateQuoteItem(
                                              body: {
                                                'excluded': false,
                                                'itemPrice': double.parse(
                                                    textEditingController.text)
                                              },
                                              id: quoteData.id,
                                            );
                                            FocusScope.of(context).unfocus();
                                          },
                                          onTapOutside: (event) async {
                                            await quoteQuotationService
                                                .updateQuoteItem(
                                              body: {
                                                'excluded': false,
                                                'itemPrice': double.parse(
                                                    textEditingController.text)
                                              },
                                              id: quoteData.id,
                                            );
                                            FocusScope.of(context).unfocus();
                                          },
                                        ),
                                  Text('(inclusive of GST)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            )),
                            Expanded(
                                child: columnItems(
                                    name: 'GST Rate',
                                    widget: Text(quoteData.gstRate != null
                                        ? '${quoteData.gstRate}%'
                                        : 'NIL'))),
                            Expanded(
                                child: columnItems(
                                    name: 'GST Amt',
                                    widget: Text('${quoteData.taxAmount}'))),
                            Expanded(
                                child: columnItems(
                                    name: 'Total Price',
                                    widget: Text(quoteData.itemTotalPrice))),
                          ],
                        ),
                        if (quoteQuotationService.quoteQuotationModule.data!
                                .previousQuotes!.isNotEmpty &&
                            quoteQuotationService.quoteQuotationModule.data!
                                    .previousQuotes![0].quoteLineItems!
                                    .indexWhere((e) =>
                                        e.productId == quoteData.productId) !=
                                -1 &&
                            quoteQuotationService.preview != true)
                          MaterialButton(
                            onPressed: () async {
                              final index = quoteQuotationService
                                  .quoteQuotationModule
                                  .data!
                                  .previousQuotes![0]
                                  .quoteLineItems!
                                  .indexWhere((e) =>
                                      e.productId == quoteData.productId);

                              if (index != -1) {
                                final lastQuotePrice = double.tryParse(
                                        quoteQuotationService
                                                .quoteQuotationModule
                                                .data!
                                                .previousQuotes![0]
                                                .quoteLineItems![index]
                                                .itemPrice ??
                                            '0') ??
                                    0.0;

                                textEditingController.text =
                                    lastQuotePrice.toStringAsFixed(2);

                                await quoteQuotationService.updateQuoteItem(
                                  body: {
                                    'excluded': false,
                                    'itemPrice': lastQuotePrice,
                                  },
                                  id: quoteData.id,
                                );
                              }
                            },
                            color: Theme.of(context).colorScheme.secondary,
                            child: Text(
                              'Use Last Quote Value',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          )
                      ],
                    ),
        );
      },
    );
  }

  showChangerUOMDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(),
      builder: (context) {
        return GetBuilder<QuoteQuotationService>(
          builder: (_) {
            final quoteData = widget.quoteData;

            double quantity =
                double.tryParse(quoteData?.units ?? '0.00') ?? 0.0;

            String formattedQuantity = quantity == quantity.toInt()
                ? quantity.toInt().toString()
                : quantity
                    .toStringAsFixed(8)
                    .replaceAll(RegExp(r"([.]*0+)$"), "");

            double uom =
                double.parse(quoteData.uomValue.toString().split(' ')[0]);
            double alteruom = double.parse(
                quoteData.alternateUomValue.toString().split(' ')[0]);

            String uomType = quoteData.uomValue.toString().split(' ')[1];
            String alterUomType =
                quoteData.alternateUomValue.toString().split(' ')[1];

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 10,
                children: [
                  Text('Change UOM',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center),
                  rowItems(
                      name: 'Buyer ordered',
                      type: '$formattedQuantity ${quoteData.uom}'),
                  rowItems(name: 'UOM Value', type: quoteData.uomValue),
                  rowItems(
                      name: 'Alternate UOM Value',
                      type: quoteData.alternateUomValue),
                  Text('Based on the order, you can select',
                      textAlign: TextAlign.center),
                  MaterialButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {},
                      child: Text(
                        alterUomType == quoteData.uom
                            ? '${quantity.toStringAsFixed(2)} ${alterUomType}'
                            : '$formattedQuantity $uomType',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                  Text('OR', textAlign: TextAlign.center),
                  MaterialButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        final selected = uomType == quoteData.uom
                            ? '${((quantity * alteruom) / uom).toStringAsFixed(3)} $alterUomType'
                            : '${((quantity / alteruom) * uom).toStringAsFixed(3)} $uomType';

                        final updated = selected.split(' ');

                        String cleanedUnits =
                            updated[0].replaceAll(RegExp(r"([.]*0+)$"), "");

                        num finalUnits = cleanedUnits.contains('.')
                            ? double.parse(cleanedUnits)
                            : int.parse(cleanedUnits);

                        quoteQuotationService.updateUOM(
                            {'units': finalUnits, 'uom': updated[1]},
                            addURL:
                                '/${widget.quoteData.id}${ApiPaths.sellerChangeUOM}');

                        Get.back();
                      },
                      child: Text(
                        uomType == quoteData.uom
                            ? '${((quantity * alteruom) / uom).toStringAsFixed(3)} $alterUomType'
                            : '${((quantity / alteruom) * uom).toStringAsFixed(3)} $uomType',
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ],
              ),
            );
          },
        );
      },
    );
  }

  columnItems({required String name, required Widget widget}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(name), widget],
    );
  }

  rowItems({required String name, required String type}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(name), Text(type)],
    );
  }
}
