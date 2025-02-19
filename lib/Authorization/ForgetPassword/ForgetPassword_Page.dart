import 'package:autofon_seller/Authorization/ForgetPassword/RequestForgetPassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Authorization_Service.dart';
import 'ChangePassword.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AuthService>(
          builder: (_) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: authService.resetPasswordPage == 0
                ? RequestForgetPassword()
                : ChangePassword(),
          ),
        ),
      ),
    );
  }
}
