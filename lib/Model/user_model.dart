class UserProfileResponse {
  final bool success;
  final String message;
  final User user;

  UserProfileResponse({
    required this.success,
    required this.message,
    required this.user,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: json['success'] ?? true,
      message: json['message'] ?? '',
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String phone;
  final String role;
  final bool isVerified;

  User({
    required this.id,
    required this.phone,
    required this.role,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      phone: json['phone']?.toString() ?? '',
      role: json['role'] ?? '',
      isVerified: json['isVerified'] ?? false,
    );
  }
}
