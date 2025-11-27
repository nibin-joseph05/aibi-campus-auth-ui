import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
      (ref) => AuthController(),
);

class AuthState {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final String invitationCode;
  final String address;

  final String usernameError;
  final String emailError;
  final String phoneError;
  final String passwordError;
  final String confirmPasswordError;
  final String invitationError;
  final String addressError;

  final bool rememberMe;
  final bool agreeTerms;

  const AuthState({
    this.username = "",
    this.email = "",
    this.phone = "",
    this.password = "",
    this.confirmPassword = "",
    this.invitationCode = "",
    this.address = "",
    this.usernameError = "",
    this.emailError = "",
    this.phoneError = "",
    this.passwordError = "",
    this.confirmPasswordError = "",
    this.invitationError = "",
    this.addressError = "",
    this.rememberMe = false,
    this.agreeTerms = false,
  });

  AuthState copyWith({
    String? username,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    String? invitationCode,
    String? address,
    String? usernameError,
    String? emailError,
    String? phoneError,
    String? passwordError,
    String? confirmPasswordError,
    String? invitationError,
    String? addressError,
    bool? rememberMe,
    bool? agreeTerms,
  }) {
    return AuthState(
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      invitationCode: invitationCode ?? this.invitationCode,
      address: address ?? this.address,
      usernameError: usernameError ?? this.usernameError,
      emailError: emailError ?? this.emailError,
      phoneError: phoneError ?? this.phoneError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      invitationError: invitationError ?? this.invitationError,
      addressError: addressError ?? this.addressError,
      rememberMe: rememberMe ?? this.rememberMe,
      agreeTerms: agreeTerms ?? this.agreeTerms,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState());

  void setUsername(String v) {
    state = state.copyWith(username: v, usernameError: "");
  }

  void setEmail(String v) {
    state = state.copyWith(email: v, emailError: "");
  }

  void setPassword(String v) {
    state = state.copyWith(password: v, passwordError: "");
  }

  void setConfirmPassword(String v) {
    state = state.copyWith(confirmPassword: v, confirmPasswordError: "");
  }

  void setPhone(String v) {
    if (v.length <= 10 && RegExp(r'^[0-9]*$').hasMatch(v)) {
      state = state.copyWith(phone: v, phoneError: "");
    }
  }

  void setInvitation(String v) {
    state = state.copyWith(invitationCode: v, invitationError: "");
  }

  void setAddress(String v) {
    state = state.copyWith(address: v, addressError: "");
  }

  void toggleRememberMe(bool? v) {
    state = state.copyWith(rememberMe: v ?? false);
  }

  void toggleAgree(bool? v) {
    state = state.copyWith(agreeTerms: v ?? false);
  }

  void reset() {
    state = const AuthState();
  }

  void login(BuildContext context) {
    if (state.email.isEmpty || state.password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    Navigator.pushNamed(context, '/otp');
  }

  Future<void> register(BuildContext context) async
  {
    String? usernameErr;
    String? emailErr;
    String? phoneErr;
    String? passwordErr;
    String? confirmPasswordErr;
    String? invitationErr;
    String? addressErr;

    if (state.username.isEmpty) {
      usernameErr = "Username is required";
    } else if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9 _-]*$').hasMatch(state.username)) {
      usernameErr = "Username must start with a letter and contain only letters, numbers, spaces, - or _";
    }

    if (state.email.isEmpty) {
      emailErr = "Email is required";
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(state.email)) {
      emailErr = "Invalid email format";
    }

    if (state.phone.isEmpty) {
      phoneErr = "Phone number is required";
    } else if (state.phone.length != 10) {
      phoneErr = "Phone number must be exactly 10 digits";
    }

    if (state.password.isEmpty) {
      passwordErr = "Password is required";
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\W).{8,}$').hasMatch(state.password)) {
      passwordErr = "Min 8 chars, 1 uppercase, 1 lowercase, 1 symbol";
    }

    if (state.confirmPassword.isEmpty) {
      confirmPasswordErr = "Please confirm your password";
    } else if (state.confirmPassword != state.password) {
      confirmPasswordErr = "Passwords do not match";
    }

    if (state.invitationCode.isEmpty) {
      invitationErr = "Invitation code is required";
    }

    if (state.address.isEmpty) {
      addressErr = "Address is required";
    }

    state = state.copyWith(
      usernameError: usernameErr ?? "",
      emailError: emailErr ?? "",
      phoneError: phoneErr ?? "",
      passwordError: passwordErr ?? "",
      confirmPasswordError: confirmPasswordErr ?? "",
      invitationError: invitationErr ?? "",
      addressError: addressErr ?? "",
    );

    if (usernameErr != null ||
        emailErr != null ||
        phoneErr != null ||
        passwordErr != null ||
        confirmPasswordErr != null ||
        invitationErr != null ||
        addressErr != null) {
      return;
    }

    if (!state.agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept Terms & Conditions")),
      );
      return;
    }

    final repo = AuthRepository();

    try {
      final response = await repo.signup(
        username: state.username,
        email: state.email,
        phone: state.phone,
        password: state.password,
        invitationCode: state.invitationCode,
        address: state.address,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data.toString())),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    }

    Navigator.pushNamed(context, '/home');
  }

  void goToRegister(BuildContext context) {
    reset();
    Navigator.pushNamed(context, '/register');
  }

  void goToLogin(BuildContext context) {
    reset();
    Navigator.pushNamed(context, '/login');
  }

  void updateEmailError(String msg) =>
      state = state.copyWith(emailError: msg);

}