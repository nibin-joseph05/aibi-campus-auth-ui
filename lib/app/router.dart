import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/login/login_screen.dart';
import '../features/auth/presentation/screens/otp/otp_screen.dart';
import '../features/auth/presentation/screens/register/register_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/auth/presentation/screens/slide_screens/slide_screens.dart';
import '../features/auth/presentation/screens/home/home_screen.dart';
import '../features/auth/presentation/screens/forgot_password/forgot_password_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case '/slides':
        return MaterialPageRoute(builder: (_) => const SlideScreens());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/otp':
        return MaterialPageRoute(builder: (_) => const OtpScreen());


      default:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    }
  }
}
