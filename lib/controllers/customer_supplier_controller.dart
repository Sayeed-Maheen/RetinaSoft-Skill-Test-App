import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/customer_supplier_service.dart';

class CustomerSupplierController extends GetxController {
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
}
