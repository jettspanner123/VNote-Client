import 'package:vnote_client/models/api/base/twin_tokens.dart';
import 'package:vnote_client/models/api/user/base_user.dart';

class RegisterResponse {
  final bool success;
  final String message;
  final TwinTokens? tokens;
  final BaseUser? user;

  const RegisterResponse({required this.success, required this.message, this.tokens, this.user});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    final tokensJson = json['tokens'];
    final userJson = json['user'];

    return RegisterResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      tokens: tokensJson is Map<String, dynamic> ? TwinTokens.fromJson(tokensJson) : null,
      user: userJson is Map<String, dynamic> ? BaseUser.fromJson(userJson) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'tokens': tokens?.toJson(), 'user': user?.toJson()};
  }
}
