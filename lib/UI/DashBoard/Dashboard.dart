import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/Home_Service.dart';
import '../../Module/Statistics_Module.dart';
import '../../Controller/Dashboard_Service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final control = Get.find<HomeService>();
  @override
  Widget build(BuildContext context) {
    statisticsBanner(String title, dynamic value, {String? convience}) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w500,
                fontSize: 28,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Text(
                "$value",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            convience == null
                ? const SizedBox()
                : Text(
                    "Conversion $convience%",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
          ],
        ),
      );
    }

    return Scaffold(
        body: StreamBuilder<Statistics>(
      stream: DashboadService.getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          Statistics stat = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                statisticsBanner("Total Sales", "Rs.${stat.revenue}"),
                GestureDetector(
                  onTap: () {
                    control.selectedHomePageIndex = 3;

                    control.update();
                  },
                  child: statisticsBanner(
                      "Total Enquiries", '${stat.quoteEnquiries}'),
                ),
                GestureDetector(
                  onTap: () {
                    control.selectedHomePageIndex = 4;

                    control.update();
                  },
                  child: statisticsBanner("Total Quotes", '${stat.quotes}'),
                ),
                GestureDetector(
                  onTap: () {
                    control.selectedHomePageIndex = 5;

                    control.update();
                  },
                  child: statisticsBanner("Total Orders", '${stat.orders}',
                      convience: '${stat.conversionRate}'),
                ),
                statisticsBanner("Active Quotes", '${stat.submittedQuotes}'),
                statisticsBanner("Active Orders", '${stat.paidOrders}'),
              ],
            ),
          );
        } else {
          return const Center(child: Text("No Data Found"));
        }
      },
    ));
  }
}
