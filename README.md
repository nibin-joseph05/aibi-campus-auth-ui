TaskApp

TaskApp is a Flutter application that implements a complete authentication flow, including login, registration, forgot password with OTP verification, and auto-login using local storage.

Features

User Registration

Login with email and password

Forgot Password (Send OTP)

OTP Verification

Auto Login / Remember Me

API integration using Dio

State management using Riverpod

Technologies Used

Flutter

Riverpod

Dio

Shared Preferences

Firebase Messaging (FCM token)

device_info_plus



Project Structure
lib/
main.dart
app/
router.dart
core/
navigation/navigation_key.dart
theme/app_colors.dart
theme/app_theme.dart
theme/text_styles.dart
widgets/arrow_icon.dart
widgets/logout_button.dart
data/
network/api_client.dart
network/endpoints.dart
repositories/auth_repository.dart
features/
auth/
controllers/
auth_controller.dart
slide_controller.dart
welcome_controller.dart
screens/
welcome_screen.dart
login/login_screen.dart
register/register_screen.dart
forgot_password/forgot_password_screen.dart
otp/otp_screen.dart
home/home_screen.dart
slide_screens/slide_screens.dart
widgets/
primary_button.dart
text_field.dart

API Endpoints

The application interacts with backend authentication endpoints:

/auth/signup

/auth/login

/auth/sendOtp

/auth/verifyOtp

Requirements

Flutter SDK installed

Internet access for API calls

Add the required permission for HTTP/Dio in AndroidManifest.xml:

<uses-permission android:name="android.permission.INTERNET" />

Running the App
flutter pub get
flutter run

Building APK
flutter build apk --release


APK will be located at:

build/app/outputs/flutter-apk/app-release.apk