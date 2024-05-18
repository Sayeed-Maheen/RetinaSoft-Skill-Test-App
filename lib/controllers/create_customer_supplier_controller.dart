import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateCustomerSupplierController extends GetxController {
  static const String baseUrl = 'https://skill-test.retinasoft.com.bd/api/v1';
  final _type = 0.obs;
  int get type => _type.value;
  set type(int value) => _type.value = value;

  Future<bool> createCustomer(
    String name,
    String phone,
    String email,
    String address,
    String area,
    String postCode,
    String city,
    String state,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final branchId = prefs.getString('branchId');
      final token = prefs.getString('accessToken');

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      };

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/admin/$branchId/customer/create'),
      );

      request.headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['type'] = '0'; // 0 for customer
      request.fields['address'] = address;
      request.fields['area'] = area;
      request.fields['post_code'] = postCode;
      request.fields['city'] = city;
      request.fields['state'] = state;

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Customer created successfully');
        return true;
      } else {
        print('Failed to create customer. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception occurred while creating customer: $e');
      return false;
    }
  }

  Future<bool> createSupplier(
    String name,
    String phone,
    String email,
    String address,
    String area,
    String postCode,
    String city,
    String state,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final branchId = prefs.getString('branchId');
      final token = prefs.getString('accessToken');

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      };

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/admin/$branchId/customer/create'),
      );

      request.headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['type'] = '1'; // 1 for supplier
      request.fields['address'] = address;
      request.fields['area'] = area;
      request.fields['post_code'] = postCode;
      request.fields['city'] = city;
      request.fields['state'] = state;

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Supplier created successfully');
        return true;
      } else {
        print('Failed to create supplier. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception occurred while creating supplier: $e');
      return false;
    }
  }
}
