import 'package:autofon_seller/Authorization/ForgetPassword/ForgetPassword_Page.dart';
import 'package:autofon_seller/Authorization/LoginWithPhoneNumber/LoginWithPhoneNumberPage.dart';
import 'package:autofon_seller/UI/ProfilePage/ProfilePage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/Authorization_Service.dart';
import '../../Controller/Home_Service.dart';
import '../../UI/HomePage/Home_Page.dart';
import '../SignUp/SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool eyeStatus = true;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authService = Get.find<AuthService>();
  final homeController = Get.put(HomeService());
  final formKey = GlobalKey<FormState>();
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
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/images/logo.png"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    controller: phoneNumberController,
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
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    obscureText: eyeStatus,
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                    decoration: FieldDecrotion(
                      "Password",
                      suffix: IconButton(
                        onPressed: () {
                          eyeStatus = !eyeStatus;
                          setState(() {});
                        },
                        icon: Icon(!eyeStatus
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Password";
                      }
                      return null;
                    },
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          authService.resetPasswordPage = 0;
                          authService.update();
                          Get.to(ForgetPasswordPage());
                        },
                        child: const Text("Forget Password ?"),
                      )),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: InkWell(
                        onTap: () {
                          Get.to(SignUpPage());
                        },
                        child: const Text("Don't have an account? SignUp")),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await authService.getUser(phoneNumberController.text,
                              passwordController.text);
                          if (phoneNumberController.text.trim().toString() ==
                              authService.enteredNumber?.trim().toString()) {
                            authService.enteredNumber = null;
                            homeController.selectedHomePageIndex = 0;
                            Get.offAll(const ProfilePage());
                          } else {
                            Get.offAll(const HomePage());
                          }
                        } catch (e) {
                          Get.snackbar("Login Failed", e.toString(),
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      }
                    },
                    child: Text("Login",
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      Get.to(LoginWithPhoneNumberPage());
                    },
                    child: Text("Login With OTP",
                        style: Theme.of(context).textTheme.bodyMedium),
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
