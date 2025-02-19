import 'package:autofon_seller/Other%20Service/ApiPath.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Controller/Orders_Service.dart';
import 'BuyerDisputeButton.dart';
import 'ConfirmationDialog.dart';
import 'DispatchDialog.dart';
import 'DisputeButton.dart';
import 'DisputeVerification.dart';
import 'ProductListDesign.dart';

class ShipmentList extends StatefulWidget {
  dynamic order;
  int index;
  ShipmentList({super.key, required this.order, required this.index});

  @override
  State<ShipmentList> createState() => _ShipmentListState();
}

class _ShipmentListState extends State<ShipmentList> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return GetBuilder<OrderService>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(),
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      children: [
                        Text('Shipment ${widget.index + 1}',
                            textAlign: TextAlign.center),
                        ...List.generate(
                          order.shipmentLineItems!.length,
                          (index) {
                            return ProductListDesign(
                                itemData: order.shipmentLineItems![index]);
                          },
                        ),
                        ...List.generate(
                          order.deliveryCharges.length,
                          (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${order.deliveryCharges[index].name}'),
                                Text('${order.deliveryCharges[index].charge}'),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Shipment ${widget.index + 1}',
                    textAlign: TextAlign.center),
                listItem('No Of Products', order.shipmentLineItems!.length),
                listItem('Value\n(inclusive of GST)', order.totalPrice),
                listItem('Other Charges', order.totalDeliveryCharge),
                listItem('Status', order.status),
                order.status == 'Delivered'
                    ? listItem(
                        order.status == 'Delivered'
                            ? 'Delivered Date'
                            : 'Dispatched Date',
                        DateFormat('dd MMM yyyy').format(
                            DateTime.parse(order.deliveredAt).toLocal()))
                    : listItem(
                        'Dispatched Date',
                        order.status == 'Pending'
                            ? '-'
                            : DateFormat('dd MMM yyyy').format(
                                DateTime.parse(order.dispatchedAt).toLocal())),
                order.status == 'Delivered'
                    ? listItem(
                        'Delivered Time',
                        DateFormat('hh:mm a').format(
                            DateTime.parse(order.dispatchedAt).toLocal()))
                    : listItem(
                        'Dispatched Time',
                        order.status == 'Pending'
                            ? '-'
                            : DateFormat('hh:mm a').format(
                                DateTime.parse(order.dispatchedAt).toLocal())),
                order.status != 'Delivered'
                    ? listItem('Confirmed by Buyer',
                        order.disputeApproval! ? "Yes" : 'NO')
                    : SizedBox(),
                (orderService.isEdit && order.status == 'Pending')
                    ? MaterialButton(
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () async {
                          await orderService.deleteShipment(order.id);
                        },
                        child: Text('Delete',
                            style: Theme.of(context).textTheme.bodySmall),
                      )
                    : SizedBox(),
                order.status == 'Pending'
                    ? DispatchDialog(
                        id: order.id,
                        titleWidget: Text(
                          'Dispatch',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      )
                    : order.status == 'On The Way'
                        ? order.hasBuyerRaisedDispute == true
                            ? BuyerDisputeButton(order: order)
                            : order.hasSellerRaisedDispute == true
                                ? Container(
                                    alignment: Alignment.center,
                                    child: DisputeVerificationDialog(
                                        shipmentID: order.id),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ConfirmationDialog(shipmentID: order.id),
                                      DisputeButton(
                                          referenceId: order.referenceId,
                                          shipmentID: order.id,
                                          shipmentProducts:
                                              order.shipmentLineItems),
                                    ],
                                  )
                        : SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  listItem(dynamic key, dynamic value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Text(
            '$key',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: Text('$value', style: Theme.of(context).textTheme.bodySmall),
        )
      ],
    );
  }
}
