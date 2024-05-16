import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_test_app/screens/home_screen.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form_field.dart';

class LoginController extends GetxController {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final RxBool isLoading = false.obs;
  bool _isOtpSent = false;
  String? _identifierId;
  bool _isLoading = false;

  bool get isOtpSent => _isOtpSent;
  String? get identifierId => _identifierId;

  TextEditingController get phoneController => _phoneController;
  TextEditingController get otpController => _otpController;

  Future<void> sendLoginOtp() async {
    _isLoading = true;
    update();

    try {
      final response = await http.post(
        Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/send-login-otp'),
        body: jsonEncode({'identifier': _phoneController.text}),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 200) {
          _isOtpSent = true;
          _identifierId = data['identifier_id'].toString();
          Get.dialog(
            _showOTPDialog(),
            barrierDismissible: false,
          );
        } else {
          print('Error: ${data['msg']}');
        }
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }

    _isLoading = false;
    update();
  }

  Future<void> login() async {
    if (_identifierId == null) {
      print('Error: Identifier ID is null');
      return;
    }

    _isLoading = true;
    update();

    try {
      final response = await http.post(
        Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/login'),
        body: jsonEncode({
          'identifier': _phoneController.text,
          'otp_code': _otpController.text,
          'identifier_id': _identifierId,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['status'] == 200 && data['user'] != null) {
          print('Login successful');
          final token = data['user']['api_token'];
          if (token != null) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('accessToken', token);
            // Show toast
            CustomToast.showToast('Login successful');
            // Navigate to home screen
            Get.offAll(() => HomeScreen());
          } else {
            print('Error: api_token is null');
            CustomToast.showToast('Error: api_token is null');
          }
        } else {
          print('Error: Invalid response format');
          CustomToast.showToast('Error: Invalid response format');
        }
      } else {
        print('Error: ${response.body}');
        CustomToast.showToast('Error: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      CustomToast.showToast('Error: $e');
    }

    _isLoading = false;
    update();
  }

  Widget _showOTPDialog() {
    final _isVerifying = false.obs;

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
                      )
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
                          _isVerifying.value = true;
                          await login();
                          _isVerifying.value = false;
                        },
                        text: 'Login',
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
