import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_test_app/screens/dashboard_screen.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

class BranchCreateController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  var isLoading = false.obs;

  Future<void> createBranch() async {
    final name = nameController.text;

    if (name.isEmpty) {
      CustomToast.showToast("Error, ${'Please enter a branch name'}");
      return;
    }

    isLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      print('Retrieved token: $token');

      if (token == null) {
        CustomToast.showToast("Error, ${'No token found'}");
        return;
      }

      final response = await http.post(
        Uri.parse(
            'https://skill-test.retinasoft.com.bd/api/v1/admin/branch/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 200) {
          CustomToast.showToast("Success', 'Branch created successfully");
          nameController.clear();
          Get.off(() => DashboardScreen());
        } else {
          CustomToast.showToast("Error, ${jsonData['msg']}");
        }
      } else {
        CustomToast.showToast("Error, ${'Failed to create branch'}");
      }
    } catch (e) {
      CustomToast.showToast("Error, ${'An error occurred: $e'}");
    } finally {
      isLoading(false);
    }
  }
}
