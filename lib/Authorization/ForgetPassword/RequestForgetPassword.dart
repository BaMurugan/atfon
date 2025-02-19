import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Controller/Authorization_Service.dart';

class RequestForgetPassword extends StatefulWidget {
  const RequestForgetPassword({super.key});

  @override
  State<RequestForgetPassword> createState() => _RequestForgetPasswordState();
}

class _RequestForgetPasswordState extends State<RequestForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final authService = Get.find<AuthService>();
  @override
  void initState() {
    authService.phoneNumber.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final outLine = OutlineInputBorder(borderSide: BorderSide(width: 2.5));
    return GetBuilder<AuthService>(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text('Reset Password',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge),
          Form(
            key: formKey,
            child: TextFormField(
              controller: authService.phoneNumber,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                  labelText: 'Please Enter The Phone Number',
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  prefix: Text('+91 '),
                  focusedBorder: outLine,
                  errorBorder: outLine,
                  enabledBorder: outLine,
                  focusedErrorBorder: outLine),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter the Phone Number';
                }
                return null;
              },
            ),
          ),
          MaterialButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await authService.resetPasswordRequest();
                  authService.resetPasswordPage = 1;
                  authService.update();
                } catch (e) {
                  Get.snackbar('Error', e.toString());
                }
              }
            },
            color: Theme.of(context).colorScheme.secondary,
            child: Text('Reset Password',
                style: Theme.of(context).textTheme.bodySmall),
          )
        ],
      );
    });
  }
}
