import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/screens/branch_list_screen.dart';
import 'package:skill_test_app/screens/customer_supplier_list_screen.dart';
import 'package:skill_test_app/screens/transection_screen.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/utils/strings.dart';
import 'package:skill_test_app/widgets/custom_appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: const CustomAppBar(text: dashboard),
        body: Padding(
          padding: REdgeInsets.all(16),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(const BranchListScreen());
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: double.infinity,
                  padding: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorGreenLight,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        branchListScreen,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: colorBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(12.h),
              InkWell(
                onTap: () {
                  Get.to(CustomerSupplierScreen());
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: double.infinity,
                  padding: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorGreenLight,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customersAndSuppliersScreen,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: colorBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(12.h),
              InkWell(
                onTap: () {
                  Get.to(TransactionListScreen());
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: double.infinity,
                  padding: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorGreenLight,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionsScreen,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: colorBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
