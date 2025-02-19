import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../Controller/Authorization_Service.dart';
import '../Login/LoginPage.dart';

class ConfirmSignUp extends StatefulWidget {
  const ConfirmSignUp({super.key});

  @override
  State<ConfirmSignUp> createState() => _ConfirmSignUpState();
}

class _ConfirmSignUpState extends State<ConfirmSignUp> {
  final authService = Get.find<AuthService>();
  int seconds = 120;
  Timer? timer;

  startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (seconds >= 0) {
          seconds -= 1;

          authService.update();
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthService>(
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 10,
            children: [
              Text('OTP Verification', textAlign: TextAlign.center),
              Pinput(
                length: 6,
                controller: authService.pinController,
              ),
              Container(
                child: seconds > 0
                    ? Text(
                        'Resent OTP in $seconds Seconds ',
                        textAlign: TextAlign.center,
                      )
                    : InkWell(
                        onTap: () async {
                          try {
                            await authService.resendrequestOTP();
                            seconds = 120;
                            startTimer();
                          } catch (e) {
                            Get.snackbar('Error', e.toString());
                          }
                        },
                        child: Text(
                          'Resend OTP',
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
              MaterialButton(
                onPressed: () async {
                  try {
                    await authService.confirmSignUp();

                    Get.snackbar('Success', 'Login to Continue');
                    timer?.cancel();
                    Get.back();
                    Get.offAll(LoginPage());
                  } catch (e) {
                    Get.snackbar('Error', e.toString());
                  }
                },
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  'Verify OTP',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
