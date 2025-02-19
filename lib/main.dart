import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Controller/Authorization_Service.dart';
import 'Controller/Home_Service.dart';
import 'UI/HomePage/Home_Page.dart';
import 'UI/Splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleSmall: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              letterSpacing: 0),
          bodyLarge: GoogleFonts.poppins(
              fontSize: 23, color: Colors.black, fontWeight: FontWeight.bold),
          bodyMedium: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 0),
          bodySmall: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 0),
          headlineLarge: GoogleFonts.poppins(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          displayLarge: GoogleFonts.poppins(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          labelLarge: GoogleFonts.poppins(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          displaySmall: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 0),
          displayMedium: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0),
          labelMedium: GoogleFonts.poppins(
            fontSize: 17,
            letterSpacing: 0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          labelSmall: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 0),
        ),
        primaryColor: Colors.white,
        colorScheme: const ColorScheme(
            tertiary: Color.fromRGBO(206, 202, 202, 1.0),
            brightness: Brightness.light,
            primary: Color(0xff1B1B27),
            onPrimary: Colors.white,
            secondary: Color(0xffFFB23D),
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            onSurface: Color(0xff1B1B27),
            surface: Colors.white),
        appBarTheme: const AppBarTheme(
          color: Color(0xff1B1B27),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
