import 'package:dio/dio.dart';
import '../network/api_client.dart';
import '../network/endpoints.dart';

class AuthRepository {
  Future<Response> signup({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String invitationCode,
    required String address,
  }) async {
    return ApiClient.post(
      Endpoints.signup,
      data: {
        "username": username,
        "email": email,
        "phone": phone,
        "password": password,
        "invitation": invitationCode,
        "address": address,
      },
    );
  }
}
