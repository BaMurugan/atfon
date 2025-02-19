import 'package:autofon_seller/Controller/Profile_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletBalance extends StatefulWidget {
  const WalletBalance({super.key});

  @override
  State<WalletBalance> createState() => _WalletBalanceState();
}

class _WalletBalanceState extends State<WalletBalance> {
  final profileController = Get.find<ProfileService>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileService>(
      builder: (controller) => Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text('Wallet Balance'),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Text('Wallet Transaction History'),
                            Expanded(
                                child: Center(
                              child: Text('No Wallet transactions available'),
                            ))
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  profileController.walletBalance.data?.balance ?? '0',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
