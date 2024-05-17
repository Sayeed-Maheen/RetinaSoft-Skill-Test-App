class UserModel {
  final int id;
  final String name;
  final String type;

  UserModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}
