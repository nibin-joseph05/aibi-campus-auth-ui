import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../widgets/text_field.dart';
import '../../widgets/primary_button.dart';
import '../../controllers/auth_controller.dart';
import '../../../../../core/widgets/arrow_icon.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(authControllerProvider.notifier);
    final state = ref.watch(authControllerProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.07),

                  Text(
                    "Forgot Password",
                    style: AppTextStyles.heading(
                      size.width * 0.07,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: size.height * 0.012),

                  Text(
                    "Enter the email linked with your account and\nwe’ll send you a verification code.",
                    style: AppTextStyles.body(
                      size.width * 0.04,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),

                  SizedBox(height: size.height * 0.10),

                  CustomTextField(
                    hint: "Email address",
                    icon: Icons.email_outlined,
                    onChanged: controller.setEmail,
                    error: state.emailError.isNotEmpty ? state.emailError : null,
                  ),

                  SizedBox(height: size.height * 0.06),

                  PrimaryButton(
                    label: "Send OTP",
                    hasArrow: true,
                    onTap: () {
                      final email = state.email.trim();

                      if (email.isEmpty) {
                        controller.updateEmailError("Email cannot be empty");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter an email")),
                        );
                        return;
                      }

                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                      if (!emailRegex.hasMatch(email)) {
                        controller.updateEmailError("Invalid email format");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Enter a valid email address")),
                        );
                        return;
                      }

                      controller.updateEmailError("");
                      Navigator.pushNamed(context, '/otp');
                    },
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: size.height * 0.045,
              left: size.width * 0.06,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: size.width * 0.16,
                  height: size.width * 0.16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Transform.flip(
                      flipX: true,
                      child: ArrowIcon(size: size.width * 0.055),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
