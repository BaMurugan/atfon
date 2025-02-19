import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Orders_Service.dart';
import 'OrderBanner.dart';

class OrdersBar extends StatefulWidget {
  const OrdersBar({super.key});

  @override
  State<OrdersBar> createState() => _OrdersBarState();
}

class _OrdersBarState extends State<OrdersBar> {
  final orderService = Get.put(OrderService());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(fetchData);
    super.initState();
  }

  fetchData() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      orderService.fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: orderService.instilize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (orderService.orders.isEmpty) {
            return Center(child: Text('No Orders Found'));
          }
          return GetBuilder<OrderService>(
            builder: (_) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Orders',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        'Showing ${orderService.orderModule.data!.orders!.isNotEmpty ? 1 : 0}-${orderService.orderModule.data!.orders!.length} of ${orderService.orderModule.data!.totalOrders} Orders'),
                    Expanded(
                      child: RawScrollbar(
                        thumbColor: Theme.of(context).colorScheme.secondary,
                        thumbVisibility: true,
                        radius: Radius.circular(10),
                        trackVisibility: true,
                        controller: scrollController,
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: orderService.orders.length,
                          itemBuilder: (context, index) {
                            final orders = orderService.orders[index];
                            return OrderBanner(orders: orders);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
