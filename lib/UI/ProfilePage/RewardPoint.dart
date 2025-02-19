import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Profile_Service.dart';
import 'ViewPointTransaction.dart';

class RewardPoint extends StatefulWidget {
  const RewardPoint({super.key});

  @override
  State<RewardPoint> createState() => _RewardPointState();
}

class _RewardPointState extends State<RewardPoint> {
  final profileController = Get.find<ProfileService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileService>(builder: (controller) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text('Reward Points'),
            ),
            Expanded(
              child: Row(
                spacing: 10,
                children: [
                  ViewPointTransaction(),
                  MaterialButton(
                    onPressed: () {},
                    color: int.parse(
                                profileController.userPoint.data?.balance ??
                                    '0') !=
                            0
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.tertiary,
                    child: Text(
                      'REDEEM',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
