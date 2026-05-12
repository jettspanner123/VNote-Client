import 'package:vnote_client/constants/network_constants.dart';

class OPSafeUser {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final UserRole? role;
  final UserLanguage? language;

  const OPSafeUser({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.role,
    this.language,
  });

  factory OPSafeUser.fromJson(Map<String, dynamic> json) {
    return OPSafeUser(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] != null ? UserRole.fromString(json['role'] as String) : null,
      language: json['language'] != null ? UserLanguage.fromString(json['language'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (role != null) 'role': role!.value,
      if (language != null) 'language': language!.value,
    };
  }
}
