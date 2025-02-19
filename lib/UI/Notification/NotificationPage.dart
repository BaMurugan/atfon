import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Notification_Service.dart';
import 'NotificationBar.dart';
import 'NotificationSwitch.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notificationService = Get.put(NotificationService());
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    banner(String title, int itemIndex) {
      return GestureDetector(
        onTap: () async {
          notificationService.selectedIndex = itemIndex;
          notificationService.update();
          await notificationService.getNotification();
        },
        child: Container(
          width: 100,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: itemIndex == notificationService.selectedIndex
                  ? theme.colorScheme.secondary
                  : theme.primaryColor,
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Text(title,
              textAlign: TextAlign.center, softWrap: true, maxLines: 3),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: notificationService.instilize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('Something went wrong please try again'));
            }
            return GetBuilder<NotificationService>(builder: (controller) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 2.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notifications",
                            style: theme.textTheme.bodyLarge,
                          ),
                          NotificationSwitch(),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      height: 100,
                      child: RawScrollbar(
                        controller: _scrollController,
                        thumbColor: Theme.of(context).colorScheme.secondary,
                        thumbVisibility: true,
                        thickness: 4.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            banner('New\nEnquiry', 0),
                            banner('New\nOrder', 1),
                            banner('Order\nCompleted', 2),
                            banner('Shipment\nCompleted', 3),
                            banner('Order\nShortage', 4),
                            banner('Payment\nCompleted', 5),
                            banner('Service\nRequest\nCompleted', 6),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: notificationService
                              .notificationDataModule.data!.isEmpty
                          ? Center(child: Text('No notifications available'))
                          : RawScrollbar(
                              thumbVisibility: true,
                              thumbColor:
                                  Theme.of(context).colorScheme.secondary,
                              radius: Radius.circular(10),
                              thickness: 4.0,
                              child: ListView.builder(
                                itemCount: notificationService
                                    .notificationDataModule.data!.length,
                                itemBuilder: (context, index) {
                                  return NotificationBar(index: index);
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
