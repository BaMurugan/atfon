import 'dart:async';

import 'package:autofon_seller/Authorization/Login/LoginPage.dart';
import 'package:autofon_seller/Authorization/SignUp/ConfirmSignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../Controller/Authorization_Service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  bool checkBoxChecked = false;
  bool eye1 = true;
  bool eye2 = true;
  String? selectedValue;

  @override
  void initState() {
    authService.signupInstilize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(width: 3.5),
    );
    textField(
        {required String label,
        bool readOnly = false,
        Function(String)? onChanged,
        String? prefix,
        Widget? suffix,
        bool obscure = false,
        List<TextInputFormatter>? inputFormatters,
        String? Function(String?)? validator,
        TextCapitalization textCapitalization = TextCapitalization.none,
        required TextEditingController controller}) {
      return TextFormField(
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        controller: controller,
        obscureText: obscure,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          prefixText: prefix,
          suffixIcon: suffix,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          enabledBorder: outline,
          errorBorder: outline,
          focusedErrorBorder: outline,
          focusedBorder: outline,
        ),
        onChanged: onChanged,
        validator: validator,
      );
    }

    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AuthService>(
          builder: (_) => Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Sign up',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center),
                    textField(
                      label: 'Phone Number',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: authService.phoneNumber,
                      prefix: '+91 ',
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Enter the Phone Number';
                        }
                        if (p0.length != 10) {
                          return 'Please Enter the Valid Phone Number';
                        }
                        return null;
                      },
                    ),
                    textField(
                      label: 'GST Number',
                      textCapitalization: TextCapitalization.characters,
                      controller: authService.gstNumber,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Enter the GST Number';
                        }

                        if (p0.isEmpty) {
                          return 'Please Verify the GST Name';
                        }
                        return null;
                      },
                    ),
                    MaterialButton(
                      onPressed: () async {
                        try {
                          await authService.gstSearch();
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      },
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text('Verify',
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text('Select a location'),
                        value: authService.addresses.isEmpty
                            ? null
                            : authService.selectedAddressIndex,
                        items: List.generate(
                          authService.addresses.length,
                          (index) {
                            final indexAddress = authService.addresses[index];
                            final List<String> addressParts = [
                              indexAddress.floorNumber,
                              indexAddress.buildingNumber,
                              indexAddress.buildingName,
                              indexAddress.street,
                              indexAddress.location,
                              '${indexAddress.state}-${indexAddress.pincode}'
                            ];

                            final formattedAddress = addressParts
                                .where((part) => part.trim().isNotEmpty)
                                .join(', ');

                            return DropdownMenuItem(
                              value: index,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(formattedAddress,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            );
                          },
                        ),
                        onChanged: (value) {
                          authService.selectedAddressIndex = value!;
                          authService.updateAddress();
                          authService.update();
                        },
                      ),
                    ),
                    textField(
                      label: 'Company Name',
                      controller: authService.companyName,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Select the Company Name';
                        }
                        return null;
                      },
                    ),
                    textField(
                      label: 'Company Address',
                      readOnly: true,
                      controller: authService.companyAddress,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Select the Company Address';
                        }
                        return null;
                      },
                    ),
                    textField(
                      label: 'PAN Number',
                      readOnly: true,
                      controller: authService.panNumber,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Verify the PAN number';
                        }
                        return null;
                      },
                    ),
                    textField(
                      label: 'Password',
                      controller: authService.password,
                      obscure: eye1,
                      inputFormatters: [LengthLimitingTextInputFormatter(12)],
                      suffix: IconButton(
                        onPressed: () {
                          eye1 = !eye1;
                          authService.update();
                        },
                        icon: Icon(eye1
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Enter the Password';
                        }
                        if (p0.length < 6) {
                          return 'Password has at least 6 Characters';
                        }
                        if (authService.password.text !=
                            authService.confirmPassword.text) {
                          return 'Password not Matched';
                        }
                        return null;
                      },
                    ),
                    textField(
                      label: 'Confirm Password',
                      controller: authService.confirmPassword,
                      obscure: eye2,
                      inputFormatters: [LengthLimitingTextInputFormatter(12)],
                      suffix: IconButton(
                        onPressed: () {
                          eye2 = !eye2;
                          authService.update();
                        },
                        icon: Icon(eye2
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Enter the Confirm Password';
                        }
                        if (p0.length < 6) {
                          return 'Password has at least 6 Characters';
                        }

                        if (authService.password.text !=
                            authService.confirmPassword.text) {
                          return 'Password not Matched';
                        }
                        return null;
                      },
                    ),
                    textField(
                        label: 'Referral Code',
                        controller: authService.referral),
                    Row(
                      children: [
                        Checkbox(
                          value: checkBoxChecked,
                          onChanged: (value) {
                            checkBoxChecked = !checkBoxChecked;
                            authService.update();
                          },
                        ),
                        Expanded(
                          child: Text(
                              'I agree to the Term of use & Privacy Policy'),
                        ),
                      ],
                    ),
                    MaterialButton(
                      onPressed: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            if (checkBoxChecked == false) {
                              Get.snackbar(
                                  'Error', 'Please Select the CheckBox');
                              return;
                            }

                            await authService.signUpRequest();

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(),
                              builder: (context) {
                                return GetBuilder<AuthService>(
                                  builder: (controller) => ConfirmSignUp(),
                                );
                              },
                            );
                          }
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      },
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text('Sign Up',
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    InkWell(
                        onTap: () {
                          Get.offAll(LoginPage());
                        },
                        child: Text('Already have an account? Sign in',
                            textAlign: TextAlign.center)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
