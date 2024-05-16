import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/controllers/login_controller.dart';
import 'package:skill_test_app/screens/register_screen.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/utils/image_path.dart';
import 'package:skill_test_app/widgets/custom_button.dart';
import 'package:skill_test_app/widgets/custom_form_field.dart';

import '../utils/strings.dart';
import '../widgets/custom_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(24.h),
                Center(
                  child: Image.asset(appLogo),
                ),
                Gap(80.h),
                Text(
                  welcomeBack,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                  ),
                ),
                Text(
                  loginToYourAccount,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: colorBlack,
                  ),
                ),
                Gap(24.h),
                CustomFormField(
                  controller: _controller.phoneController,
                  hintText: 'Email',
                  maxlines: 1,
                ),
                Gap(16.h),
                Obx(
                  () => _controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: colorGreen,
                          ),
                        )
                      : CustomButton(
                          onPressed: () {
                            if (_controller.phoneController.text.isEmpty) {
                              CustomToast.showToast(
                                  "Please enter your phone number");
                            } else {
                              _controller.sendLoginOtp();
                            }
                          },
                          text: sendOTP,
                          color: colorGreen,
                        ),
                ),
                Gap(2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        dontHaveAnAccount,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: colorBlack,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const RegisterScreen());
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          minimumSize: const Size(50, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      child: Text(
                        register,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: colorGreen,
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
}
