import 'package:autofon_seller/Module/WalletData_Module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/PaymentBalance_Service.dart';
import 'Transctions.dart';

class PaymentBalancePage extends StatefulWidget {
  const PaymentBalancePage({super.key});

  @override
  State<PaymentBalancePage> createState() => _PaymentBalancePageState();
}

class _PaymentBalancePageState extends State<PaymentBalancePage> {
  final paymentBalance = Get.put(PaymentBalanceService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Payment Balance",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: StreamBuilder<WalletData>(
        stream: paymentBalance.getWallet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          return TransctionsWidget();
        },
      ),
    );
  }
}
