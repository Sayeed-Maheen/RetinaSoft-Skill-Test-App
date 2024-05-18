import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_test_app/screens/login_screen.dart';
import 'package:skill_test_app/screens/my_bottom_nav.dart';
import 'package:skill_test_app/utils/app_colors.dart';

import '../utils/image_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Widget _initialScreen;
  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  Future<void> _checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken != null) {
      // User is logged in
      _initialScreen = const MyBottomNav();
    } else {
      // User is not logged in
      _initialScreen = const LoginScreen();
    }

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Get.offAll(_initialScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: Image.asset(
          appLogo,
          width: 250.w,
          height: 250.w,
        ),
      ),
    );
  }
}
