🚀 TaskApp — Authentication Flow (Flutter + Riverpod + Dio)

TaskApp is a clean and scalable Flutter application implementing a complete authentication flow using Riverpod State Management, Dio API Client, and Shared Preferences for session storage.

📌 Features

✔ Email & Password Login
✔ Registration
✔ Forgot Password + OTP Verification
✔ Auto Login / Remember Me
✔ FCM Token + Device ID tracking
✔ Centralized API client with Dio
✔ Responsive UI & Reusable Widgets
✔ Clean folder architecture

🛠 Tech Stack
Layer	Technology
State Management	Riverpod
API Client	Dio
Local Storage	Shared Preferences
UI	Flutter
Push Token	Firebase Messaging
Device Info	device_info_plus
📁 Project Structure
lib/
│  main.dart
│
├─ app/
│   └─ router.dart
│
├─ core/
│   ├─ navigation/
│   │   └─ navigation_key.dart
│   ├─ theme/
│   │   ├─ app_colors.dart
│   │   ├─ app_theme.dart
│   │   └─ text_styles.dart
│   └─ widgets/
│       ├─ arrow_icon.dart
│       └─ logout_button.dart
│
├─ data/
│   ├─ network/
│   │   ├─ api_client.dart
│   │   └─ endpoints.dart
│   └─ repositories/
│       └─ auth_repository.dart
│
└─ features/
└─ auth/
├─ controllers/
│   ├─ auth_controller.dart
│   ├─ slide_controller.dart
│   └─ welcome_controller.dart
├─ screens/
│   ├─ welcome_screen.dart
│   ├─ login/
│   │   └─ login_screen.dart
│   ├─ register/
│   │   └─ register_screen.dart
│   ├─ forgot_password/
│   │   └─ forgot_password_screen.dart
│   ├─ otp/
│   │   └─ otp_screen.dart
│   ├─ home/
│   │   └─ home_screen.dart
│   └─ slide_screens/
│       └─ slide_screens.dart
└─ widgets/
├─ primary_button.dart
└─ text_field.dart

🔗 API Endpoints (Example)

Configured inside data/network/endpoints.dart

static const login = "/auth/login";
static const signup = "/auth/signup";
static const sendOtp = "/auth/sendOtp";
static const verifyOtp = "/auth/verifyOtp";

🔑 Environment Setup

Add required permissions for Dio in android/app/src/main/AndroidManifest.xml:

<uses-permission android:name="android.permission.INTERNET" />

▶️ Run the Project
flutter pub get
flutter run

📦 Build Release APK
flutter clean
flutter pub get
flutter build apk --release


APK Output location:

build/app/outputs/flutter-apk/app-release.apk

🧱 Future Enhancements

🔹 Google / Facebook sign-in
🔹 Multi-role dashboards
🔹 Modularization for scale
🔹 API error interceptor system

👨‍💻 Developed by

Nibin Joseph