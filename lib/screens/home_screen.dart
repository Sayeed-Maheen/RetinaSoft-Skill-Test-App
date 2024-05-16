import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/utils/strings.dart';
import 'package:skill_test_app/widgets/custom_appbar.dart';
import 'package:skill_test_app/widgets/custom_form_field.dart';

import '../controllers/branch_list_controller.dart';
import '../controllers/logout_controller.dart';
import '../models/branch_list_model.dart';
import 'create_branch_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LogoutController _logoutController = Get.put(LogoutController());

  final BranchController branchController = Get.put(BranchController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  void updateBranch(Branch branch) {
    TextEditingController controller = TextEditingController(text: branch.name);
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: colorWhite,
        insetPadding: REdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Update Branch",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: colorBlack,
                  ),
                ),
                Gap(16.h),
                CustomFormField(
                  controller: controller,
                  hintText: "Enter new branch name",
                  maxlines: 1,
                ),
                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        height: 45.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: colorRed,
                            width: 1.w,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: colorRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Branch updatedBranch =
                            Branch(id: branch.id, name: controller.text);
                        // Update the branch using the controller
                        branchController.updateBranch(updatedBranch);

                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        height: 45.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          color: colorGreen,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: colorWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteBranch(int branchId) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: colorWhite,
        insetPadding: REdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Delete Branch",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: colorBlack,
                  ),
                ),
                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        height: 45.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: colorRed,
                            width: 1.w,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: colorRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        branchController.deleteBranch(branchId);
                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        height: 45.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          color: colorGreen,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: colorWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                capitalize(branch.name),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: colorBlack,
                                ),
                              ),
                              Gap(8.h),
                              Divider(
                                color: colorGreen,
                                height: 1.h,
                              ),
                              Gap(4.h),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      updateBranch(branch);
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
                                      deleteBranch(branch.id);
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
