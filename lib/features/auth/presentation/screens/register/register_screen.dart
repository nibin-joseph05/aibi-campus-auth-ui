import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_field.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(authControllerProvider.notifier);
    final state = ref.watch(authControllerProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.07,
            vertical: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.38,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child: SizedBox(
                          width: size.width * 1.45,
                          child: SvgPicture.asset(
                            "assets/images/register/register_header.svg",
                            fit: BoxFit.contain,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: size.height * 0.083,
                      child: Column(
                        children: [
                          Text(
                            "Get Started",
                            style: AppTextStyles.heading(
                              size.width * 0.073,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: size.height * 0.006),
                          Container(
                            width: size.width * 0.02,
                            height: size.width * 0.02,
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            "by creating a free account",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body(
                              size.width * 0.038,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.035),


              CustomTextField(
                hint: "Full name",
                icon: Icons.person_outline,
                onChanged: controller.setName,
              ),
              SizedBox(height: size.height * 0.018),

              CustomTextField(
                hint: "Valid email",
                icon: Icons.email_outlined,
                onChanged: controller.setEmail,
              ),
              SizedBox(height: size.height * 0.018),

              CustomTextField(
                hint: "Phone number",
                icon: Icons.phone_android_outlined,
                onChanged: controller.setPhone,
              ),
              SizedBox(height: size.height * 0.018),

              CustomTextField(
                hint: "Strong Password",
                icon: Icons.lock_outline,
                obscureText: true,
                onChanged: controller.setPassword,
              ),

              SizedBox(height: size.height * 0.018),
              Row(
                children: [
                  Checkbox(
                    value: state.agreeTerms,
                    onChanged: controller.toggleAgree,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "By checking the box you agree to our ",
                        style: AppTextStyles.body(size.width * 0.035,
                            color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Terms and Conditions.",
                            style: AppTextStyles.body(size.width * 0.035,
                                color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.035),


              PrimaryButton(
                label: "Next",
                hasArrow: true,
                onTap: () => controller.register(context),
              ),
              SizedBox(height: size.height * 0.03),


              Center(
                child: GestureDetector(
                  onTap: () {
                    controller.reset();
                    Navigator.pushNamed(context, '/login');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already a member? ",
                      style: AppTextStyles.body(size.width * 0.045,
                          color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Log In",
                          style: AppTextStyles.body(size.width * 0.045,
                              color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
