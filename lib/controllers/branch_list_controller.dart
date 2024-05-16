import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

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
        CustomToast.showToast("Error, ${'No token found'}");
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
        CustomToast.showToast("Error, ${'Failed to fetch branches'}");
        print('Error: ${response.body}');
      }
    } catch (e) {
      CustomToast.showToast("Error, ${'Failed to fetch branches: $e'}");
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateBranch(Branch branch) async {
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
            'https://skill-test.retinasoft.com.bd/api/v1/admin/branch/${branch.id}/update'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(branch.toJson()),
      );

      print('Update Response status: ${response.statusCode}');
      print('Update Response body: ${response.body}');

      if (response.statusCode == 200) {
        CustomToast.showToast("Branch updated successfully");
        await fetchBranches();
        // You may update the local list if needed
      } else {
        CustomToast.showToast("Error, ${'Failed to update branch'}");
        print('Error: ${response.body}');
      }
    } catch (e) {
      CustomToast.showToast("Error, ${'Failed to update branch: $e'}");
      print('Error: $e');
    }
  }

  Future<void> deleteBranch(int branchId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      print('Retrieved token: $token');
      if (token == null) {
        CustomToast.showToast("Error, ${'No token found'}");
        return;
      }

      final response = await http.delete(
        Uri.parse(
            'https://skill-test.retinasoft.com.bd/api/v1/admin/branch/$branchId/delete'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Delete Response status: ${response.statusCode}');
      print('Delete Response body: ${response.body}');

      if (response.statusCode == 200) {
        CustomToast.showToast("Branch deleted successfully");
        await fetchBranches();
      } else {
        CustomToast.showToast("Error, ${'Failed to delete branch'}");
        print('Error: ${response.body}');
      }
    } catch (e) {
      CustomToast.showToast("Error, ${'Failed to delete branch: $e'}");
      print('Error: $e');
    }
  }
}
