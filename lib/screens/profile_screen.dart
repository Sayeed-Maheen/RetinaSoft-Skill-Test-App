// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/screens/profile_update_screen.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/widgets/custom_appbar.dart';

import '../controllers/logout_controller.dart';
import '../controllers/user_profile_controller.dart';
import '../utils/strings.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final LogoutController _logoutController = Get.put(LogoutController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Account'),
            content: Text(
                'Are you sure you want to delete your account? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: CustomAppBar(
        text: profile,
        action: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                showMenu(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  color: colorWhite,
                  context: context,
                  position: RelativeRect.fromLTRB(
                    800.0,
                    80.0,
                    MediaQuery.of(context).size.width - 800,
                    MediaQuery.of(context).size.height - 80.0,
                  ),
                  items: <PopupMenuEntry<dynamic>>[
                    PopupMenuItem(
                      onTap: () {
                        _logoutController.logout();
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            color: colorBlack,
                            size: 18,
                          ),
                          Gap(8.w),
                          Text(
                            logout,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: colorBlack,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(height: 1),
                    PopupMenuItem(
                      onTap: () async {
                        bool confirmed = await _showConfirmationDialog(context);
                        if (confirmed) {
                          await controller.deleteAccount();
                          Get.offAll(() => const LoginScreen());
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete_forever,
                            color: colorBlack,
                            size: 18,
                          ),
                          Gap(8.w),
                          Text(
                            deleteAccount,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: colorBlack,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              child: const Icon(
                Icons.more_vert,
                color: colorWhite,
              ),
            )),
      ),
      body: Obx(
        () {
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        onPressed: () {
          Get.to(() => const ProfileUpdateScreen());
        },
        child: const Icon(
          Icons.edit,
          color: colorWhite,
        ),
      ),
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
