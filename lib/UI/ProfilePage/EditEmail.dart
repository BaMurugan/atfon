import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/Profile_Service.dart';

class EditEmail extends StatefulWidget {
  const EditEmail({
    super.key,
  });

  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  final profileController = Get.find<ProfileService>();
  bool eyeStatus = true;
  @override
  void initState() {
    profileController.passwordController.clear();
    profileController.emailController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const outline = OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.black, width: 3.5, style: BorderStyle.solid));
    field(
        {required String name,
        required TextEditingController controller,
        bool obscureText = false,
        List<TextInputFormatter>? inputFormatters,
        Widget? suffixIcon,
        String? Function(String?)? validate}) {
      return TextFormField(
        obscureText: obscureText,
        controller: controller,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          focusedBorder: outline,
          suffixIcon: suffixIcon,
          errorBorder: outline,
          enabledBorder: outline,
          focusedErrorBorder: outline,
          labelText: name,
          labelStyle: Theme.of(context).textTheme.bodySmall,
        ),
        style: Theme.of(context).textTheme.bodySmall,
        onChanged: (value) {
          setState(() {});
        },
      );
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Edit Email",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  field(
                    name: 'Enter Email Address',
                    controller: profileController.emailController,
                  ),
                  field(
                      inputFormatters: [LengthLimitingTextInputFormatter(12)],
                      name: 'Please Confirm Your Login Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            eyeStatus = !eyeStatus;
                            setState(() {});
                          },
                          icon: Icon(!eyeStatus
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye)),
                      controller: profileController.passwordController,
                      obscureText: eyeStatus),
                  MaterialButton(
                    onPressed: profileController.emailController.text
                                .endsWith('.com') &&
                            profileController.passwordController.text.length >=
                                6
                        ? () async {
                            FocusScope.of(context).unfocus();
                            try {
                              await profileController.requestEdit();
                              profileController.emailVerifyPageNumber = 1;
                              profileController.update();
                            } catch (e) {
                              Get.snackbar('Error', e.toString());
                            }
                          }
                        : () {},
                    color: profileController.emailController.text
                                .endsWith('.com') &&
                            profileController.passwordController.text.length >=
                                6
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.tertiary,
                    child: Text(
                      'Verify',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
