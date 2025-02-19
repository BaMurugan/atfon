import 'package:flutter/material.dart';

class OrderDetailButton extends StatefulWidget {
  dynamic shipment;
  OrderDetailButton({super.key, required this.shipment});

  @override
  State<OrderDetailButton> createState() => _OrderDetailButtonState();
}

class _OrderDetailButtonState extends State<OrderDetailButton> {
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
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Order Details',
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
                      spacing: 10,
                      children: [
                        lineItems('Shipment Id', shipmentIndex.referenceId),
                        lineItems('Order Status', shipmentIndex.status),
                        lineItems('Delivery Person Name',
                            shipmentIndex.deliveryPersonName),
                        lineItems('Delivery Person Contact',
                            shipmentIndex.deliveryPersonContact),
                        lineItems('Delivery Vehicle Number',
                            shipmentIndex.deliveryVehicleNo),
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
      child:
          Text('Order Details', style: Theme.of(context).textTheme.bodySmall),
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
