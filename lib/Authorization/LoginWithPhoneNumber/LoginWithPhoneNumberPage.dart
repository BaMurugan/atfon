import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Controller/Authorization_Service.dart';
import 'VerifyPhoneNumber.dart';

class LoginWithPhoneNumberPage extends StatefulWidget {
  const LoginWithPhoneNumberPage({super.key});

  @override
  State<LoginWithPhoneNumberPage> createState() =>
      _LoginWithPhoneNumberPageState();
}

class _LoginWithPhoneNumberPageState extends State<LoginWithPhoneNumberPage> {
  final authService = Get.find<AuthService>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authService.phoneNumber.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration FieldDecrotion(String labelText,
        {Widget? prefix, Widget? suffix}) {
      return InputDecoration(
        label: Text(
          labelText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        prefix: prefix,
        suffixIcon: suffix,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GetBuilder<AuthService>(
            builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 20,
              children: [
                Text(
                  'Login With Phone Number',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    controller: authService.phoneNumber,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: FieldDecrotion(
                      "Phone Number",
                      prefix: Text(
                        "+91 ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Phone Number";
                      }
                      if (value.length != 10) {
                        return "Please Enter Valid Phone Number";
                      }
                      return null;
                    },
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await authService.requestOTP();

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(),
                          builder: (context) {
                            return GetBuilder<AuthService>(
                                builder: (controller) => VerifyPhoneNumber());
                          },
                        );
                      } catch (e) {
                        Get.snackbar('Error', e.toString());
                      }
                    }
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text('Request OTP',
                      style: Theme.of(context).textTheme.bodyMedium),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
