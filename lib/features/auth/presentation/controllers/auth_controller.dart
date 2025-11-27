import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/auth_repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../core/navigation/navigation_key.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


void showTopSnackBar(BuildContext context, String message, {bool isError = false}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isError ? Colors.red.shade600 : Colors.green.shade600,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
      (ref) => AuthController(),
);

class AuthState {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final String address;
  final String category;
  final String orgName;
  final String startTime;
  final String endTime;
  final String signinId;
  final String deviceId;
  final String platform;
  final String token;
  final String usernameError;
  final String emailError;
  final String phoneError;
  final String passwordError;
  final String confirmPasswordError;
  final String addressError;
  final bool rememberMe;
  final bool agreeTerms;
  final bool isLoadingSendOtp;

  const AuthState({
    this.username = "",
    this.email = "",
    this.phone = "",
    this.password = "",
    this.confirmPassword = "",
    this.address = "",
    this.category = "",
    this.orgName = "",
    this.startTime = "",
    this.endTime = "",
    this.signinId = "",
    this.deviceId = "",
    this.platform = "",
    this.token = "",
    this.usernameError = "",
    this.emailError = "",
    this.phoneError = "",
    this.passwordError = "",
    this.confirmPasswordError = "",
    this.addressError = "",
    this.rememberMe = false,
    this.agreeTerms = false,
    this.isLoadingSendOtp = false,
  });

