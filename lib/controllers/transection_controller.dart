import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/transection_screen.dart';

class TransactionController extends GetxController {
  final transactions = <Transaction>[].obs;
  final isLoading = true.obs;
  late int branchId;
  late int customerId;

  @override
  void onInit() {
    super.onInit();
    fetchBranchId();
  }

  Future<void> fetchBranchId() async {
    final prefs = await SharedPreferences.getInstance();
    branchId = prefs.getInt('branchId') ?? 0;
    fetchCustomerId();
  }

  Future<void> fetchCustomerId() async {
    try {
      isLoading(true);
      final url =
          'https://skill-test.retinasoft.com.bd/api/v1/admin/$branchId/customers';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        customerId =
            data[0]['id']; // Assuming the first customer ID is the desired one
        fetchTransactions();
      } else {
        // Handle error
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading(true);
      final url =
          'https://skill-test.retinasoft.com.bd/api/v1/admin/$branchId/customer/$customerId/transactions';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        transactions.value =
            List<Transaction>.from(data.map((x) => Transaction.fromJson(x)));
      } else {
        // Handle error
      }
    } finally {
      isLoading(false);
    }
  }
}

// Transaction class remains the same
