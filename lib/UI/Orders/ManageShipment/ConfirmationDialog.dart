import 'dart:async';

import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../Controller/Orders_Service.dart';

class ConfirmationDialog extends StatefulWidget {
  String shipmentID;
  ConfirmationDialog({super.key, required this.shipmentID});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
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
                              'Delivery Confirmation',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Enter the 4-digit OTP shared by the Delivery person.',
                              textAlign: TextAlign.center,
                            ),
                            Pinput(length: 4, controller: pinController),
                            seconds == 0
                                ? MaterialButton(
                                    onPressed: () async {
                                      Map body = {
                                        'isDisputeResendOtp': false,
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
                                        print(e.toString());
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
                                  'shipmentId': widget.shipmentID
                                };

                                try {
                                  await orderService.updateShipment(
                                      path:
                                          '${ApiPaths.sellerOrders}${ApiPaths.sellerVerifyOrder}',
                                      body: body);
                                } catch (e) {
                                  Get.snackbar('Error', e.toString());
                                  return;
                                }
                                try {
                                  await orderService.updateShipment(
                                      path:
                                          '${ApiPaths.sellerOrders}/${orderService.orderId}/deliver',
                                      body: {'shipmentId': widget.shipmentID});
                                } catch (e) {
                                  Get.snackbar('Error', e.toString());
                                  return;
                                }
                                Get.back();
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
            'Confirm',
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
