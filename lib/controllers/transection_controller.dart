import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

import '../models/transaction_model.dart';

class TransactionController extends GetxController {
  final transactions = <Transaction>[].obs;
  final isLoading = true.obs;
  late int branchId;
  late int customerId;
  final baseUrl = 'https://skill-test.retinasoft.com.bd/api/v1';

  @override
  void onInit() {
    super.onInit();
    fetchBranchId();
  }

  Future<void> fetchBranchId() async {
    final prefs = await SharedPreferences.getInstance();
    final branchIdString = prefs.getString('branchId');
    if (branchIdString != null) {
      branchId = int.parse(branchIdString);
    } else {
      branchId = 0; // or any default value you want to set
    }
    fetchCustomerId();
  }

  Future<void> fetchCustomerId() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      if (token == null) {
        print('Error: No token found');
        CustomToast.showToast('Error: No token found');
        return;
      }

      final url = '$baseUrl/admin/$branchId/0/customers';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Customer ID Response status code: ${response.statusCode}');
      print('Customer ID Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final customersData = responseBody['customers'];
        final customersList = customersData['customers'];

        if (customersList is List && customersList.isNotEmpty) {
          customerId = customersList[0]['id'];
          fetchTransactions();
        } else {
          // Handle the case when the response data is empty or null
          print('Error: Empty or null response data');
          CustomToast.showToast('Error: Empty or null response data');
          customerId = 0; // or any default value you want to set
          transactions.clear();
        }
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        CustomToast.showToast('Error: ${response.statusCode}');
        transactions.clear();
      }
    } catch (e) {
      print('Error: $e');
      CustomToast.showToast('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      if (token == null) {
        print('Error: No token found');
        CustomToast.showToast('Error: No token found');
        return;
      }

      final url = '$baseUrl/admin/$branchId/customer/$customerId/transactions';
      print('branchId: $branchId');
      print('customerId: $customerId');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Transaction Response status code: ${response.statusCode}');
      print('Transaction Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final transactionsData = responseBody['transactions'];
        final transactionsList = transactionsData['transactions'];

        if (transactionsList is List && transactionsList.isNotEmpty) {
          transactions.value = List<Transaction>.from(
              transactionsList.map((x) => Transaction.fromJson(x)));
        } else {
          print('No transactions found');
          CustomToast.showToast('No transactions found');
          transactions.clear();
        }
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        CustomToast.showToast('Error: ${response.statusCode}');
        transactions.clear();
      }
    } catch (e) {
      print('Error fetching transactions: $e');
      CustomToast.showToast('Error fetching transactions: $e');
      transactions.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateTransaction(Transaction transaction) async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      if (token == null) {
        print('Error: No token found');
        CustomToast.showToast('Error: No token found');
        return;
      }

      final url =
          '$baseUrl/admin/$branchId/customer/transaction/${transaction.id}/update';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(transaction
            .toJson()), // Use toJson method to ensure all fields are included
      );

      print('Update Transaction Response status code: ${response.statusCode}');
      print('Update Transaction Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final updatedTransaction =
            Transaction.fromJson(responseBody['transaction']);
        // Update the transaction object in the list with the updated values
        final index =
            transactions.indexWhere((t) => t.id == updatedTransaction.id);
        if (index != -1) {
          transactions[index] = updatedTransaction;
          transactions.refresh();
        }
        fetchTransactions();
        CustomToast.showToast('Transaction Updated Successfully');
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        CustomToast.showToast('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating transaction: $e');
      CustomToast.showToast('Error updating transaction: $e');
    } finally {
      isLoading(false);
    }
  }
}
