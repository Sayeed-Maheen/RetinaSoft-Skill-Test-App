import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateCustomerSupplierService {
  static const String baseUrl = 'https://skill-test.retinasoft.com.bd/api/v1';

  Future<void> updateRecord({
    required int branchId,
    required int recordId,
    required Map<String, dynamic> updatedData,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token != null) {
        final response = await http.put(
          Uri.parse('$baseUrl/admin/$branchId/$recordId/update'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(updatedData),
        );

        if (response.statusCode == 200) {
          print('Record updated successfully');
        } else {
          print('Failed to update record. Status code: ${response.statusCode}');
          throw Exception('Failed to update record');
        }
      } else {
        print('Access token not found in SharedPreferences');
        throw Exception('Access token not found');
      }
    } catch (e) {
      print('Exception occurred while updating record: $e');
      throw e;
    }
  }
}
