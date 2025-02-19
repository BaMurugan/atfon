import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Profile_Service.dart';

class AvailableSwitch extends StatefulWidget {
  const AvailableSwitch({super.key});

  @override
  State<AvailableSwitch> createState() => _AvailableSwitchState();
}

class _AvailableSwitchState extends State<AvailableSwitch> {
  final profileService = Get.find<ProfileService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileService>(
      builder: (controller) => Transform.scale(
        scale: 0.8,
        child: Switch(
          value: profileService.user.data!.availability!,
          onChanged: (value) {
            profileService.user.data!.availability =
                !profileService.user.data!.availability!;
            profileService.update();
            profileService.updateUser();
          },
        ),
      ),
    );
  }
}
