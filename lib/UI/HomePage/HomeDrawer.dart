import 'package:autofon_seller/Authorization/Login/LoginPage.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:autofon_seller/UI/Areamanagement/Areamanage_Page.dart';
import 'package:autofon_seller/UI/ChangePassword/Changepassword_Page.dart';
import 'package:autofon_seller/UI/ContactUsPage/ContactUs.dart';
import 'package:autofon_seller/UI/DriverManagement/DriverManagement_Page.dart';
import 'package:autofon_seller/UI/Inquiries/Inquiries_Page.dart';
import 'package:autofon_seller/UI/ProfilePage/ProfilePage.dart';
import 'package:autofon_seller/UI/SelfPickup/SelfPickUp_Page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/Home_Service.dart';
import '../../Module/Profile_Model.dart';
import '../BankDetails/BankDetails_Page.dart';
import '../OtherPage/Other_Page.dart';
import '../PaymentBalance/PaymentBalance_Page.dart';
import '../SellerProduct/SellerProductPage.dart';
import '../StoreLocation/StoreLocation_Page.dart';
import '../TaxDeductions/TaxDeductions_Page.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final control = Get.find<HomeService>();

  @override
  Widget build(BuildContext context) {
    ProfileModel model = control.profileData;

    drawerMenu(
        {required String title,
        required IconData icon,
        required VoidCallback onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 3.5,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
              ),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
        ),
      );
    }

    return GetBuilder<HomeService>(
      builder: (_) => Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      model.name?[0] ?? "",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.name ?? ""),
                          Text(model.email ?? ""),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    drawerMenu(
                      title: "Profile",
                      icon: FontAwesomeIcons.solidCircleUser,
                      onTap: () {
                        Get.to(ProfilePage());
                      },
                    ),
                    drawerMenu(
                      title: "Store Location",
                      icon: FontAwesomeIcons.locationDot,
                      onTap: () {
                        Get.to(StoreLocationPage());
                      },
                    ),
                    drawerMenu(
                      title: "Payment Balance",
                      icon: FontAwesomeIcons.handHoldingDollar,
                      onTap: () {
                        Get.to(const PaymentBalancePage());
                      },
                    ),
                    drawerMenu(
                      title: "Tax Deductions",
                      icon: FontAwesomeIcons.bank,
                      onTap: () {
                        Get.to(TaxDeductionsPage());
                      },
                    ),
                    drawerMenu(
                      title: "Bank Details",
                      icon: FontAwesomeIcons.moneyBillTransfer,
                      onTap: () {
                        Get.to(BankDetailsPage());
                      },
                    ),
                    drawerMenu(
                      title: "Area Management",
                      icon: FontAwesomeIcons.gear,
                      onTap: () {
                        Get.to(AreaManagePage());
                      },
                    ),
                    drawerMenu(
                      title: "Self Pickup",
                      icon: FontAwesomeIcons.truckFast,
                      onTap: () {
                        Get.to(SelfPickUpPage());
                      },
                    ),
                    drawerMenu(
                      title: "Driver Management",
                      icon: FontAwesomeIcons.globe,
                      onTap: () {
                        Get.to(DriverManagementPage());
                      },
                    ),
                    drawerMenu(
                      title: "Inquiries",
                      icon: FontAwesomeIcons.magnifyingGlass,
                      onTap: () {
                        Get.to(InquiriesPage());
                      },
                    ),
                    drawerMenu(
                      title: "Seller Product Request",
                      icon: FontAwesomeIcons.boxesPacking,
                      onTap: () {
                        Get.to(SellerProductsPage());
                      },
                    ),
                    drawerMenu(
                      title: "Change Password",
                      icon: FontAwesomeIcons.unlock,
                      onTap: () {
                        Get.to(const ChangePasswordPage());
                      },
                    ),
                    drawerMenu(
                      title: "Contact Us",
                      icon: FontAwesomeIcons.phone,
                      onTap: () {
                        Get.to(const ContactUs());
                      },
                    ),
                    drawerMenu(
                      title: "Others",
                      icon: FontAwesomeIcons.commentDots,
                      onTap: () {
                        Get.to(const OthersPage());
                      },
                    ),
                    drawerMenu(
                      title: "Logout",
                      icon: FontAwesomeIcons.signOut,
                      onTap: () {
                        HiveService.deleteAuthToken();
                        Get.offAll(const LoginPage());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
