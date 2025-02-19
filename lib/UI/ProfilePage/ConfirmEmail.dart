import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../Controller/Profile_Service.dart';

class ConfirmEmail extends StatefulWidget {
  VoidCallback action;
  ConfirmEmail({super.key, required this.action});

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  Timer? timer;
  int seconds = 120;
  final profileController = Get.find<ProfileService>();

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    profileController.pinController.clear();
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (seconds > -1) {
          seconds -= 1;
          setState(() {});
        }
        if (seconds == 0) {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileService>(
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  "Please Confirm Your OTP Sent to Your Registered Email",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Pinput(
                  length: 6,
                  controller: profileController.pinController,
                ),
                seconds > 0
                    ? Text(
                        'Resend OTP in ${seconds}s',
                        textAlign: TextAlign.center,
                      )
                    : MaterialButton(
                        onPressed: () {
                          profileController.requestEdit();
                          seconds = 120;
                          startTimer();
                          FocusScope.of(context).unfocus();
                        },
                        color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          'Resend OTP',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                MaterialButton(
                  onPressed: profileController.pinController.text.length != 6
                      ? () {}
                      : () async {
                          try {
                            FocusScope.of(context).unfocus();
                            await profileController.verifyEdit();
                            await profileController.setInstilize();
                            Get.back();
                            widget.action();
                          } catch (e) {
                            Get.snackbar('Error', e.toString());
                          }
                        },
                  color: profileController.pinController.text.length != 6
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Verify',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
