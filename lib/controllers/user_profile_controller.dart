// profile_controller.dart
import 'dart:convert';

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
}
