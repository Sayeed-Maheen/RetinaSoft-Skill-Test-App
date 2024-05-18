// update_customer_supplier_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateCustomerSupplierController extends GetxController {
  static const String baseUrl = 'https://skill-test.retinasoft.com.bd/api/v1';

  Future<bool> updateCustomerSupplier(
    int id,
    String name,
    String phone,
    String email,
    String address,
    String area,
    String postCode,
    String city,
    String state,
    bool isCustomer,
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
        Uri.parse('$baseUrl/admin/$branchId/customer/$id/update'),
      );
      request.headers.addAll(headers);
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['type'] = isCustomer ? '0' : '1';
      request.fields['address'] = address;
      request.fields['area'] = area;
      request.fields['post_code'] = postCode;
      request.fields['city'] = city;
      request.fields['state'] = state;

      final response = await request.send();
      if (response.statusCode == 200) {
        print('${isCustomer ? 'Customer' : 'Supplier'} updated successfully');
        return true;
      } else {
        print(
            'Failed to update ${isCustomer ? 'customer' : 'supplier'}. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print(
          'Exception occurred while updating ${isCustomer ? 'customer' : 'supplier'}: $e');
      return false;
    }
  }
}
