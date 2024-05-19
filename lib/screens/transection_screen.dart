import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/utils/app_colors.dart';

import '../controllers/transection_controller.dart';
import '../models/transaction_model.dart';
import '../utils/strings.dart';
import '../widgets/custom_appbar.dart';

class TransactionListScreen extends StatelessWidget {
  final TransactionController transactionController =
      Get.put(TransactionController());

  TransactionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: const CustomAppBar(text: transactionsScreen),
      body: Obx(
        () => transactionController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: colorGreen,
                ),
              )
            : transactionController.transactions.isEmpty
                ? Center(
                    child: Text(
                      'No transactions available',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: colorBlack,
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      // Call the method to fetch the latest transactions
                      await transactionController.fetchTransactions();
                    },
                    child: ListView.builder(
                      itemCount: transactionController.transactions.length,
                      padding: REdgeInsets.only(left: 16, right: 16, top: 16),
                      itemBuilder: (context, index) {
                        final transaction =
                            transactionController.transactions[index];
                        return Container(
                          width: double.infinity,
                          padding: REdgeInsets.all(16),
                          margin: REdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: colorGreenLight,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transaction No: ${transaction.transactionNo}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colorBlack,
                                ),
                              ),
                              Gap(8.h),
                              Divider(
                                color: colorGreen,
                                height: 1.h,
                              ),
                              Gap(8.h),
                              DetailsTextWidget('Type: ${transaction.type}'),
                              Gap(2.h),
                              DetailsTextWidget(
                                  'Amount: ${transaction.amount}'),
                              Gap(2.h),
                              DetailsTextWidget(
                                  'Transaction Date: ${transaction.transactionDate}'),
                              Gap(2.h),
                              DetailsTextWidget(
                                  'Details: ${transaction.details ?? ''}'),
                              Gap(2.h),
                              DetailsTextWidget(
                                  'Bill No: ${transaction.billNo}'),
                              Gap(2.h),
                              DetailsTextWidget(
                                  'Status: ${transaction.status}'),
                              Gap(12.h),
                              Divider(
                                color: colorGreen,
                                height: 1.h,
                              ),
                              Gap(4.h),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _showUpdatePopup(context, transaction);
                                    },
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(8),
                                        minimumSize: const Size(50, 20),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: colorGreen,
                                      ),
                                    ),
                                  ),
                                  Gap(12.w),
                                  TextButton(
                                    onPressed: () {
                                      _showDeleteConfirmationPopup(
                                          context, transaction);
                                    },
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(8),
                                        minimumSize: const Size(50, 20),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: colorRed,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  void _showUpdatePopup(BuildContext context, Transaction transaction) {
    TextEditingController amountController =
        TextEditingController(text: transaction.amount.toString());
    TextEditingController dateController =
        TextEditingController(text: transaction.transactionDate);
    TextEditingController detailsController =
        TextEditingController(text: transaction.details ?? '');
    TextEditingController billNoController =
        TextEditingController(text: transaction.billNo ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Transaction'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: dateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(labelText: 'Details'),
            ),
            TextField(
              controller: billNoController,
              decoration: InputDecoration(labelText: 'Bill No'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Update the transaction with new amount, date, details, and billNo
              transactionController.updateTransaction(
                Transaction(
                  id: transaction.id,
                  transactionNo: transaction.transactionNo,
                  // Pass the 'transactionNo' value
                  type: transaction.type,
                  // Pass the 'type' value
                  amount: double.parse(amountController.text),
                  transactionDate: dateController.text,
                  details: detailsController.text,
                  billNo: billNoController.text,
                ),
              );
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationPopup(
      BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Call the deleteTransaction method from the controller
              Get.find<TransactionController>()
                  .deleteTransaction(transaction.id);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsTextWidget extends StatelessWidget {
  final String text;

  const DetailsTextWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: colorBlack,
      ),
    );
  }
}
