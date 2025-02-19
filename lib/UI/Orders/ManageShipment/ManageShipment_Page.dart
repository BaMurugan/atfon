import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/Orders_Service.dart';
import 'AddressFields.dart';
import 'AmountField.dart';
import 'PendingItems.dart';
import 'ShipmentList.dart';
import 'ShipmentProgress.dart';

class ManageShipmentPage extends StatefulWidget {
  String quoteId;
  String orderId;
  ManageShipmentPage({super.key, required this.quoteId, required this.orderId});

  @override
  State<ManageShipmentPage> createState() => _ManageShipmentPageState();
}

class _ManageShipmentPageState extends State<ManageShipmentPage> {
  final orderService = Get.find<OrderService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: orderService.getViewOrderDetails(
              qteId: widget.quoteId, odrId: widget.orderId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            return GetBuilder<OrderService>(
              builder: (controller) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AddressFields(),
                        ShipmentProgress(),
                        PendingItems(),
                        ...List.generate(
                          orderService
                              .sellerOrderModule.data!.shipments!.length,
                          (index) {
                            return ShipmentList(
                              index: index,
                              order: orderService
                                  .sellerOrderModule.data!.shipments![index],
                            );
                          },
                        ),
                        AmountField(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
