import 'dart:async';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../Controller/Orders_Service.dart';

class DisputeVerificationDialog extends StatefulWidget {
  String shipmentID;
  DisputeVerificationDialog({super.key, required this.shipmentID});

  @override
  State<DisputeVerificationDialog> createState() =>
      _DisputeVerificationDialogState();
}

class _DisputeVerificationDialogState extends State<DisputeVerificationDialog> {
  final orderService = Get.find<OrderService>();
  Timer? timer;
  int seconds = 120;
  TextEditingController pinController = TextEditingController();

  startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (seconds == 0) {
          timer.cancel();
        } else {
          seconds -= 1;
        }
        orderService.update();
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
    return GetBuilder<OrderService>(
      builder: (_) {
        return InkWell(
          onTap: () {
            seconds = 120;
            startTimer();
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: RoundedRectangleBorder(),
              builder: (context) {
                return Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: GetBuilder<OrderService>(
                    builder: (_) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Dispute Verification',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Enter the OTP received for dispute verification.',
                              textAlign: TextAlign.center,
                            ),
                            Pinput(length: 4, controller: pinController),
                            seconds == 0
                                ? MaterialButton(
                                    onPressed: () async {
                                      Map body = {
                                        'isDisputeResendOtp': true,
                                        'shipmentId': widget.shipmentID,
                                      };

                                      try {
                                        seconds = 120;
                                        startTimer();
                                        await orderService.updateShipment(
                                            path:
                                                '${ApiPaths.sellerOrders}${ApiPaths.sellerSendDeliveryConfirmation}',
                                            body: body);
                                      } catch (e) {
                                        Get.snackbar('Error', e.toString());
                                      }
                                    },
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Text('Resend',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  )
                                : Text(
                                    'Resend OTP in: $seconds',
                                    textAlign: TextAlign.center,
                                  ),
                            MaterialButton(
                              onPressed: () async {
                                Map body = {
                                  'code': int.parse(pinController.text),
                                  'isDisputeOtp': true,
                                  'orderId': orderService.orderId,
                                  'shipmentId': widget.shipmentID
                                };

                                try {
                                  await orderService.updateShipment(
                                      path:
                                          '${ApiPaths.sellerOrders}${ApiPaths.sellerVerifyOrder}',
                                      body: body);
                                  Get.back();
                                } catch (e) {
                                  Get.snackbar('Error', e.toString());
                                }
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text(
                                'Confirm OTP',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          child: Text(
            'Dispute Verification',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
