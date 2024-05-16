import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/screens/login_screen.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/utils/image_path.dart';
import 'package:skill_test_app/utils/strings.dart';
import 'package:skill_test_app/widgets/custom_button.dart';
import 'package:skill_test_app/widgets/custom_form_field.dart';

import '../controllers/registration_controller.dart';
import '../widgets/custom_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController _controller = Get.put(RegisterController());

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(24.h),
                Center(
                  child: Image.asset(appLogo),
                ),
                Gap(40.h),
                Text(
                  helloText,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                  ),
                ),
                Text(
                  registerToYourAccount,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: colorBlack,
                  ),
                ),
                Gap(24.h),
                CustomFormField(
                  controller: _controller.phoneController,
                  hintText: 'Phone Number',
                  maxlines: 1,
                  keyboardType: TextInputType.number,
                ),
                Gap(16.h),
                CustomFormField(
                  controller: _controller.emailController,
                  hintText: 'Email',
                  maxlines: 1,
                ),
                Gap(16.h),
                CustomFormField(
                  controller: _controller.nameController,
                  hintText: 'Name',
                  maxlines: 1,
                ),
                Gap(16.h),
                CustomFormField(
                  controller: _controller.businessNameController,
                  hintText: 'Business Name',
                  maxlines: 1,
                ),
                Gap(16.h),
                CustomFormField(
                  controller: _controller.businessTypeIdController,
                  hintText: 'Business Type ID',
                  maxlines: 1,
                  keyboardType: TextInputType.number,
                ),
                Gap(16.h),
                _controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: colorGreen,
                        ),
                      )
                    : CustomButton(
                        onPressed: () {
                          if (_controller.phoneController.text.isEmpty ||
                              _controller.emailController.text.isEmpty ||
                              _controller.nameController.text.isEmpty ||
                              _controller.businessNameController.text.isEmpty ||
                              _controller
                                  .businessTypeIdController.text.isEmpty) {
                            CustomToast.showToast("Please fill all the fields");
                          } else {
                            _controller.register();
                          }
                        },
                        text: register,
                        color: colorGreen,
                      ),
                Gap(2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        alreadyHaveAnAccount,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: colorBlack,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAll(() => const LoginScreen());
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          minimumSize: const Size(50, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      child: Text(
                        login,
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
