import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/utils/app_colors.dart';

import '../controllers/transection_controller.dart';

class TransactionListScreen extends StatelessWidget {
  final TransactionController transactionController =
      Get.put(TransactionController());

  TransactionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction List'),
      ),
      body: Obx(
        () => transactionController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: colorGreen,
                ),
              )
            : transactionController.transactions.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: colorGreen,
                    ),
                  )
                : ListView.builder(
                    itemCount: transactionController.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction =
                          transactionController.transactions[index];
                      return ListTile(
                        title: Text(transaction.date),
                        subtitle: Text('Amount: ${transaction.amount}'),
                      );
                    },
                  ),
      ),
    );
  }
}
