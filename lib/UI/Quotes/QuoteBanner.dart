import 'package:autofon_seller/Module/Quote_Module.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Controller/Quote_Service.dart';
import '../Quote Quotation/QuoteQuotationPage.dart';

class QuoteBanner extends StatefulWidget {
  Quote quote;
  QuoteBanner({super.key, required this.quote});

  @override
  State<QuoteBanner> createState() => _QuoteBannerState();
}

class _QuoteBannerState extends State<QuoteBanner> {
  @override
  Widget build(BuildContext context) {
    final quoteControl = Get.find<QuoteService>();
    Quote quote = widget.quote;
    bool hasFunction = (quote.quoteRequestStatus == "Open");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: hasFunction
              ? Colors.white
              : Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)]),
      child: Column(
        children: [
          lineData(
              "Received Data",
              DateFormat("dd MMM yyyy")
                  .format(quote.createdAt ?? DateTime.now())),
          lineData("No Of Products", "${quote.lineItemsCount}"),
          lineData("Value (inclusive of GST)", "Rs. ${quote.totalPrice}"),
          lineData("Status", "${quote.status}"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: hasFunction
                    ? () {
                        Get.to(QuoteQuotationPage(quotationId: quote.id!));
                        quoteControl.getData();
                      }
                    : () {},
                child: Text(quote.status == "Draft" ? "Continue" : "View"),
              ),
              InkWell(
                onTap: hasFunction
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            shape: const RoundedRectangleBorder(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                      "Are you sure you want to delete the quote?"),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: const Text("No"),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          try {
                                            await quoteControl
                                                .deleteQuote(quote.id!);
                                            Get.back();
                                            Get.snackbar("Success",
                                                "Quote Delete Successfully");
                                          } catch (e) {
                                            Get.back();
                                            Get.snackbar("Alert",
                                                "Unable to delete Quote");
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: const Text("Yes"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    : () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

lineData(String t1, String t2) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Text(t1),
        ),
        Expanded(
          child: Text(t2),
        )
      ],
    ),
  );
}
