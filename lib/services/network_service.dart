import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vnote_client/constants/network_constants.dart';
import 'package:vnote_client/helpers/network_helper.dart';
import 'package:vnote_client/models/api/auth/login_response.dart';
import 'package:vnote_client/models/api/auth/register_response.dart';
import 'package:vnote_client/models/api/dto/auth_login_dto.dart';
import 'package:vnote_client/models/api/dto/auth_register_dto.dart';
import 'package:vnote_client/models/api/dto/get_all_users_dto.dart';
import 'package:vnote_client/models/api/user/get_all_users_response.dart';

class NetworkService {
    static final current = NetworkService();
    final post = _PostNetworkRequests();
    final get = _GetNetworkRequests();
}

class _GetNetworkRequests {
    final user = _UserNetworkRequests();
}

class _PostNetworkRequests {
    final auth = _AuthNetworkRequests();
}

class _AuthNetworkRequests {
    // MARK: Login User

    Future<LoginResponse?> loginUser(AuthLoginDTO data) async {
        try {
            // Request URL Creation
            // URL: {baseURL}/api/public/auth/login
            var requestURL = NetworkHelper.current.constructURL(
                NetworkServiceEndpoints.auth,
                NetworkServiceSubEndpoints.login,
            );

            if (requestURL == null) {
                return LoginResponse(success: false, message: "Invalid Request URL: Null!");
            }

            // Creating Request Body
            final Map<String, dynamic> loginRequestBodyJSON = {
                "loginIdentifier": data.loginIdentifier,
                "password": data.password,
            };

            // Creating Request
            final response = await http
                .post(requestURL, headers: {'Content-Type': 'application/json'}, body: jsonEncode(loginRequestBodyJSON))
                .timeout(const Duration(seconds: 15));

            // Assert Status Code
            if (!NetworkHelper.current.isRequestSuccessful(response.statusCode)) {
                return LoginResponse(success: false, message: "Unsuccessful Status Code: ${response.statusCode}!");
            }

            final dynamic responseBodyJSON = jsonDecode(response.body);

            if (responseBodyJSON is! Map<String, dynamic>) {
                return LoginResponse(success: false, message: "Invalid Response Format!");
            }

            return LoginResponse.fromJson(responseBodyJSON);
        }
        catch (e) {
            return LoginResponse(success: false, message: e.toString());
        }
    }

    // MARK: Register User

    Future<RegisterResponse?> registerUser(AuthRegisterDTO data) async {
        try {
            // Request URL Creation
            // URL: {baseURL}/api/public/auth/register
            var requestURL = NetworkHelper.current.constructURL(
                NetworkServiceEndpoints.auth,
                NetworkServiceSubEndpoints.register,
            );

            if (requestURL == null) {
                return RegisterResponse(success: false, message: "Invalid Request URL: Null!");
            }

            // Creating Request Body
            final Map<String, dynamic> registerRequestBodyJSON = {
                "firstName": data.firstName,
                if (data.lastName != null) "lastName": data.lastName,
                "email": data.email,
                "phoneNumber": data.phoneNumber,
                "role": data.role.value,
                "language": data.language.value,
                "password": data.password,
            };

            // Creating Request
            final response = await http
                .post(requestURL, headers: {'Content-Type': 'application/json'}, body: jsonEncode(registerRequestBodyJSON))
                .timeout(const Duration(seconds: 15));

            // Assert Status Code
            if (!NetworkHelper.current.isRequestSuccessful(response.statusCode)) {
                return RegisterResponse(success: false, message: "Unsuccessful Status Code: ${response.statusCode}!");
            }

            final dynamic responseBodyJSON = jsonDecode(response.body);

            if (responseBodyJSON is! Map<String, dynamic>) {
                return RegisterResponse(success: false, message: "Invalid Response Format!");
            }

            return RegisterResponse.fromJson(responseBodyJSON);
        }
        catch (e) {
            return RegisterResponse(success: false, message: e.toString());
        }
    }
}

class _UserNetworkRequests {
    // MARK: Get All Users

    Future<GetAllUsersResponse?> getAllUsers([GetAllUsersDTO? data]) async {
        try {
            // Request URL Creation
            // URL: {baseURL}/api/private/user/getAllUsers
            var requestURL = NetworkHelper.current.constructURL(
                NetworkServiceEndpoints.user,
                NetworkServiceSubEndpoints.getAllUsers,
            );

            if (requestURL == null) {
                return GetAllUsersResponse(success: false, message: "Invalid Request URL: Null!", users: []);
            }

            // Creating Request Body
            final Map<String, dynamic> getAllUsersRequestBodyJSON = {
                if (data?.firstName != null) "firstName": data!.firstName,
                if (data?.lastName != null) "lastName": data!.lastName,
                if (data?.email != null) "email": data!.email,
                if (data?.phoneNumber != null) "phoneNumber": data!.phoneNumber,
                if (data?.role != null) "role": data!.role,
                if (data?.language != null) "language": data!.language,
            };

            // Creating Request
            final response = await http
                .post(requestURL, headers: {'Content-Type': 'application/json'}, body: jsonEncode(getAllUsersRequestBodyJSON))
                .timeout(const Duration(seconds: 15));

            // Assert Status Code
            if (!NetworkHelper.current.isRequestSuccessful(response.statusCode)) {
                return GetAllUsersResponse(
                    success: false,
                    message: "Unsuccessful Status Code: ${response.statusCode}!",
                    users: [],
                );
            }

            final dynamic responseBodyJSON = jsonDecode(response.body);

            if (responseBodyJSON is! Map<String, dynamic>) {
                return GetAllUsersResponse(success: false, message: "Invalid Response Format!", users: []);
            }

            return GetAllUsersResponse.fromJson(responseBodyJSON);
        }
        catch (e) {
            return GetAllUsersResponse(success: false, message: e.toString(), users: []);
        }
    }
}
