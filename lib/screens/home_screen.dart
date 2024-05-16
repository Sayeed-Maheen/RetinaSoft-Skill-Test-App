import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/logout_controller.dart';

class HomeScreen extends StatelessWidget {
  final LogoutController _logoutController = Get.put(LogoutController());

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logoutController.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
