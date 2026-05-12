import 'package:vnote_client/constants/network_constants.dart';

class BaseUser {
    final String id;
    final String firstName;
    final String lastName;
    final String email;
    final String phoneNumber;
    final UserRole role;
    final UserLanguage language;
    final DateTime createdAt;
    final DateTime updatedAt;

    const BaseUser({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        required this.role,
        required this.language,
        required this.createdAt,
        required this.updatedAt,
    });

    factory BaseUser.fromJson(Map<String, dynamic> json) {
        return BaseUser(
            id: json['id'] as String,
            firstName: json['firstName'] as String,
            lastName: json['lastName'] as String,
            email: json['email'] as String,
            phoneNumber: json['phoneNumber'] as String,
            role: UserRole.fromString(json['role'] as String),
            language: UserLanguage.fromString(json['language'] as String),
            createdAt: DateTime.parse(json['createdAt']),
            updatedAt: DateTime.parse(json['updatedAt']),
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'id': id,
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'phoneNumber': phoneNumber,
            'role': role.value,
            'language': language.value,
            'createdAt': createdAt.toIso8601String(),
            'updatedAt': updatedAt.toIso8601String(),
        };
    }
}
