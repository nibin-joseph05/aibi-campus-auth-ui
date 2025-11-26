import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../widgets/text_field.dart';
import '../../widgets/primary_button.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(authControllerProvider.notifier);
    final state = ref.watch(authControllerProvider);
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.085),
          child: Column(
            children: [
              SizedBox(
                height: isSmall ? size.height * 0.35 : size.height * 0.38,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child: SizedBox(
                          width: size.width * 1.45,
                          child: SvgPicture.asset(
                            "assets/images/login/login_header.svg",
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
                            "Welcome back",
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
                            "sign in to access your account",
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


              SizedBox(height: size.height * 0.05),


              CustomTextField(
                hint: "Enter your email",
                icon: Icons.email_outlined,
                onChanged: controller.setEmail,
              ),

              SizedBox(height: size.height * 0.025),


              CustomTextField(
                hint: "Password",
                icon: Icons.lock_outline,
                obscureText: true,
                onChanged: controller.setPassword,
              ),

              SizedBox(height: size.height * 0.03),


              Row(
                children: [

                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: const Color(0xFFCBCBCB),
                        width: 1.5,
                      ),
                    ),
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.transparent,
                      ),
                      child: Checkbox(
                        value: state.rememberMe,
                        onChanged: controller.toggleRememberMe,
                        activeColor: AppColors.primary,
                        checkColor: Colors.white,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: size.width * 0.02),

                  Text(
                    "Remember me",
                    style: AppTextStyles.body(
                      size.width * 0.035,
                      color: Colors.black,
                    ),
                  ),

                  const Spacer(),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: Text(
                      "Forget password ?",
                      style: AppTextStyles.body(
                        size.width * 0.035,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.08),


              PrimaryButton(
                label: "Next",
                hasArrow: true,
                onTap: () => controller.login(context),
              ),

              SizedBox(height: size.height * 0.04),


              GestureDetector(
                onTap: () {
                  controller.reset();
                  controller.goToRegister(context);
                },

                child: RichText(
                  text: TextSpan(
                    text: "New Member? ",
                    style: AppTextStyles.body(
                      size.width * 0.038,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Register now",
                        style: AppTextStyles.body(
                          size.width * 0.038,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}