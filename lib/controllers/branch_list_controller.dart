import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/branch_list_model.dart';

class BranchController extends GetxController {
  var branches = <Branch>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchBranches();
    super.onInit();
  }

  Future<void> fetchBranches() async {
    try {
      isLoading(true);

      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      print('Retrieved token: $token');
      if (token == null) {
        Get.snackbar('Error', 'No token found');
        return;
      }

      final response = await http.get(
        Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/admin/branches'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print("Response data: $jsonData"); // Log the response data

        // Extract the nested branches list
        var branchesList = List<Branch>.from(jsonData['branches']['branches']
            .map((json) => Branch.fromJson(json)));
        branches.assignAll(branchesList);
      } else {
        Get.snackbar('Error', 'Failed to fetch branches');
        print('Error: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch branches: $e');
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
