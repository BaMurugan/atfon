import 'package:autofon_seller/Module/Enquirie_Module.dart';
import 'package:autofon_seller/Controller/Enquiri_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'EnquiriBanner.dart';

class EnquirieBar extends StatefulWidget {
  const EnquirieBar({super.key});

  @override
  State<EnquirieBar> createState() => _EnquirieBarState();
}

class _EnquirieBarState extends State<EnquirieBar> {
  ScrollController scrollController = ScrollController();
  final enquiryContol = Get.put(EnquiriService());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    scrollController.addListener(
      () {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
          enquiryContol.fetchNextData();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return StreamBuilder(
      stream: enquiryContol.instilize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                  color: theme.colorScheme.onSurface));
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Unable to Get Data ${snapshot.error.toString()}",
                  style: theme.textTheme.displayLarge));
        }
        if (enquiryContol.enquiry.isEmpty) {
          return Center(
              child:
                  Text("No Enquiries Found", style: theme.textTheme.bodySmall));
        }
        return GetBuilder<EnquiriService>(
          builder: (controller) => RefreshIndicator(
            onRefresh: () async {
              await controller.getData();
              controller.update();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              color: theme.colorScheme.surface,
              child: RawScrollbar(
                thumbColor: Theme.of(context).colorScheme.secondary,
                thumbVisibility: true,
                radius: Radius.circular(10),
                trackVisibility: true,
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Enquiries',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                            textAlign: TextAlign.center,
                            'Showing ${enquiryContol.enquiry.isNotEmpty ? '1' : '0'}-${enquiryContol.enquiry.length} of ${enquiryContol.quoteEnquiry.data!.totalQuoteEnquiries} Enquiries'),
                        ...List.generate(
                          controller.enquiry.length,
                          (index) {
                            final QuoteEnquiry quote =
                                controller.enquiry[index];
                            if (DateTime.now()
                                    .difference(
                                        DateTime.parse("${quote.validUntil}"))
                                    .isNegative ==
                                false) {
                              return const SizedBox();
                            }
                            return EnquiriBanner(quote: quote);
                          },
                        ),
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
