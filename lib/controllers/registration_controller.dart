import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

import '../screens/my_bottom_nav.dart';
import '../utils/app_colors.dart';
import '../utils/strings.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form_field.dart';

class RegisterController extends GetxController {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessTypeIdController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isCodeSent = false;
  String? _identifierId;

  bool get isCodeSent => _isCodeSent;
  String? get identifierId => _identifierId;

  bool _isLoading = false;
  bool get isLoading => _isLoading; // Add this getter

  TextEditingController get phoneController => _phoneController;
  TextEditingController get emailController => _emailController;
  TextEditingController get nameController => _nameController;
  TextEditingController get businessNameController => _businessNameController;
  TextEditingController get businessTypeIdController =>
      _businessTypeIdController;
  TextEditingController get otpController => _otpController;

  Future<void> register() async {
    try {
      final response = await http.post(
        Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/sign-up/store'),
        body: jsonEncode({
          'phone': _phoneController.text,
          'email': _emailController.text,
          'name': _nameController.text,
          'business_name': _businessNameController.text,
          'business_type_id': _businessTypeIdController.text,
          'otp': '123456', // This is the default OTP for testing
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 200) {
          _isCodeSent = true;
          _identifierId = data['identifier_id']
              .toString(); // Store identifier_id for OTP verification
          Get.dialog(
            _showOTPDialog(),
            barrierDismissible: false,
          );
        } else {
          // Handle error
          String errorMsg = data['msg'] ?? 'Error occurred';
          print('Error: $errorMsg');
          CustomToast.showToast(errorMsg);
        }
      } else {
        // Handle error
        final data = jsonDecode(response.body);
        String errorMsg = data['msg'] ?? 'Error occurred';
        print('Error: $errorMsg');
        CustomToast.showToast(errorMsg);
      }
    } catch (e) {
      print('Error: $e');
      CustomToast.showToast('Error: $e');
    }
  }

  Future<void> verifyOtp() async {
    if (_identifierId == null) {
      print('Error: Identifier ID is null');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'https://skill-test.retinasoft.com.bd/api/v1/sign-up/verify-otp-code'), // Correct OTP verification endpoint
        body: jsonEncode({
          'phone': _phoneController.text,
          'otp_code': _otpController.text, // Correct field name
          'identifier_id': _identifierId,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 200) {
          // Handle successful sign-in
          print('Sign-in successful');
          final token = data['response_user']['api_token'];
          final branchId = data['response_user']['branch_id'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('branchId', branchId.toString());
          prefs.setString('accessToken', token);
          Get.offAll(() => const MyBottomNav());
          CustomToast.showToast('Sign-in successful');
        } else {
          // Handle error
          print('Error: ${data['msg']}');
          CustomToast.showToast('Error: ${data['msg']}');
        }
      } else {
        // Handle error
        print('Error: ${response.body}');
        CustomToast.showToast('Error: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      CustomToast.showToast('Error: $e');
    }
  }

  Widget _showOTPDialog() {
    final _isVerifying = false.obs; // Create a reactive boolean variable

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      backgroundColor: colorWhite,
      insetPadding: REdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomFormField(
                controller: _otpController,
                hintText: 'Enter OTP',
                maxlines: 1,
                keyboardType: TextInputType.number,
              ),
              Gap(16.h),
              Obx(
                () => _isVerifying.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: colorGreen,
                        ),
                      ) // Show CircularProgressIndicator when verifying
                    : CustomButton(
                        onPressed: () async {
                          String otp = _otpController.text;
                          if (otp.isEmpty) {
                            CustomToast.showToast("Please enter OTP");
                            return;
                          }
                          if (otp.length != 6) {
                            CustomToast.showToast("OTP must be 6 digits");
                            return;
                          }
                          _isVerifying.value =
                              true; // Set _isVerifying to true before verifying OTP
                          await verifyOtp(); // Wait for verification to complete
                          _isVerifying.value =
                              false; // Set _isVerifying to false after verification
                        },
                        text: verifyOTP,
                        color: colorGreen,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
