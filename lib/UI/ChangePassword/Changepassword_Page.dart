import 'package:autofon_seller/UI/ChangePassword/PasswordField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/ChangePassword_Service.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey = GlobalKey<FormState>();
  bool buttonEnable = false;
  final changePasswordService = Get.put(ChangePasswordService());
  final currentPassword = TextEditingController();
  final new1 = TextEditingController();
  final new2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    currentPassword.addListener(updateTextFieldColor);
    new1.addListener(updateTextFieldColor);
    new2.addListener(updateTextFieldColor);
  }

  void updateTextFieldColor() {
    if (new1.text == new2.text &&
        new1.text.isNotEmpty &&
        new2.text.isNotEmpty &&
        currentPassword.text.length >= 6) {
      setState(() {
        buttonEnable = true;
      });
    } else {
      setState(() {
        buttonEnable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ChangePasswordService>(
          builder: (controller) => GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Change Password",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 30),
                      PasswordField(
                        controller: currentPassword,
                        label: "Current Password",
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        controller: new1,
                        label: "New Password",
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        controller: new2,
                        label: "Confirm New Password",
                      ),
                      MaterialButton(
                        color: buttonEnable
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.grey,
                        onPressed: buttonEnable == false
                            ? () {}
                            : () {
                                if (formKey.currentState!.validate()) {
                                  if (currentPassword.text == new1.text) {
                                    Get.snackbar('Error',
                                        'New Password and Current Password should not be the same');
                                    return;
                                  }
                                  changePasswordService.changePassword(
                                      currentPassword.text, new1.text);
                                }
                              },
                        child: Text(
                          "Change Password",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
