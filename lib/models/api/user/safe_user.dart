import 'package:vnote_client/models/api/business/business.dart';

class SafeUser {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Business> businesses;

  const SafeUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.businesses,
  });

  factory SafeUser.fromJson(Map<String, dynamic> json) {
    return SafeUser(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      businesses: (json['businesses'] as List<dynamic>).map((e) => Business.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'businesses': businesses.map((e) => e.toJson()).toList(),
    };
  }
}
