import 'package:autofon_seller/UI/TaxDeductions/ItDeduction.dart';
import 'package:autofon_seller/UI/TaxDeductions/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:autofon_seller/Controller/TaxDeduction_Service.dart';

import 'GstDeduction.dart';

class TaxDeductionsPage extends StatefulWidget {
  const TaxDeductionsPage({super.key});

  @override
  State<TaxDeductionsPage> createState() => _TaxDeductionsPageState();
}

class _TaxDeductionsPageState extends State<TaxDeductionsPage> {
  final taxController = Get.put(TaxDeductionService());
  List yearList = [];

  List<String> months = [
    "All",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  @override
  void initState() {
    generateYearList();
    super.initState();
  }

  void generateYearList() {
    int startYear = 2016;
    int currentYear = DateTime.now().year;
    for (int year = startYear; year <= currentYear; year++) {
      yearList.add({'year': 'FY $year-${year + 1}', 'value': year});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: taxController.instilize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    'Something went wrong Please Try again ${snapshot.error}'),
              );
            }

            return GetBuilder<TaxDeductionService>(
              builder: (_) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NavBar(),
                      DropdownButton(
                        isExpanded: true,
                        value: taxController.selectedMonth,
                        items: List.generate(
                            months.length,
                            (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(months[index]),
                                )),
                        onChanged: (value) {
                          taxController.selectedMonth = value!;
                          taxController.getData();
                          taxController.update();
                        },
                      ),
                      DropdownButton<int>(
                        value: taxController.selectedYear,
                        isExpanded: true,
                        items: List.generate(
                            yearList.length,
                            (index) => DropdownMenuItem<int>(
                                  value: yearList[index]['value'],
                                  child: Text(yearList[index]['year']),
                                )),
                        onChanged: (value) {
                          taxController.selectedYear =
                              value ?? DateTime.now().year;
                          taxController.getData();
                          taxController.update();
                        },
                      ),
                      taxController.selectedNavBar == 0
                          ? ItDeduction()
                          : GstDeduction(),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
