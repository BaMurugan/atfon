import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/TaxDeduction_Service.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final taxController = Get.find<TaxDeductionService>();
  @override
  Widget build(BuildContext context) {
    navItems(String name, int index) {
      return Container(
        decoration: BoxDecoration(
          color: taxController.selectedNavBar == index
              ? Theme.of(context).colorScheme.secondary
              : null,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Text(name),
      );
    }

    return GetBuilder<TaxDeductionService>(
      builder: (_) => Container(
        decoration: BoxDecoration(border: Border.all(width: 2.5)),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  taxController.selectedNavBar = 0;
                  taxController.getData();

                  taxController.update();
                },
                child: navItems('IT Deductions', 0),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  taxController.selectedNavBar = 1;
                  taxController.getData();
                  taxController.update();
                },
                child: navItems('GST Deductions', 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
