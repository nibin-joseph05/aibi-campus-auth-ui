import 'dart:developer';

import 'package:dio/dio.dart';
import '../network/api_client.dart';
import '../network/endpoints.dart';

class AuthRepository {
  Future<Response> signup({
    required String userName,
    required String email,
    required String password,
    required String mobileNumber,
    required String category,
    required String address,
    required String orgName,
    required String startTime,
    required String endTime,
    required String signinId,
    required String deviceId,
    required String platform,
    required String token,
  }) async {
    return ApiClient.post(
      Endpoints.signup,
      data: {
        "userName": userName,
        "email": email,
        "password": password,
        "mobileNumber": mobileNumber,
        "category": category,
        "address": address,
        "orgName": orgName,
        "startTime": startTime,
        "endTime": endTime,
        "signinId": signinId,
        "deviceId": deviceId,
        "platform": platform,
        "token": token
      },
    );
  }

  Future<Response> login({
    required String email,
    required String password,
    required String platform,
    required String token,
    required String deviceId,
    required String signinId,
  }) async {
    return ApiClient.post(
      Endpoints.login,
      data: {
        "email": email,
        "password": password,
        "platform": platform,
        "token": token,
        "deviceId": deviceId,
        "signinId": signinId,
      },
    );
  }

  Future<Response> sendOtp(String email) async {
    return ApiClient.post(
      Endpoints.sendOtp,
      data: {"email": email},
    );
  }

  Future<Response> verifyOtp(String email, String invitationCode) async {

  var response=  ApiClient.post(
      Endpoints.verifyOtp,
      data: {
        "email": email,
        "invitationCode": invitationCode,
      },
    );
  print("response---------$response");
    return response;

  }

}


