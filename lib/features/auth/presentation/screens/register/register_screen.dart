import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/text_field.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }


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
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
          child: Column(
            children: [
              SizedBox(
                height: isSmall ? size.height * 0.30 : size.height * 0.33,
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
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: size.height * 0.053,
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
                          SizedBox(height: size.height * 0.009),
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
              SizedBox(height: size.height * 0.025),


              CustomTextField(
                hint: "Username",
                icon: Icons.person_outline,
                onChanged: controller.setUsername,
                error: state.usernameError,
              ),
              SizedBox(height: size.height * 0.015),


              CustomTextField(
                hint: "Valid email",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                onChanged: controller.setEmail,
                error: state.emailError,
              ),
              SizedBox(height: size.height * 0.015),


              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    height: size.height * 0.065,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "+91",
                      style: AppTextStyles.body(size.width * 0.045, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Expanded(
                    child: CustomTextField(
                      hint: "Phone number",
                      icon: Icons.phone_android_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: controller.setPhone,
                      error: state.phoneError,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.015),


              CustomTextField(
                hint: "Strong Password",
                icon: Icons.lock_outline,
                obscureText: true,
                onChanged: controller.setPassword,
                error: state.passwordError,
              ),
              SizedBox(height: size.height * 0.015),


              CustomTextField(
                hint: "Confirm Password",
                icon: Icons.lock_reset_outlined,
                obscureText: true,
                onChanged: controller.setConfirmPassword,
                error: state.confirmPasswordError,
              ),
              SizedBox(height: size.height * 0.015),


              CustomTextField(
                hint: "Category (Eg: Organization / Individual)",
                icon: Icons.category_outlined,
                onChanged: controller.setCategory,
              ),
              SizedBox(height: size.height * 0.015),


              CustomTextField(
                hint: "Organization Name",
                icon: Icons.business_outlined,
                onChanged: controller.setOrgName,
              ),
              SizedBox(height: size.height * 0.015),

              InkWell(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) controller.setStartTime(_formatTime(picked));
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: CustomTextField(
                    hint: state.startTime.isEmpty ? "Select Start Time" : state.startTime,
                    icon: Icons.access_time_outlined,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.015),

              InkWell(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) controller.setEndTime(_formatTime(picked));
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: CustomTextField(
                    hint: state.endTime.isEmpty ? "Select End Time" : state.endTime,
                    icon: Icons.access_time_filled_outlined,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.015),

              CustomTextField(
                hint: "Address",
                icon: Icons.location_on_outlined,
                onChanged: controller.setAddress,
                error: state.addressError,
              ),
              SizedBox(height: size.height * 0.01),


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
                        style: AppTextStyles.body(
                          size.width * 0.035,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms and Conditions.",
                            style: AppTextStyles.body(
                              size.width * 0.035,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03),


              PrimaryButton(
                label: "Next",
                hasArrow: true,
                onTap: () => controller.register(context),
              ),
              SizedBox(height: size.height * 0.028),


              GestureDetector(
                onTap: () {
                  controller.reset();
                  Navigator.pushNamed(context, '/login');
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already a member? ",
                    style: AppTextStyles.body(
                      size.width * 0.038,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Log In",
                        style: AppTextStyles.body(
                          size.width * 0.038,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
