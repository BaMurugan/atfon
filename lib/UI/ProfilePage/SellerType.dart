import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';

import '../../Controller/Profile_Service.dart';

class SellerType extends StatefulWidget {
  VoidCallback action;
  SellerType({super.key, required this.action});

  @override
  State<SellerType> createState() => _SellerTypeState();
}

class _SellerTypeState extends State<SellerType> {
  String? groupValue;
  bool enableEdit = false;
  final profileService = Get.find<ProfileService>();

  @override
  void initState() {
    groupValue = profileService.user.data?.sellerType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileService>(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Radio<String>(
                value: 'SB',
                groupValue: groupValue,
                onChanged: (value) {
                  enableEdit
                      ? setState(() {
                          groupValue = value;
                        })
                      : () {};
                  profileService.update();
                },
              ),
              Text('SB'),
              Radio<String>(
                value: 'SPB',
                groupValue: groupValue,
                onChanged: (value) {
                  enableEdit
                      ? setState(() {
                          groupValue = value;
                        })
                      : () {};
                  profileService.update();
                },
              ),
              Text('SPB'),
            ],
          ),
          profileService.sellerTypeModule.data != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        profileService.updateSellerType(delete: true);
                        widget.action();
                        setState(() {});
                      },
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text('Cancel',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    InformationButton(
                      date: profileService.sellerTypeModule.data!.updatedAt,
                    ),
                  ],
                )
              : enableEdit
                  ? Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: profileService.user.data!.sellerType !=
                                    groupValue
                                ? () async {
                                    enableEdit = true;

                                    profileService.user.data!.sellerType == null
                                        ? await profileService.updateUser(
                                            sellerType: true,
                                            requestedType: groupValue)
                                        : await profileService.updateSellerType(
                                            requestedType: groupValue);
                                    widget.action();
                                  }
                                : () {},
                            color: profileService.user.data!.sellerType !=
                                    groupValue
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.tertiary,
                            child: Text('Save',
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              enableEdit = false;
                              profileService.update();
                              groupValue =
                                  profileService.user.data?.sellerType;
                              setState(() {});
                            },
                            color: Theme.of(context).colorScheme.secondary,
                            child: Text('Cancel',
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ),
                      ],
                    )
                  : MaterialButton(
                      onPressed: () {
                        enableEdit = true;
                        setState(() {});
                      },
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text('Edit',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
        ],
      ),
    );
  }
}

class InformationButton extends StatelessWidget {
  final DateTime? date;

  const InformationButton({super.key, this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (date != null) {
          DateTime nextMonthFirstDay = DateTime(
            date!.year,
            date!.month + 1,
            1,
          );

          showPopover(
            barrierColor: Colors.transparent,
            context: context,
            bodyBuilder: (context) {
              String formattedDate =
                  DateFormat('dd/MM/yyyy').format(nextMonthFirstDay);

              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  'Your seller type change request will be updated on $formattedDate',
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
          );
        }
      },
      child: const Icon(Icons.info),
    );
  }
}
