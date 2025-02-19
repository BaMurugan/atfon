import 'package:autofon_seller/UI/ProfilePage/ConfirmEmail.dart';
import 'package:autofon_seller/UI/ProfilePage/EditEmail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/Profile_Service.dart';

class EmailContainer extends StatefulWidget {
  VoidCallback action;
  EmailContainer({super.key, required this.action});

  @override
  State<EmailContainer> createState() => _EmailContainerState();
}

class _EmailContainerState extends State<EmailContainer> {
  final profileController = Get.find<ProfileService>();
  int bottomIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          Icon(FontAwesomeIcons.solidEnvelope),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text('Email'),
              Text(profileController.user.data?.user?.email ?? '--'),
              Row(
                spacing: 10,
                children: [
                  Text(
                    profileController.user.data?.user?.isVerifiedEmail ?? false
                        ? 'Verified'
                        : 'Not Verified',
                    style: TextStyle(
                        color: profileController
                                    .user.data?.user?.isVerifiedEmail ??
                                false
                            ? Colors.green
                            : Colors.red),
                  ),
                  MaterialButton(
                    onPressed: () {
                      final page = [
                        EditEmail(),
                        ConfirmEmail(
                          action: widget.action,
                        )
                      ];
                      profileController.emailVerifyPageNumber = 0;
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(),
                        builder: (context) {
                          return GetBuilder<ProfileService>(
                              builder: (_) => page[
                                  profileController.emailVerifyPageNumber]);
                        },
                      );
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      'Edit Email',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
