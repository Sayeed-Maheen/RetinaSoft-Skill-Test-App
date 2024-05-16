import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_test_app/screens/login_screen.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

class LogoutController extends GetxController {
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token == null) {
        CustomToast.showToast('No token found');
        return;
      }

      final response = await http.post(
        Uri.parse('https://skill-test.retinasoft.com.bd/api/v1/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await prefs.clear(); // Clear the stored token and other preferences
        Get.offAll(() => const LoginScreen()); // Navigate to the login screen
        CustomToast.showToast('Logout successful');
      } else {
        CustomToast.showToast('Logout failed: ${response.body}');
      }
    } catch (e) {
      CustomToast.showToast('Error: $e');
    }
  }
}
