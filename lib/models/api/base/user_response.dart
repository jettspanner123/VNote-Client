import 'package:vnote_client/models/api/user/safe_user.dart';

class UserResponse {
  final bool success;
  final String message;
  final SafeUser? user;

  const UserResponse({required this.success, required this.message, this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];

    return UserResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      user: userJson is Map<String, dynamic> ? SafeUser.fromJson(userJson) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'user': user?.toJson()};
  }
}