  AuthState copyWith({
    String? username,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    String? address,
    String? category,
    String? orgName,
    String? startTime,
    String? endTime,
    String? signinId,
    String? deviceId,
    String? platform,
    String? token,
    String? usernameError,
    String? emailError,
    String? phoneError,
    String? passwordError,
    String? confirmPasswordError,
    String? addressError,
    bool? rememberMe,
    bool? agreeTerms,
    bool? isLoadingSendOtp,
  }) {
    return AuthState(
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      address: address ?? this.address,
      category: category ?? this.category,
      orgName: orgName ?? this.orgName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      signinId: signinId ?? this.signinId,
      deviceId: deviceId ?? this.deviceId,
      platform: platform ?? this.platform,
      token: token ?? this.token,
      usernameError: usernameError ?? this.usernameError,
      emailError: emailError ?? this.emailError,
      phoneError: phoneError ?? this.phoneError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      addressError: addressError ?? this.addressError,
      rememberMe: rememberMe ?? this.rememberMe,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      isLoadingSendOtp: isLoadingSendOtp ?? this.isLoadingSendOtp,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState()) {
    _initAutoFields();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAutoLogin();
    });
  }

  void setUsername(String v) => state = state.copyWith(username: v, usernameError: "");
  void setEmail(String v) => state = state.copyWith(email: v, emailError: "");
  void setPassword(String v) => state = state.copyWith(password: v, passwordError: "");
  void setConfirmPassword(String v) => state = state.copyWith(confirmPassword: v, confirmPasswordError: "");
  void setPhone(String v) => state = state.copyWith(phone: v, phoneError: "");
  void setAddress(String v) => state = state.copyWith(address: v, addressError: "");
  void setCategory(String v) => state = state.copyWith(category: v);
  void setOrgName(String v) => state = state.copyWith(orgName: v);
  void setStartTime(String v) => state = state.copyWith(startTime: v);
  void setEndTime(String v) => state = state.copyWith(endTime: v);
  void setSigninId(String v) => state = state.copyWith(signinId: v);
  void setDeviceId(String v) => state = state.copyWith(deviceId: v);
  void setPlatform(String v) => state = state.copyWith(platform: v);
  void setToken(String v) => state = state.copyWith(token: v);

  void toggleRememberMe(bool? v) => state = state.copyWith(rememberMe: v ?? false);
  void toggleAgree(bool? v) => state = state.copyWith(agreeTerms: v ?? false);

  void reset() => state = const AuthState();

  Future<void> login(BuildContext context) async {
    String? emailErr;
    String? passwordErr;

    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

    if (state.email.isEmpty) {
      emailErr = "Email is required";
    } else if (!emailRegex.hasMatch(state.email)) {
      emailErr = "Invalid email format";
    }

    if (state.password.isEmpty) {
      passwordErr = "Password is required";
    } else if (state.password.length < 6) {
      passwordErr = "Password must be at least 6 characters";
    }

    state = state.copyWith(
      emailError: emailErr ?? "",
      passwordError: passwordErr ?? "",
    );

    if (emailErr != null || passwordErr != null) {
      showTopSnackBar(context, "Please fix the highlighted fields", isError: true);
      return;
    }

    final repo = AuthRepository();

    try {
      final response = await repo.login(
        email: state.email,
        password: state.password,
        platform: state.platform,
        token: state.token,
        deviceId: state.deviceId,
        signinId: state.signinId,
      );

      final res = response.data;

      if (res['status'] == "success") {
        if (state.rememberMe) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("email", state.email);
          await prefs.setString("token", res['data']['signinId']);
        }

        showTopSnackBar(context, "Login successful", isError: false);
        Navigator.pushNamed(context, '/home');
        return;
      } else {
        final msg = res['message'] ?? "Login failed";
        showTopSnackBar(context, msg, isError: true);
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      final msg = data?['message'] ?? "Login failed";
      showTopSnackBar(context, msg, isError: true);
    }
  }

  Future<void> register(BuildContext context) async {
    String? usernameErr, emailErr, phoneErr, passwordErr, confirmPasswordErr, addressErr;

    if (state.username.isEmpty) usernameErr = "Username is required";
    if (state.email.isEmpty) emailErr = "Email is required";
    if (state.phone.isEmpty) phoneErr = "Phone number is required";
    if (state.password.isEmpty) passwordErr = "Password is required";
    if (state.confirmPassword.isEmpty) confirmPasswordErr = "Please confirm your password";
    if (state.address.isEmpty) addressErr = "Address is required";

    state = state.copyWith(
      usernameError: usernameErr ?? "",
      emailError: emailErr ?? "",
      phoneError: phoneErr ?? "",
      passwordError: passwordErr ?? "",
      confirmPasswordError: confirmPasswordErr ?? "",
      addressError: addressErr ?? "",
    );

    if (usernameErr != null ||
        emailErr != null ||
        phoneErr != null ||
        passwordErr != null ||
        confirmPasswordErr != null ||
        addressErr != null) return;

    if (!state.agreeTerms) {
      showTopSnackBar(context, "Please accept Terms & Conditions", isError: true);
      return;
    }

    final repo = AuthRepository();

    try {
      final response = await repo.signup(
        userName: state.username,
        email: state.email,
        password: state.password,
        mobileNumber: "+91${state.phone}",
        category: state.category,
        address: state.address,
        orgName: state.orgName,
        startTime: state.startTime,
        endTime: state.endTime,
        signinId: state.signinId,
        deviceId: state.deviceId,
        platform: state.platform,
        token: state.token,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushNamed(context, '/home');
        return;
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      final msg = data?['message'] ?? "Registration failed";
      final errors = data?['errors'];

      if (errors != null) {
        state = state.copyWith(
          usernameError: errors['userName'] ?? "",
          emailError: errors['email'] ?? "",
          phoneError: errors['phone'] ?? "",
          addressError: errors['address'] ?? "",
        );
      }

      showTopSnackBar(context, msg, isError: true);
    }
  }

  Future<void> _initAutoFields() async {
    state = state.copyWith(platform: Theme.of(navigatorKey.currentContext!).platform.name.toLowerCase());
    state = state.copyWith(signinId: DateTime.now().millisecondsSinceEpoch.toString());

    try {
      final info = DeviceInfoPlugin();
      final android = await info.androidInfo;
      state = state.copyWith(deviceId: android.model ?? "");
    } catch (_) {}

    try {
      final fcm = await FirebaseMessaging.instance.getToken();
      if (fcm != null) state = state.copyWith(token: fcm);
    } catch (_) {}
  }

  Future<void> _checkAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString("email");
      final savedToken = prefs.getString("token");

      if (savedEmail != null && savedToken != null) {
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          '/home',
              (route) => false,
        );
      }
    } catch (e) {
      debugPrint("Auto login exception: $e");
    }
  }

  Future<void> sendOtp(BuildContext context) async {
    final email = state.email.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty) {
      state = state.copyWith(emailError: "Email cannot be empty");
      showTopSnackBar(context, "Please enter an email", isError: true);
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      state = state.copyWith(emailError: "Invalid email format");
      showTopSnackBar(context, "Enter a valid email address", isError: true);
      return;
    }

    state = state.copyWith(emailError: "");
    state = state.copyWith(isLoadingSendOtp: true);

    try {
      final repo = AuthRepository();
      final res = await repo.sendOtp(email);

      if (res.data['status'] == "success") {
        showTopSnackBar(context, "OTP sent to your email", isError: false);
        Navigator.pushNamed(context, '/otp');
      } else {
        showTopSnackBar(context, res.data['message'] ?? "Failed to send OTP", isError: true);
      }
    } catch (_) {
      showTopSnackBar(context, "Something went wrong", isError: true);
    }

    state = state.copyWith(isLoadingSendOtp: false);
  }

  Future<void> verifyOtp(BuildContext context, String otp) async {
    if (otp.length != 6 || int.tryParse(otp) == null) {
      showTopSnackBar(context, "Enter valid 6-digit OTP", isError: true);
      return;
    }

    try {
      final repo = AuthRepository();
      final res = await repo.verifyOtp(state.email.trim(), otp);

      if (res.data['status'] == "success") {
        showTopSnackBar(context, "OTP verified", isError: false);
        Navigator.pushNamed(context, "/home");
      } else {
        showTopSnackBar(context, res.data['message'] ?? "OTP verification failed", isError: true);
      }
    } catch (_) {
      showTopSnackBar(context, "Invalid OTP", isError: true);
    }
  }

  void goToRegister(BuildContext context) {
    reset();
    Navigator.pushNamed(context, '/register');
  }

  void goToLogin(BuildContext context) {
    reset();
    Navigator.pushNamed(context, '/login');
  }

  void updateEmailError(String msg) => state = state.copyWith(emailError: msg);
}