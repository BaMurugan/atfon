import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/Notification_Service.dart';

class NotificationBar extends StatefulWidget {
  int index;
  NotificationBar({super.key, required this.index});

  @override
  State<NotificationBar> createState() => _NotificationBarState();
}

class _NotificationBarState extends State<NotificationBar> {
  final notificationService = Get.find<NotificationService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationService>(
      builder: (controller) {
        return Slidable(
          endActionPane: ActionPane(
              motion: const StretchMotion(),
              extentRatio: 0.2,
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(5),
                  onPressed: (context) async {
                    await notificationService.dismiss(notificationService
                        .notificationDataModule.data![widget.index].id!);
                    Get.snackbar('Deleted', 'Item has been removed.');
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  icon: FontAwesomeIcons.trash,
                ),
              ]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${notificationService.notificationDataModule.data![widget.index].eventMessage}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Created at: ${DateFormat('dd/MM/yyyy, hh:mm:ss a ').format(notificationService.notificationDataModule.data![widget.index].createdAt!.toLocal())}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
