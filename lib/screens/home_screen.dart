import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/utils/strings.dart';
import 'package:skill_test_app/widgets/custom_appbar.dart';

import '../controllers/branch_list_controller.dart';
import '../controllers/logout_controller.dart';
import 'create_branch_screen.dart';

class HomeScreen extends StatelessWidget {
  final LogoutController _logoutController = Get.put(LogoutController());
  final BranchController branchController = Get.put(BranchController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: branchList,
        action: IconButton(
          icon: const Icon(
            Icons.logout,
            color: colorWhite,
          ),
          onPressed: () {
            _logoutController.logout();
          },
        ),
      ),
      body: Obx(
        () {
          if (branchController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: colorGreen,
              ),
            );
          } else {
            return RefreshIndicator(
              color: colorGreen,
              onRefresh: () async {
                await branchController.fetchBranches();
              },
              child: branchController.branches.isEmpty
                  ? const Center(
                      child: Text('No branches found'),
                    )
                  : ListView.builder(
                      itemCount: branchController.branches.length,
                      padding: REdgeInsets.only(left: 16, right: 16, top: 12),
                      itemBuilder: (context, index) {
                        final branch = branchController.branches[index];
                        return Container(
                          width: double.infinity,
                          padding: REdgeInsets.all(16),
                          margin: REdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: colorGreenLight,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            capitalize(branch.name),
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: colorBlack,
                            ),
                          ),
                        );
                      },
                    ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        onPressed: () {
          Get.to(() => CreateBranchScreen());
        },
        child: const Icon(
          Icons.add,
          color: colorWhite,
        ),
      ),
    );
  }
}
