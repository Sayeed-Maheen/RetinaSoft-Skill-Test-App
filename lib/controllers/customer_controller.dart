import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSupplierController extends GetxController {
  var isLoading = true.obs;
  var customerList = <dynamic>[].obs;
  var supplierList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllCustomersAndSuppliers();
  }

  Future<void> fetchAllCustomersAndSuppliers() async {
    isLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token == null) {
        throw Exception('No token found');
      }

      final branchesResponse = await http.get(
        Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/admin/branches'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (branchesResponse.statusCode == 200) {
        var branchesData = json.decode(branchesResponse.body);
        var branchesList = branchesData['branches'] ?? [];

        for (var branch in branchesList) {
          int branchId = branch['id'];
          await fetchCustomerAndSupplierForBranch(branchId);
        }
      } else {
        throw Exception('Failed to fetch branches');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCustomerAndSupplierForBranch(int branchId) async {
    try {
      final customerResponse = await http.get(
        Uri.parse(
            'https://skill-test.retinasoft.com.bd/api/v1/admin/$branchId/0/customers'),
      );

      final supplierResponse = await http.get(
        Uri.parse(
            'https://skill-test.retinasoft.com.bd/api/v1/admin/$branchId/1/customers'),
      );

      if (customerResponse.statusCode == 200 &&
          supplierResponse.statusCode == 200) {
        var customerData = json.decode(customerResponse.body);
        var supplierData = json.decode(supplierResponse.body);

        if (customerData is Map && customerData.containsKey('customers')) {
          var customers = customerData['customers'] as List<dynamic>;
          customerList.addAll(customers);
        }

        if (supplierData is Map && supplierData.containsKey('suppliers')) {
          var suppliers = supplierData['suppliers'] as List<dynamic>;
          supplierList.addAll(suppliers);
        }
      } else {
        throw Exception(
            'Failed to fetch customer and supplier data for branch $branchId');
      }
    } catch (e) {
      print('Error fetching data for branch $branchId: $e');
    }
  }
}
