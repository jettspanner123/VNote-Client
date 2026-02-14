import 'package:http/http.dart' as HTTP;
import 'dart:convert';
import 'package:vnote_client/models/api/base/user_response.dart';
import 'package:vnote_client/utils/network_helper.dart';

class ApiFactory {
  static final current = ApiFactory();
  final user = _UserApiFactory();
}

class _UserApiFactory {
  Future<UserResponse?> createUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse(NetworkFactory.current.getAddedUrl("/api/user/create"));
    final response = await HTTP.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"fullName": fullName, "email": email, "phoneNumber": phoneNumber, "password": password}),
      // body: jsonEncode({
      //   "fullName": "Vanshika",
      //   "email": "vanshika123@gmail.com",
      //   "phoneNumber": "3129898712",
      //   "password": "Hello@123",
      // }),
    );
    try {
      return UserResponse.fromJson(jsonDecode(response.body));
    } catch (_) {
      return null;
    }
  }
}
