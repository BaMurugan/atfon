import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Controller/SelfPickUp_Service.dart';

class SelfPickUpOperations extends StatefulWidget {
  String label;
  String? name;
  String? pincode1;
  String? pincode2;
  String? pincode3;
  String id;
  bool add;
  final VoidCallback onUpdate;

  SelfPickUpOperations(
      {super.key,
      required this.label,
      required this.onUpdate,
      this.name,
      this.pincode1,
      this.pincode2,
      this.pincode3,
      required this.add,
      this.id = ""});

  @override
  State<SelfPickUpOperations> createState() => _SelfPickUpOperationsState();
}

class _SelfPickUpOperationsState extends State<SelfPickUpOperations> {
  final controller = Get.find<SelfPickUpService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        color: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController name = TextEditingController();
              TextEditingController pincode1 = TextEditingController();
              TextEditingController pincode2 = TextEditingController();
              TextEditingController pincode3 = TextEditingController();
              name.text = widget.name?.trim() ?? "";
              pincode1.text = widget.pincode1?.trim() ?? "";
              pincode2.text = widget.pincode2?.trim() ?? "";
              pincode3.text = widget.pincode3?.trim() ?? "";
              final formKey = GlobalKey<FormState>();
              return AlertDialog(
                shape: RoundedRectangleBorder(),
                content: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        fields(
                            control: name,
                            label: 'Name',
                            function: (value) {
                              if (value.length == 0) {
                                return "Please Enter the Name";
                              }
                              return null;
                            },
                            isPincode: false),
                        fields(label: 'Pincode 1', control: pincode1),
                        fields(label: 'Pincode 2', control: pincode2),
                        fields(label: 'Pincode 3', control: pincode3),
                      ],
                    ),
                  ),
                ),
                actions: [
                  InkWell(
                    child: Text("Cancel"),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  InkWell(
                    child: Text("Save"),
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (widget.add) {
                          await controller.addData(name.text,
                              [pincode1.text, pincode2.text, pincode3.text]);
                        } else {
                          await controller
                              .updateData(id: widget.id, edit: true, body: {
                            'name': name.text,
                            'pincodes': [
                              pincode1.text,
                              pincode2.text,
                              pincode3.text
                            ]
                          });
                        }
                      }

                      Get.back();
                      widget.onUpdate();
                    },
                  )
                ],
              );
            },
          );
        },
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Text(widget.label, style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }

  fields(
      {required String label,
      FormFieldValidator? function,
      required TextEditingController control,
      bool isPincode = true}) {
    const outline = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextFormField(
        controller: control,
        style: Theme.of(context).textTheme.bodySmall,
        inputFormatters: isPincode
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6)
              ]
            : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          enabledBorder: outline,
          focusedBorder: outline,
          errorBorder: outline,
          focusedErrorBorder: outline,
        ),
        validator: function,
      ),
    );
  }
}
