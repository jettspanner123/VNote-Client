import 'package:vnote_client/models/api/user/op_safe_user.dart';

class GetAllUsersResponse {
  final bool success;
  final String message;
  final List<OPSafeUser> users;

  const GetAllUsersResponse({required this.success, required this.message, required this.users});

  factory GetAllUsersResponse.fromJson(Map<String, dynamic> json) {
    final usersJson = json['users'] as List<dynamic>;

    return GetAllUsersResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      users: usersJson.map((e) => OPSafeUser.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'users': users.map((e) => e.toJson()).toList()};
  }
}
