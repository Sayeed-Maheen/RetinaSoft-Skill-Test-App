// profile_controller.dart
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var userProfile = UserProfile(
    name: '',
    email: '',
    avatarUrl: '',
    id: 0,
    phone: '',
    businessTypeId: 0,
  ).obs;

  @override
  void onInit() {
    fetchUserProfile();
    super.onInit();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading(true);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      if (token == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/admin/profile'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        userProfile.value = UserProfile.fromJson(data);
      } else {
        Get.snackbar('Error', 'Failed to load profile');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile({
    required String name,
    required int businessTypeId,
    String? imagePath,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token == null) {
        print('No access token found');
        return;
      }

      // Convert the image file to base64 string, or use an empty string if no image is selected
      String base64Image = '';
      if (imagePath != null && imagePath.isNotEmpty) {
        List<int> imageBytes = await File(imagePath).readAsBytesSync();
        base64Image = base64Encode(imageBytes);
      }

      final requestBody = jsonEncode({
        'name': name,
        'business_type_id': businessTypeId.toString(),
        'image_full_path':
            base64Image, // Send the base64 encoded image or an empty string
      });

      // Log the request payload
      log('Request Payload:');
      log('Headers: ${{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }}');
      //  log('Body: $requestBody');

      final response = await http.post(
        Uri.parse(
            'https://skill-test.retinasoft.com.bd/api/v1/admin/profile/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      // Log the response
      // log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        await fetchUserProfile();
      } else {
        print('Failed to update profile: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while updating profile: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token == null) {
        print('No access token found');
        return;
      }

      final response = await http.get(
        Uri.parse(
            'https://skill-test.retinasoft.com.bd/api/v1/admin/account-delete'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Log the response
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Account deleted successfully');
        // Perform any additional clean-up if necessary
      } else {
        print('Failed to delete account: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while deleting account: $e');
    }
  }
}
