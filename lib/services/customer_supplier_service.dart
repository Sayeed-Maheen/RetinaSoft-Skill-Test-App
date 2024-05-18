import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomerService {
  static const String baseUrl = 'https://skill-test.retinasoft.com.bd/api/v1';

  Future<List<dynamic>> fetchCustomers(int branchId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/admin/$branchId/0/customers'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['customers'] != null &&
            data['customers']['customers'] != null) {
          return List<dynamic>.from(data['customers']['customers']);
        } else {
          print('No customers found in the response');
          return [];
        }
      } else {
        print('Failed to load customers. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception occurred while fetching customers: $e');
      return [];
    }
  }
}

class SupplierService {
  static const String baseUrl = 'https://skill-test.retinasoft.com.bd/api/v1';

  Future<List<dynamic>> fetchSuppliers(int branchId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('$baseUrl/admin/$branchId/1/customers'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['customers'] != null &&
            data['customers']['customers'] != null) {
          return List<dynamic>.from(data['customers']['customers']);
        } else {
          print('No suppliers found in the response');
          return [];
        }
      } else {
        print('Failed to load suppliers. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception occurred while fetching suppliers: $e');
      return [];
    }
  }
}
