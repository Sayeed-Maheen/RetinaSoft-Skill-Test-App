import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/utils/app_colors.dart';

import '../controllers/transection_controller.dart';
import '../utils/strings.dart';
import '../widgets/custom_appbar.dart';

class TransactionListScreen extends StatelessWidget {
  final TransactionController transactionController =
      Get.put(TransactionController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
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
                ? const Center(
                    child: CircularProgressIndicator(
                      color: colorGreen,
                    ),
                  )
                : ListView.builder(
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
                            DetailsTextWidget('Amount: ${transaction.amount}'),
                            Gap(2.h),
                            DetailsTextWidget(
                                'Transaction Date: ${transaction.transactionDate}'),
                            Gap(2.h),
                            DetailsTextWidget(
                                'Details: ${capitalize(transaction.details)}'),
                            Gap(2.h),
                            DetailsTextWidget('Bill No: ${transaction.billNo}'),
                            Gap(2.h),
                            DetailsTextWidget('Status: ${transaction.status}'),
                          ],
                        ),
                      );
                    },
                  ),
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
