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

  void _showTopSnackBar(BuildContext context, String message, {bool isError = false}) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(authControllerProvider.notifier);
    final state = ref.watch(authControllerProvider);
    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;


    final isSmallScreen = size.height < 700;
    final isTinyScreen = size.height < 600;
    final isLandscape = size.width > size.height;


    final topSpacing = isLandscape
        ? size.height * 0.15
        : (isTinyScreen ? size.height * 0.25 : (isSmallScreen ? size.height * 0.3 : size.height * 0.38));

    final fieldSpacing = isLandscape
        ? size.height * 0.02
        : (isTinyScreen ? size.height * 0.015 : size.height * 0.025);

    final buttonTopSpacing = isLandscape
        ? size.height * 0.03
        : (isTinyScreen ? size.height * 0.04 : size.height * 0.08);

    return GestureDetector(
      onTap: () {

        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(
                  horizontal: isLandscape ? size.width * 0.15 : size.width * 0.085,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [

                        if (!isLandscape && keyboardHeight == 0)
                          SizedBox(
                            height: topSpacing,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: isTinyScreen ? size.height * 0.01 : size.height * 0.015,
                                    ),
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
                                  bottom: isTinyScreen ? size.height * 0.05 : size.height * 0.083,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Welcome back",
                                        style: AppTextStyles.heading(
                                          isTinyScreen ? size.width * 0.065 : size.width * 0.073,
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
                                          isTinyScreen ? size.width * 0.035 : size.width * 0.038,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),


                        if (isLandscape || keyboardHeight > 0)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                            child: Column(
                              children: [
                                Text(
                                  "Welcome back",
                                  style: AppTextStyles.heading(
                                    size.width * 0.045,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.005),
                                Text(
                                  "sign in to access your account",
                                  style: AppTextStyles.body(
                                    size.width * 0.03,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        SizedBox(height: keyboardHeight > 0 ? size.height * 0.02 : size.height * 0.05),


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              hint: "Enter your email",
                              icon: Icons.email_outlined,
                              onChanged: controller.setEmail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            if (state.emailError.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.005,
                                  left: size.width * 0.01,
                                ),
                                child: Text(
                                  state.emailError,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: size.width * 0.032,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: fieldSpacing),


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              hint: "Password",
                              icon: Icons.lock_outline,
                              obscureText: true,
                              onChanged: controller.setPassword,
                            ),
                            if (state.passwordError.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.005,
                                  left: size.width * 0.01,
                                ),
                                child: Text(
                                  state.passwordError,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: size.width * 0.032,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: fieldSpacing * 1.2),


                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => controller.toggleRememberMe(!state.rememberMe),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: state.rememberMe ? AppColors.primary : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: state.rememberMe ? AppColors.primary : const Color(0xFFCBCBCB),
                                    width: 1.5,
                                  ),
                                ),
                                child: state.rememberMe
                                    ? const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                )
                                    : null,
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              "Remember me",
                              style: AppTextStyles.body(
                                isLandscape ? size.width * 0.028 : size.width * 0.035,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.pushNamed(context, '/forgot-password');
                              },
                              child: Text(
                                "Forget password ?",
                                style: AppTextStyles.body(
                                  isLandscape ? size.width * 0.028 : size.width * 0.035,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: buttonTopSpacing),


                        PrimaryButton(
                          label: "Next",
                          hasArrow: true,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            controller.login(context);
                          },
                        ),

                        SizedBox(height: isLandscape ? size.height * 0.02 : size.height * 0.04),


                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            controller.reset();
                            controller.goToRegister(context);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "New Member? ",
                              style: AppTextStyles.body(
                                isLandscape ? size.width * 0.03 : size.width * 0.038,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Register now",
                                  style: AppTextStyles.body(
                                    isLandscape ? size.width * 0.03 : size.width * 0.038,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: isLandscape ? size.height * 0.02 : size.height * 0.05),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}