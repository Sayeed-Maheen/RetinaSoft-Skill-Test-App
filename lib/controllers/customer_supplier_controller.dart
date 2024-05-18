import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/customer_supplier_service.dart';

class CustomerSupplierController extends GetxController {
  static const String baseUrl = 'https://skill-test.retinasoft.com.bd/api/v1';
  final CustomerService _customerService = CustomerService();
  final SupplierService _supplierService = SupplierService();

  var customers = <dynamic>[].obs;
  var suppliers = <dynamic>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
    fetchSuppliers();
  }

  Future<void> fetchCustomers() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final branchIdString = prefs.getString('branchId');
      if (branchIdString != null) {
        final branchId = int.parse(branchIdString); // Convert String to int
        final data = await _customerService.fetchCustomers(branchId);
        customers.value = data;
        print('Fetched ${data.length} customers');
      } else {
        print('Branch ID not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching customers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSuppliers() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final branchIdString = prefs.getString('branchId');
      if (branchIdString != null) {
        final branchId = int.parse(branchIdString); // Convert String to int
        final data = await _supplierService.fetchSuppliers(branchId);
        suppliers.value = data;
        print('Fetched ${data.length} suppliers');
      } else {
        print('Branch ID not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching suppliers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteCustomerSupplier(int id, bool isCustomer) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final branchId = prefs.getString('branchId');
      final token = prefs.getString('accessToken');
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final response = await http.delete(
        Uri.parse('$baseUrl/admin/$branchId/customer/$id/delete'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        print('${isCustomer ? 'Customer' : 'Supplier'} deleted successfully');
        // Optionally, you can refresh the data after successful deletion
        fetchCustomers();
        fetchSuppliers();
        return true;
      } else {
        print(
            'Failed to delete ${isCustomer ? 'customer' : 'supplier'}. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print(
          'Exception occurred while deleting ${isCustomer ? 'customer' : 'supplier'}: $e');
      return false;
    }
  }
}
