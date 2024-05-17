// user_profile_model.dart
class UserProfile {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final int businessTypeId;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.businessTypeId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['response_user']['id'] ?? 0,
      name: json['response_user']['name'] ?? '',
      email: json['response_user']['email'] ?? '',
      phone: json['response_user']['phone'] ?? '',
      avatarUrl: json['response_user']['image_full_path'] ?? '',
      businessTypeId: json['response_user']['business_type_id'] ?? 0,
    );
  }
}
