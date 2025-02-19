import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../Controller/Orders_Service.dart';

class ToleranceButton extends StatefulWidget {
  dynamic data;
  ToleranceButton({super.key, required this.data});

  @override
  State<ToleranceButton> createState() => _ToleranceButtonState();
}

class _ToleranceButtonState extends State<ToleranceButton> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    double quantity = double.tryParse('${widget.data.units}' ?? '0.00') ?? 0.0;
    String formattedQuantity = quantity == quantity.toInt()
        ? quantity.toInt().toString()
        : quantity.toStringAsFixed(8).replaceAll(RegExp(r"([.]*0+)$"), "");
    return MaterialButton(
      color: widget.data.isToleranceApplied
          ? Theme.of(context).colorScheme.tertiary
          : Theme.of(context).colorScheme.secondary,
      onPressed: widget.data.isToleranceApplied
          ? () {}
          : () async {
              orderService.getTolerance(widget.data.id, widget.data);
              await orderService.getDecimalPlace(widget.data.uom);

              await addTolerance(
                  (double.tryParse(formattedQuantity ?? '0')) ?? 0.00);
            },
      child:
          Text('Apply Tolerance', style: Theme.of(context).textTheme.bodySmall),
    );
  }

  addTolerance(double quantity) {
    TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return GetBuilder<OrderService>(
            builder: (_) => Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Confirm Tolerance Application',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Are you sure you want to use tolerance for this product? This is a one-time process for this line item.',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        Form(
                          key: formKey,
                          child: TextFormField(
                            controller: controller,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              DecimalTextInputFormatter(orderService
                                  .decimalPlaceModule.data!.decimalPlaces!),
                            ],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                color: Theme.of(context).colorScheme.secondary,
                                child: Icon(FontAwesomeIcons.minus),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2)),
                              suffixIcon: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                color: Theme.of(context).colorScheme.secondary,
                                child: Icon(FontAwesomeIcons.plus),
                              ),
                            ),
                            validator: (value) {
                              if (double.parse(value!) >= orderService.ltq &&
                                  double.parse(value!) <= orderService.utq) {
                                return null;
                              } else {
                                return 'Please select a quantity between ${((double.parse('${orderService.ltq} and ${orderService.utq}')).toStringAsFixed(3))}';
                              }
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('LTQ: ${orderService.ltq.toStringAsFixed(3)}'),
                            Text('UTQ: ${orderService.utq.toStringAsFixed(3)}'),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Cancel',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                              MaterialButton(
                                color: Theme.of(context).colorScheme.secondary,
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await orderService.updateTolerance(
                                        widget.data.id, controller.text);
                                    Get.back();
                                  }
                                },
                                child: Text('Confirm',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                            ]),
                      ],
                    ))));
      },
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalPlaces;

  DecimalTextInputFormatter(this.decimalPlaces);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final RegExp regex = RegExp("^\\d*(\\.\\d{0,$decimalPlaces})?\$");

    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }

    return oldValue;
  }
}
