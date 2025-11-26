import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
StateNotifierProvider<AuthController, AuthState>(
      (ref) => AuthController(),
);

class AuthState {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String invitationCode;
  final String address;
  final bool rememberMe;
  final bool agreeTerms;

  const AuthState({
    this.username = "",
    this.email = "",
    this.phone = "",
    this.password = "",
    this.invitationCode = "",
    this.address = "",
    this.rememberMe = false,
    this.agreeTerms = false,
  });

  AuthState copyWith({
    String? username,
    String? email,
    String? phone,
    String? password,
    String? invitationCode,
    String? address,
    bool? rememberMe,
    bool? agreeTerms,
  }) =>
      AuthState(
        username: username ?? this.username,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        invitationCode: invitationCode ?? this.invitationCode,
        address: address ?? this.address,
        rememberMe: rememberMe ?? this.rememberMe,
        agreeTerms: agreeTerms ?? this.agreeTerms,
      );
}

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState());

  // ── Input setters ──────────────────────────────────────
  void setUsername(String v) => state = state.copyWith(username: v);
  void setEmail(String v) => state = state.copyWith(email: v);
  void setPassword(String v) => state = state.copyWith(password: v);

  void setPhone(String v) {
    if (v.length <= 10 && RegExp(r'^[0-9]*$').hasMatch(v)) {
      state = state.copyWith(phone: v);
    }
  }

  void setInvitation(String v) => state = state.copyWith(invitationCode: v);
  void setAddress(String v) => state = state.copyWith(address: v);

  void toggleRememberMe(bool? v) =>
      state = state.copyWith(rememberMe: v ?? false);

  void toggleAgree(bool? v) =>
      state = state.copyWith(agreeTerms: v ?? false);

  void reset() => state = const AuthState();

  // ── Auth Actions ───────────────────────────────────────
  void login(BuildContext context) {
    if (state.email.isEmpty || state.password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }
    Navigator.pushNamed(context, '/otp');
  }

  void register(BuildContext context) {
    if (!state.agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept terms & conditions")),
      );
      return;
    }

    if (state.username.isEmpty ||
        state.email.isEmpty ||
        state.phone.length != 10 ||
        state.password.isEmpty ||
        state.invitationCode.isEmpty ||
        state.address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields correctly")),
      );
      return;
    }

    Navigator.pushNamed(context, '/otp');
  }

  void goToRegister(BuildContext context) {
    reset();
    Navigator.pushNamed(context, '/register');
  }

  void goToLogin(BuildContext context) {
    reset();
    Navigator.pushNamed(context, '/login');
  }
}
