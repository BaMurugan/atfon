import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/Inquiries_Service.dart';
import 'InquiriOperation.dart';

class InquiriesPage extends StatefulWidget {
  const InquiriesPage({super.key});

  @override
  State<InquiriesPage> createState() => _InquiriesPageState();
}

class _InquiriesPageState extends State<InquiriesPage> {
  final inquirieServiceController = Get.put(InquirieService());
  final scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(fetchData);
    super.initState();
  }

  fetchData() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      inquirieServiceController.fetchDeta();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: InquiriOperation(
        function: () {
          setState(() {});
        },
      ),
      body: StreamBuilder(
        stream: inquirieServiceController.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text("Unable to Fetch Data Please Try Again Later"));
          }
          return GetBuilder<InquirieService>(
            builder: (_) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 3.5))),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text('Inquiries',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount:
                            inquirieServiceController.userInquiries.length,
                        itemBuilder: (context, index) {
                          final item =
                              inquirieServiceController.userInquiries[index];
                          return lineItems(item);
                        },
                      ),
                    )
                  ],
                )),
          );
        },
      ),
    ));
  }

  lineItems(dynamic item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface,
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text("Category")),
              Expanded(child: Text('${item.category}'))
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("Status")),
              Expanded(child: Text('${item.status}')),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("Message")),
              Expanded(child: Text('${item.message}')),
            ],
          ),
        ],
      ),
    );
  }
}
