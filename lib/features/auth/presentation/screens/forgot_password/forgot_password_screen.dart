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
    final height = size.height;
    final width = size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: width * 0.075),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: height * 0.95),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  SizedBox(height: height * 0.06),
                  Text(
                    "Forgot Password",
                    style: AppTextStyles.heading(width * 0.07, color: Colors.black),
                  ),

                  SizedBox(height: height * 0.015),


                  Text(
                    "Enter the email linked with your account and we’ll send you a verification code.",
                    style: AppTextStyles.body(width * 0.04, color: Colors.black.withOpacity(0.7)),
                  ),

                  SizedBox(height: height * 0.10),


                  CustomTextField(
                    hint: "Email address",
                    icon: Icons.email_outlined,
                    onChanged: controller.setEmail,
                    error: state.emailError.isNotEmpty ? state.emailError : null,
                  ),

                  SizedBox(height: height * 0.07),


                  PrimaryButton(
                    label: "Send OTP",
                    hasArrow: true,
                    isLoading: state.isLoadingSendOtp,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      controller.sendOtp(context);
                    },
                  ),

                  SizedBox(height: height * 0.10),
                ],
              ),
            ),
          ),
        ),


        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: width * 0.04, bottom: height * 0.025),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: (width * 0.13).clamp(45, 60),
              height: (width * 0.13).clamp(45, 60),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: ArrowIcon(
                size: (width * 0.048).clamp(16, 26),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,

      ),
    );
  }
}
