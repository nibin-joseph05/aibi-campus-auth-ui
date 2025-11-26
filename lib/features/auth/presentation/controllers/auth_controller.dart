import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
StateNotifierProvider<AuthController, AuthState>(
      (ref) => AuthController(),
);

class AuthState {
  final String name;
  final String email;
  final String phone;
  final String password;
  final bool rememberMe;
  final bool agreeTerms;

  const AuthState({
    this.name = "",
    this.email = "",
    this.phone = "",
    this.password = "",
    this.rememberMe = false,
    this.agreeTerms = false,
  });

  AuthState copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    bool? rememberMe,
    bool? agreeTerms,
  }) =>
      AuthState(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        rememberMe: rememberMe ?? this.rememberMe,
        agreeTerms: agreeTerms ?? this.agreeTerms,
      );
}

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState());

  void setEmail(String v) => state = state.copyWith(email: v);
  void setPassword(String v) => state = state.copyWith(password: v);
  void toggleRememberMe(bool? v) =>
      state = state.copyWith(rememberMe: v ?? false);

  void setName(String v) => state = state.copyWith(name: v);
  void setPhone(String v) => state = state.copyWith(phone: v);
  void toggleAgree(bool? v) => state = state.copyWith(agreeTerms: v ?? false);

  void reset() => state = const AuthState();

  void register(BuildContext context) {
    if (!state.agreeTerms) return;
    Navigator.pushNamed(context, '/otp');
  }

  void login(BuildContext context) {
    // TODO: API integration later
    Navigator.pushNamed(context, '/otp');
  }

  void goToRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }
}
