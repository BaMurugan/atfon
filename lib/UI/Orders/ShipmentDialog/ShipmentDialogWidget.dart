import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Module/Shipment_Module.dart';
import 'OrderDetailButton.dart';
import 'ShipmentInvoice.dart';
import 'TransactionDetailButton.dart';

class ShipmentDialogWidget extends StatefulWidget {
  ShipmentModule shipment;
  ShipmentDialogWidget({super.key, required this.shipment});

  @override
  State<ShipmentDialogWidget> createState() => _ShipmentDialogWidgetState();
}

class _ShipmentDialogWidgetState extends State<ShipmentDialogWidget> {
  lineItems(dynamic key, dynamic value) {
    return Row(
      children: [
        Expanded(child: Text('$key')),
        Expanded(child: Text('$value'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final shipment = widget.shipment;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        shipment.data!.shipmentDetails!.length,
        (index) {
          final shipmentIndex = shipment.data!.shipmentDetails![index];
          return Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 0,
              children: [
                Text('Shipment ${index + 1}', textAlign: TextAlign.center),
                lineItems(
                    'No of Products', shipmentIndex.shipmentLineItems!.length),
                lineItems('Value (inclusive of GST)', shipmentIndex.totalPrice),
                lineItems('Status', shipmentIndex.status),
                if (shipmentIndex.status == 'On The Way')
                  lineItems(
                      'Dispatched At',
                      DateFormat('dd MMM yyyy hh:mm a')
                          .format(shipmentIndex.dispatchedAt!.toLocal())),
                if (shipmentIndex.status == 'Delivered')
                  lineItems(
                      'Delivered At',
                      DateFormat('dd MMM yyyy hh:mm a')
                          .format(shipmentIndex.deliveredAt!.toLocal())),
                if (shipmentIndex.status == 'Delivered')
                  TransactionDetailButton(shipment: shipmentIndex),
                if (shipmentIndex.status == 'Delivered')
                  OrderDetailButton(shipment: shipmentIndex),
                if (shipmentIndex.status == 'Delivered')
                  ShipmentInvoice(shipment: shipmentIndex.invoice!.shipmentId!),
              ],
            ),
          );
        },
      ),
    );
  }
}
