import 'package:flutter/material.dart';

class TransactionDetailButton extends StatefulWidget {
  dynamic shipment;
  TransactionDetailButton({super.key, required this.shipment});

  @override
  State<TransactionDetailButton> createState() =>
      _TransactionDetailButtonState();
}

class _TransactionDetailButtonState extends State<TransactionDetailButton> {
  @override
  Widget build(BuildContext context) {
    final shipmentIndex = widget.shipment;
    return MaterialButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(),
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Transaction Details',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        lineItems(
                            'Total amount paid', shipmentIndex.totalPrice),
                        lineItems(
                            'Total Tax paid',
                            (double.parse(shipmentIndex.totalTax) +
                                    double.parse(
                                        '${shipmentIndex.deliveryChargeTax}'))
                                .toStringAsFixed(2)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      color: Theme.of(context).colorScheme.secondary,
      child: Text('Transaction Details',
          style: Theme.of(context).textTheme.bodySmall),
    );
  }

  lineItems(dynamic key, dynamic value) {
    return Row(
      children: [
        Expanded(child: Text('$key')),
        Expanded(child: Text('$value'))
      ],
    );
  }
}
