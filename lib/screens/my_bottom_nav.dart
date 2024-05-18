import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skill_test_app/screens/profile_screen.dart';

import '../utils/app_colors.dart';
import '../utils/strings.dart';
import 'dashboard_screen.dart';

class MyBottomNav extends StatefulWidget {
  const MyBottomNav({Key? key}) : super(key: key);

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _currentIndex = 0;

  List<Widget> tabs = [
    DashboardScreen(),
    ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
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
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        height: 60.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: const Offset(0, 2),
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
          color: colorWhite,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          backgroundColor: colorWhite,
          selectedItemColor: colorBlack,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.dashboard,
                  color: _currentIndex == 0 ? colorGreen : colorGrey,
                ),
              ),
              label: dashboard,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.person,
                  color: _currentIndex == 1 ? colorGreen : colorGrey,
                ),
              ),
              label: profile,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
