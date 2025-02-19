import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Controller/Orders_Service.dart';
import '../../../Module/Shipment_Module.dart';
import 'OrderDetails.dart';
import 'ShipmentDialog/ShipmentDialogWidget.dart';

class OrderBanner extends StatefulWidget {
  dynamic orders;
  OrderBanner({super.key, required this.orders});

  @override
  State<OrderBanner> createState() => _OrderBannerState();
}

class _OrderBannerState extends State<OrderBanner> {
  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    final orders = widget.orders;
    return GetBuilder<OrderService>(
      builder: (_) => GestureDetector(
        onTap: () async {
          ShipmentModule shipment =
              await orderService.getShipmentData(orders.id);
          if (shipment.data?.shipmentDetails?.isNotEmpty ?? false) {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(),
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return GetBuilder<OrderService>(
                  builder: (_) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: ShipmentDialogWidget(
                        shipment: shipment,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
        child: OrderDetails(orders: orders),
      ),
    );
  }
}
