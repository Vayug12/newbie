class UserModel {
  final String id;
  final String phone;
  final String? name;
  final String role;
  final String activeMode;

  UserModel({
    required this.id,
    required this.phone,
    this.name,
    required this.role,
    required this.activeMode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"] ?? "",
      phone: json["phone"] ?? "",
      name: json["name"],
      role: json["role"] ?? "customer",
      activeMode: json["activeMode"] ?? "customer",
    );
  }
}
