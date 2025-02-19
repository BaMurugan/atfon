import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/DriverManagement_Service.dart';

class DriverOperation extends StatefulWidget {
  String title;
  String? name;
  String? phoneNumber;
  String? vehicleNumber;
  String? id;

  DriverOperation(
      {super.key,
      required this.title,
      this.name,
      this.phoneNumber,
      this.vehicleNumber,
      this.id});

  @override
  State<DriverOperation> createState() => _DriverOperationState();
}

class _DriverOperationState extends State<DriverOperation> {
  final deliveryControl = Get.find<DriverManagementService>();
  final outLine = const OutlineInputBorder(borderSide: BorderSide(width: 2));
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final vehicleNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = widget.name ?? '';
    phoneNumberController.text = widget.phoneNumber ?? '';
    vehicleNumberController.text = widget.vehicleNumber ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textField(
        {required TextEditingController controller,
        required String label,
        TextInputType? textInputType,
        String? Function(String?)? validation,
        List<TextInputFormatter>? textInputFormat}) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: TextFormField(
          inputFormatters: textInputFormat,
          keyboardType: textInputType,
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            focusedBorder: outLine,
            enabledBorder: outLine,
            errorBorder: outLine,
            focusedErrorBorder: outLine,
            labelText: label,
            labelStyle: Theme.of(context).textTheme.labelMedium,
          ),
          validator: validation,
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  textField(
                    label: "Name",
                    controller: nameController,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter the Name";
                      }
                      return null;
                    },
                  ),
                  textField(
                    label: "Phone Number",
                    controller: phoneNumberController,
                    textInputFormat: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    textInputType: TextInputType.number,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter the Phone Number";
                      }
                      if (value.length != 10) {
                        return "Please Enter valid Phone Number";
                      }
                      return null;
                    },
                  ),
                  textField(
                    label: "Vehicle Number",
                    controller: vehicleNumberController,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter the Vehicle Number";
                      }
                      return null;
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await deliveryControl.deliveryPerson(
                              name: nameController.text,
                              phoneNumber: phoneNumberController.text,
                              vehicleNumber: vehicleNumberController.text,
                              id: widget.id ?? '',
                            );
                            deliveryControl.getData();
                            Get.back();
                          } catch (e) {
                            Get.snackbar("Unable to Process", e.toString());
                          }
                        }
                      },
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
