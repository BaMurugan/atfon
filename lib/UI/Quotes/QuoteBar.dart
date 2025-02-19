import 'package:autofon_seller/Controller/Quote_Service.dart';
import 'package:autofon_seller/Module/Quote_Module.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'QuoteBanner.dart';

class QuoteBar extends StatefulWidget {
  const QuoteBar({super.key});

  @override
  State<QuoteBar> createState() => _QuoteBarState();
}

class _QuoteBarState extends State<QuoteBar> {
  ScrollController scrollController = ScrollController();
  final control = Get.put(QuoteService());
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(fetchData);
    super.initState();
  }

  fetchData() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      control.nextSetData();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return StreamBuilder(
      stream: control.instilize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something Went Wrong Please Try Again "),
          );
        }
        if (control.quote.isEmpty) {
          return const Center(
            child: Text("No Quote Found"),
          );
        }
        return GetBuilder<QuoteService>(
          builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            color: theme.colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 1,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Quotes',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                    textAlign: TextAlign.center,
                    'Showing ${control.quotes!.data!.quotes!.isNotEmpty ? '1' : '0'}-${control.quotes!.data!.quotes!.length} of ${control.quotes!.data!.totalQuotes} Quotes'),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    color: theme.primaryColor,
                    child: RawScrollbar(
                      thumbColor: Theme.of(context).colorScheme.secondary,
                      thumbVisibility: true,
                      radius: Radius.circular(10),
                      trackVisibility: true,
                      controller: scrollController,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: controller.quote.length,
                        itemBuilder: (context, index) {
                          return QuoteBanner(quote: controller.quote[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
