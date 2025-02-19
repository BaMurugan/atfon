import 'package:autofon_seller/Authorization/Login/LoginPage.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/Authorization_Service.dart';
import '../Controller/Home_Service.dart';
import '../Controller/Profile_Service.dart';
import '../Other Service/ApiPath.dart';
import '../Other Service/ApiService.dart';

import 'HomePage/Home_Page.dart';
import 'Map/Controller/Mapview_Service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authService = Get.put(AuthService());
  final mapviewService = Get.put(MapViewService());
  @override
  void initState() {
    // TODO: implement initState
    _init();
    super.initState();
  }

  _init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final token = HiveService.getAuthToken();

        if (token.isNotEmpty) {
          try {
            await authService.existingUser();
            Get.offAll(HomePage());
          } catch (e) {
            print("Error in existing user check: $e");
            await Future.delayed(Duration(seconds: 2));
            Get.offAll(LoginPage());
          }
        } else {
          Get.offAll(LoginPage());
        }
      } catch (e) {
        print("Error during login check: $e");

        Get.offAll(LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Center(
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
