import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import '../../Controller/BankDetails_Service.dart';

class EditBankDetails extends StatefulWidget {
  VoidCallback action;
  EditBankDetails({super.key, required this.action});

  @override
  State<EditBankDetails> createState() => _EditBankDetailsState();
}

class _EditBankDetailsState extends State<EditBankDetails> {
  final bankDetailService = Get.find<BankDetailService>();
  @override
  Widget build(BuildContext context) {
    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        bankDetailService.image = File(pickedFile.path);
        bankDetailService.update();
      }
    }

    final outline = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 3.5,
      ),
    );

    field(
        {required String label,
        required TextEditingController controller,
        TextInputType? textInputType,
        List<TextInputFormatter>? textInputFormatter,
        required bool validate}) {
      return TextFormField(
        keyboardType: textInputType,
        controller: controller,
        style: Theme.of(context).textTheme.bodySmall,
        inputFormatters: textInputFormatter,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          enabledBorder: outline,
          focusedBorder: outline,
          errorBorder: outline,
          focusedErrorBorder: outline,
        ),
        validator: validate
            ? (value) {
                if (value!.isEmpty) {
                  return 'Please Enter the $label';
                }
                return null;
              }
            : (value) {
                return null;
              },
      );
    }

    return GetBuilder<BankDetailService>(
      builder: (_) => FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          bankDetailService.image = null;
          bankDetailService.update();
          showDialog(
            context: context,
            builder: (context) {
              final key = GlobalKey<FormState>();
              TextEditingController bankAccountNumber = TextEditingController();
              TextEditingController bankName = TextEditingController();
              TextEditingController ifscCode = TextEditingController();
              TextEditingController upiId = TextEditingController();

              bankAccountNumber.text =
                  bankDetailService.bankDetailModule.data?.bankAccountNumber ??
                      "";
              bankName.text =
                  bankDetailService.bankDetailModule.data?.bankName ?? "";
              ifscCode.text =
                  bankDetailService.bankDetailModule.data?.ifsc ?? "";
              upiId.text = bankDetailService.bankDetailModule.data?.upiId ?? "";

              return AlertDialog(
                shape: RoundedRectangleBorder(),
                content: SingleChildScrollView(
                  child: GetBuilder<BankDetailService>(
                    builder: (_) {
                      return Form(
                        key: key,
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Update Bank Details'),
                            field(
                                label: 'Bank Account Number',
                                controller: bankAccountNumber,
                                textInputType: TextInputType.number,
                                textInputFormatter: [
                                  CustomTextInputFormatter.maxLength(16),
                                  CustomTextInputFormatter.digitsOnly
                                ],
                                validate: true),
                            field(
                                label: 'Bank Name',
                                controller: bankName,
                                textInputFormatter: [
                                  CustomTextInputFormatter.lettersOnly
                                ],
                                validate: true),
                            field(
                                label: 'IFSC Code',
                                controller: ifscCode,
                                textInputFormatter: [
                                  CustomTextInputFormatter.maxLength(11),
                                  CustomTextInputFormatter.alphanumeric,
                                ],
                                validate: true),
                            field(
                                label: 'UPI ID',
                                controller: upiId,
                                textInputFormatter: [
                                  CustomTextInputFormatter.upiIdFormat,
                                ],
                                validate: false),
                            bankDetailService.image == null
                                ? SizedBox()
                                : Text(
                                    'File Name : ${bankDetailService.image!.path.split('/').last}'),
                            Text(
                              'The image format should be either .jpg or .jpeg.',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Theme.of(context).colorScheme.error),
                            ),
                            MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () async {
                                await pickImage();
                              },
                              child: Text('Upload File',
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              spacing: 10,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Text('Cancel')),
                                InkWell(
                                  child: Text('Save'),
                                  onTap: () async {
                                    if (key.currentState!.validate()) {
                                      try {
                                        await bankDetailService
                                            .updateBankDetail(
                                                bankAccountNumber:
                                                    bankAccountNumber.text,
                                                bankName: bankName.text,
                                                ifsc: ifscCode.text,
                                                upi_id: upiId.text);
                                        Get.back();
                                        widget.action();
                                      } catch (e) {
                                        Get.snackbar('Error', e.toString());
                                      }
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
        child: Icon(FontAwesomeIcons.solidEdit),
      ),
    );
  }
}

class CustomTextInputFormatter {
  static final TextInputFormatter lettersOnly =
      _NoDeleteFormatter(RegExp(r'^[a-zA-Z ]*$'));

  static final TextInputFormatter digitsOnly =
      _NoDeleteFormatter(RegExp(r'^[0-9]*$'));

  static final TextInputFormatter alphanumeric =
      _NoDeleteFormatter(RegExp(r'^[a-zA-Z0-9]*$'));

  static final TextInputFormatter upiIdFormat =
      _NoDeleteFormatter(RegExp(r'^[a-zA-Z0-9@.]*$'));

  static TextInputFormatter maxLength(int length) {
    return LengthLimitingTextInputFormatter(length);
  }
}

class _NoDeleteFormatter extends TextInputFormatter {
  final RegExp regex;

  _NoDeleteFormatter(this.regex);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }

    return oldValue;
  }
}
