import 'package:vnote_client/constants/network_constants.dart';

class AuthRegisterDTO {
  final String firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final UserRole role;
  final UserLanguage language;
  final String password;

  AuthRegisterDTO({
    required this.firstName,
    this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.language,
    required this.password,
  });
}
