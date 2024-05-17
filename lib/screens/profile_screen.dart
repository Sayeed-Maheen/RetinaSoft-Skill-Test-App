// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/utils/image_path.dart';
import 'package:skill_test_app/widgets/custom_appbar.dart';

import '../controllers/user_profile_controller.dart';
import '../utils/strings.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: profile),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: colorGreen,
            ),
          );
        } else {
          return Padding(
            padding: REdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (controller.userProfile.value.avatarUrl.isNotEmpty)
                    ? Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              controller.userProfile.value.avatarUrl),
                        ),
                      )
                    : Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Container(
                            height: 100.w,
                            width: 100.w,
                            padding: REdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: colorGreenLight,
                            ),
                            child: SvgPicture.asset(
                              userIcon,
                              height: 50.w,
                              width: 50.w,
                              color: colorGrey,
                            ),
                          ),
                        ),
                      ),
                Gap(24.h),
                const TitleTextWidget(name),
                Gap(12.h),
                CustomTextContainerWidget(
                  capitalize(controller.userProfile.value.name),
                ),
                Gap(16.h),
                const TitleTextWidget(id),
                Gap(12.h),
                CustomTextContainerWidget(
                  controller.userProfile.value.id.toString(),
                ),
                Gap(16.h),
                const TitleTextWidget(email),
                Gap(12.h),
                CustomTextContainerWidget(
                  controller.userProfile.value.email,
                ),
                Gap(16.h),
                const TitleTextWidget(phone),
                Gap(12.h),
                CustomTextContainerWidget(
                  controller.userProfile.value.phone,
                ),
                Gap(16.h),
                const TitleTextWidget(businessTypeId),
                Gap(12.h),
                CustomTextContainerWidget(
                  controller.userProfile.value.businessTypeId.toString(),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class TitleTextWidget extends StatelessWidget {
  final String text;

  const TitleTextWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: colorBlack,
      ),
    );
  }
}

class CustomTextContainerWidget extends StatelessWidget {
  final String text;

  const CustomTextContainerWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorGreen,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: colorBlack,
        ),
      ),
    );
  }
}
