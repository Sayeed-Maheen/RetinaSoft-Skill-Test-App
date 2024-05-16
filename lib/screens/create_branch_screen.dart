import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/widgets/custom_button.dart';
import 'package:skill_test_app/widgets/custom_form_field.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

import '../controllers/branch_create_controller.dart';
import '../utils/strings.dart';
import '../widgets/custom_appbar.dart';

class CreateBranchScreen extends StatelessWidget {
  final BranchCreateController _controller = Get.put(BranchCreateController());

  CreateBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: const CustomAppBar(text: createBranch),
      body: Padding(
        padding: REdgeInsets.all(16),
        child: Column(
          children: [
            CustomFormField(
              controller: _controller.nameController,
              hintText: "Branch Name",
              maxlines: 1,
            ),
            Gap(16.h),
            Obx(
              () {
                return _controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: colorGreen,
                        ),
                      )
                    : CustomButton(
                        onPressed: () {
                          if (_controller.nameController.text.isEmpty) {
                            // Show toast message indicating the field needs to be filled
                            CustomToast.showToast(
                                "Please fill up the Branch Name field.");
                          } else {
                            // Proceed with creating the branch
                            _controller.createBranch();
                          }
                        },
                        text: createBranch,
                        color: colorGreen,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
