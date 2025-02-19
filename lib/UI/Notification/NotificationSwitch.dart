import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Notification_Service.dart';

class NotificationSwitch extends StatefulWidget {
  const NotificationSwitch({super.key});

  @override
  State<NotificationSwitch> createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  final notificationService = Get.find<NotificationService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationService>(
      builder: (_) {
        return Transform.scale(
          scale: 0.8,
          child: Switch(
            value: notificationService
                .notificationStatusModule.data!.notificationEnabled!,
            onChanged: (value) {
              notificationService.updateStatus();
            },
          ),
        );
      },
    );
  }
}
