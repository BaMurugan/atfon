import 'package:autofon_seller/Controller/BankDetails_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'EditBankDetails.dart';

class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({super.key});

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  final bankDetailService = Get.put(BankDetailService());
  @override
  Widget build(BuildContext context) {
    lineItems(String key, String value) {
      return Row(
        children: [
          Expanded(child: Text(key)),
          Expanded(child: Text(value)),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: EditBankDetails(
          action: () {
            setState(() {});
          },
        ),
        body: StreamBuilder(
          stream: bankDetailService.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('Something Went wrong Please try again'));
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.5,
                      )),
                    ),
                    child: Text('Bank Details',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  (bankDetailService.bankDetailModule.data!.bankAccountNumber !=
                          null)
                      ? Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            lineItems(
                                'Bank Account Name',
                                bankDetailService.bankDetailModule.data?.name ??
                                    "N/A"),
                            lineItems(
                                'Bank Account Number',
                                bankDetailService.bankDetailModule.data
                                        ?.bankAccountNumber ??
                                    "N/A"),
                            lineItems(
                                'Bank Name',
                                bankDetailService
                                        .bankDetailModule.data?.bankName ??
                                    'N/A'),
                            lineItems(
                                'IFSC Code',
                                bankDetailService.bankDetailModule.data?.ifsc ??
                                    'N/A'),
                            lineItems(
                                'UPI ID',
                                bankDetailService
                                        .bankDetailModule.data?.upiId ??
                                    "N/A"),
                            lineItems(
                                'Bank Document ID',
                                bankDetailService
                                        .bankDetailModule.data?.bankFileName ??
                                    'N/A'),
                            bankDetailService
                                        .bankDetailModule.data!.bankFileUrl ==
                                    null
                                ? SizedBox()
                                : MaterialButton(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Text(
                                        'Click here to Download Bank Documents',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    onPressed: () async {
                                      try {
                                        await launchUrl(
                                            Uri.parse(bankDetailService
                                                .bankDetailModule
                                                .data!
                                                .bankFileUrl),
                                            mode: LaunchMode.inAppBrowserView);
                                      } catch (e) {
                                        Get.snackbar(
                                            'Error', 'Unable to Download');
                                      }
                                    },
                                  ),
                          ],
                        )
                      : Text('No Bank Details Added')
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
