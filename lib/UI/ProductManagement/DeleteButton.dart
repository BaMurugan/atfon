import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/ProductManagement_Service.dart';

class DeleteButton extends StatefulWidget {
  VoidCallback action;
  DeleteButton({super.key, required this.action});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  final productManagementController = Get.find<ProductManagementService>();
  @override
  Widget build(BuildContext context) {
    deleteDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                      "Are you sure you want to delete the selected product?"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("No",
                            style: Theme.of(context).textTheme.bodyMedium),
                      )),
                      Expanded(
                          child: MaterialButton(
                        onPressed: () async {
                          try {
                            await productManagementController
                                .selectDeleteProducts();
                            Get.back();
                            widget.action();
                          } catch (e) {
                            Get.snackbar('Error', e.toString());
                          }
                        },
                        child: Text("Yes",
                            style: Theme.of(context).textTheme.bodyMedium),
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return GetBuilder<ProductManagementService>(
      builder: (controller) {
        return FloatingActionButton(
          backgroundColor: productManagementController.selectedProductID.isEmpty
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.error,
          child: Icon(FontAwesomeIcons.trash),
          onPressed: () {
            deleteDialog();
          },
        );
      },
    );
  }
}
