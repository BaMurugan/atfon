import 'package:autofon_seller/Controller/Home_Service.dart';
import 'package:autofon_seller/Controller/Orders_Service.dart';
import 'package:autofon_seller/Module/Profile_Model.dart';

import 'package:autofon_seller/UI/ProductManagement/ProductManagement.dart';
import 'package:autofon_seller/UI/HomePage/HomeDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../Areamanagement/Areamanage_Page.dart';
import '../DashBoard/Dashboard.dart';
import '../DriverManagement/DriverManagement_Page.dart';
import '../Enquiris/EnquirieBar.dart';
import '../Notification/NotificationPage.dart';
import '../Orders/OrdersBar.dart';
import '../ProductPage/Product.dart';
import '../Quotes/QuoteBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final control = Get.find<HomeService>();
  final orderService = Get.put(OrderService());

  List pages = [
    const Dashboard(),
    const ProductPage(),
    const ProductManagement(),
    const EnquirieBar(),
    const QuoteBar(),
    const OrdersBar(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    control.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeService>(builder: (_) {
      return SafeArea(
        child: Scaffold(
          bottomSheet: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Version 19.2.1',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          key: _scaffoldKey,
          drawer: const HomeDrawer(),
          appBar: AppBar(
            leading: Row(
              children: [
                const SizedBox(width: 10),
                InkWell(
                  child: const Icon(FontAwesomeIcons.solidUser,
                      color: Colors.white),
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
            actions: [
              control.available
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Theme.of(context).colorScheme.error,
                      ),
                      child: Text(
                        'ENQ : OFF',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
              const SizedBox(width: 10),
              InkWell(
                child:
                    const Icon(FontAwesomeIcons.solidBell, color: Colors.white),
                onTap: () {
                  Get.to(NotificationPage());
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: pages[control.selectedHomePageIndex],
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Theme.of(context).colorScheme.onSurface,
            unselectedItemColor: Theme.of(context).colorScheme.onSurface,
            currentIndex: control.selectedHomePageIndex,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: (value) {
              control.selectedHomePageIndex = value;

              control.update();
            },
            selectedFontSize: 12,
            unselectedFontSize: 10,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.cube),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  child: Icon(FontAwesomeIcons.layerGroup),
                ),
                label: 'Product Management',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.doc_text),
                label: 'Enquiries',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.gear),
                label: 'Quotes',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.globe),
                label: 'Orders',
              )
            ],
          ),
        ),
      );
    });
  }
}
