import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../Controller/Authorization_Service.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  final authService = Get.find<AuthService>();
  final outLine = OutlineInputBorder(borderSide: BorderSide(width: 2.5));
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  Timer? timer;
  bool eye1 = true;
  bool eye2 = true;
  int resentIn = 120;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  startTimer() {
    if (resentIn != 0) {
      timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          if (resentIn >= 0) {
            resentIn -= 1;
          } else {
            timer.cancel();
          }
          setState(() {});
        },
      );
    }
  }

  passwordField(
      {required String label,
      String? Function(String?)? validator,
      required TextEditingController controller,
      required bool eye,
      required VoidCallback eyePress}) {
    return TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.bodySmall,
        obscureText: eye,
        inputFormatters: [LengthLimitingTextInputFormatter(12)],
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: eyePress,
                icon: Icon(
                    eye ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash)),
            labelText: label,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            focusedBorder: outLine,
            errorBorder: outLine,
            enabledBorder: outLine,
            focusedErrorBorder: outLine),
        validator: validator);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Text('Confirm OTP',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge),
          Form(
            key: formKey,
            child: Column(
              spacing: 10,
              children: [
                Pinput(
                  length: 6,
                  controller: pinController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter the Pin';
                    }
                    return null;
                  },
                ),
                resentIn > 0
                    ? Text('Resend OTP in $resentIn')
                    : InkWell(
                        onTap: () {
                          resentIn = 120;
                          authService.resetPasswordRequest();
                          startTimer();
                        },
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                passwordField(
                  eye: eye1,
                  label: 'New Password',
                  eyePress: () {
                    eye1 = !eye1;
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Enter the New Password';
                    }
                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      return 'Password not Matched';
                    }
                    return null;
                  },
                  controller: newPasswordController,
                ),
                passwordField(
                  eye: eye2,
                  label: 'Confirm Password',
                  eyePress: () {
                    eye2 = !eye2;
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Enter the Confirm Password';
                    }
                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      return 'Password not Matched';
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await authService.requestChangePassword(
                      pinController.text, newPasswordController.text);
                  Get.back();
                } catch (e) {
                  Get.snackbar('Error', e.toString());
                }
              }
            },
            color: Theme.of(context).colorScheme.secondary,
            child: Text('Change Password',
                style: Theme.of(context).textTheme.bodySmall),
          )
        ],
      );
    });
  }
}
