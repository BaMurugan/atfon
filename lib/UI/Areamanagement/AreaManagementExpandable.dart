import 'package:autofon_seller/UI/Areamanagement/AddareaPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/AreaManagemet_Service.dart';
import '../../Module/Area_Module.dart';
import '../../Module/Pincode_Module.dart';
import '../../Module/ServiceArea_Module.dart';

class AreaExpandable extends StatefulWidget {
  Datum item;
  AreaExpandable({super.key, required this.item});

  @override
  State<AreaExpandable> createState() => _AreaExpandableState();
}

class _AreaExpandableState extends State<AreaExpandable> {
  final areaManagementController = Get.find<AreaManagementService>();
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GetBuilder<AreaManagementService>(
      builder: (_) => GestureDetector(
        onTap: () {
          expand = !expand;
          setState(() {});
        },
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 100),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.secondary,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  item.name!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              expand ? const SizedBox() : const SizedBox(height: 10),
              expand
                  ? Text(item.serviceableAreas!.join(", "))
                  : const SizedBox(),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        final data = widget.item;
                        Get.to(AddArea(
                          item: item,
                          action: () {
                            setState(() {});
                          },
                        ));
                      },
                      color: Colors.green,
                      child: Text("Edit",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.red,
                      onPressed: () async {
                        try {
                          await areaManagementController
                              .deletePincode(widget.item.id!);
                        } catch (e) {
                          Get.snackbar('Error', 'Unable to Delete');
                        }
                      },
                      child: Text("Delete",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
