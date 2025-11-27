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
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;


    final isSmallScreen = size.height < 700;
    final isTinyScreen = size.height < 600;
    final isLandscape = size.width > size.height;
    final isTablet = size.shortestSide >= 600;


    final headerHeight = isLandscape
        ? 0.0
        : (isTinyScreen ? size.height * 0.2 : (isSmallScreen ? size.height * 0.25 : size.height * 0.33));

    final fieldSpacing = isLandscape
        ? size.height * 0.015
        : (isTinyScreen ? size.height * 0.012 : size.height * 0.015);

    final sectionSpacing = isLandscape
        ? size.height * 0.02
        : (isTinyScreen ? size.height * 0.015 : size.height * 0.025);

    final bottomSpacing = isLandscape
        ? size.height * 0.02
        : (isTinyScreen ? size.height * 0.02 : size.height * 0.03);

    final horizontalPadding = isLandscape
        ? size.width * 0.15
        : (isTablet ? size.width * 0.12 : size.width * 0.07);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  children: [

                    if (!isLandscape && keyboardHeight == 0 && headerHeight > 0)
                      SizedBox(
                        height: headerHeight,
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
                                    "assets/images/register/register_header.svg",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: isTinyScreen ? size.height * 0.035 : size.height * 0.053,
                              child: Column(
                                children: [
                                  Text(
                                    "Get Started",
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
                                  SizedBox(height: size.height * 0.009),
                                  Text(
                                    "by creating a free account",
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
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
                        child: Column(
                          children: [
                            Text(
                              "Get Started",
                              style: AppTextStyles.heading(
                                isLandscape ? size.width * 0.04 : size.width * 0.055,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text(
                              "by creating a free account",
                              style: AppTextStyles.body(
                                isLandscape ? size.width * 0.028 : size.width * 0.032,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: sectionSpacing),


                    if (isLandscape || isTablet)
                      _buildGridLayout(
                        context,
                        controller,
                        state,
                        size,
                        fieldSpacing,
                        isLandscape,
                        isTablet,
                      )
                    else
                      _buildVerticalLayout(
                        context,
                        controller,
                        state,
                        size,
                        fieldSpacing,
                      ),

                    SizedBox(height: fieldSpacing),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => controller.toggleAgree(!state.agreeTerms),
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: state.agreeTerms ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: state.agreeTerms ? AppColors.primary : const Color(0xFFCBCBCB),
                                width: 1.5,
                              ),
                            ),
                            child: state.agreeTerms
                                ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: "By checking the box you agree to our ",
                              style: AppTextStyles.body(
                                isLandscape ? size.width * 0.028 : size.width * 0.035,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Terms and Conditions.",
                                  style: AppTextStyles.body(
                                    isLandscape ? size.width * 0.028 : size.width * 0.035,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: bottomSpacing),


                    PrimaryButton(
                      label: "Next",
                      hasArrow: true,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.register(context);
                      },
                    ),

                    SizedBox(height: fieldSpacing * 1.5),


                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.reset();
                        Navigator.pushNamed(context, '/login');
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already a member? ",
                          style: AppTextStyles.body(
                            isLandscape ? size.width * 0.03 : size.width * 0.038,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Log In",
                              style: AppTextStyles.body(
                                isLandscape ? size.width * 0.03 : size.width * 0.038,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: bottomSpacing),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }


  Widget _buildVerticalLayout(
      BuildContext context,
      AuthController controller,
      AuthState state,
      Size size,
      double fieldSpacing,
      ) {
    return Column(
      children: [
        CustomTextField(
          hint: "Username",
          icon: Icons.person_outline,
          onChanged: controller.setUsername,
          error: state.usernameError,
        ),
        SizedBox(height: fieldSpacing),

        CustomTextField(
          hint: "Valid email",
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          onChanged: controller.setEmail,
          error: state.emailError,
        ),
        SizedBox(height: fieldSpacing),

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
        SizedBox(height: fieldSpacing),

        CustomTextField(
          hint: "Strong Password",
          icon: Icons.lock_outline,
          obscureText: true,
          onChanged: controller.setPassword,
          error: state.passwordError,
        ),
        SizedBox(height: fieldSpacing),

        CustomTextField(
          hint: "Confirm Password",
          icon: Icons.lock_reset_outlined,
          obscureText: true,
          onChanged: controller.setConfirmPassword,
          error: state.confirmPasswordError,
        ),
        SizedBox(height: fieldSpacing),

        CustomTextField(
          hint: "Category (Eg: Organization / Individual)",
          icon: Icons.category_outlined,
          onChanged: controller.setCategory,
        ),
        SizedBox(height: fieldSpacing),

        CustomTextField(
          hint: "Organization Name",
          icon: Icons.business_outlined,
          onChanged: controller.setOrgName,
        ),
        SizedBox(height: fieldSpacing),

        _buildTimePicker(
          context,
          controller,
          state.startTime,
          "Select Start Time",
          Icons.access_time_outlined,
              (time) => controller.setStartTime(time),
        ),
        SizedBox(height: fieldSpacing),

        _buildTimePicker(
          context,
          controller,
          state.endTime,
          "Select End Time",
          Icons.access_time_filled_outlined,
              (time) => controller.setEndTime(time),
        ),
        SizedBox(height: fieldSpacing),

        CustomTextField(
          hint: "Address",
          icon: Icons.location_on_outlined,
          onChanged: controller.setAddress,
          error: state.addressError,
        ),
      ],
    );
  }


  Widget _buildGridLayout(
      BuildContext context,
      AuthController controller,
      AuthState state,
      Size size,
      double fieldSpacing,
      bool isLandscape,
      bool isTablet,
      ) {
    return Column(
      children: [

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hint: "Username",
                icon: Icons.person_outline,
                onChanged: controller.setUsername,
                error: state.usernameError,
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              child: CustomTextField(
                hint: "Valid email",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                onChanged: controller.setEmail,
                error: state.emailError,
              ),
            ),
          ],
        ),
        SizedBox(height: fieldSpacing),


        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    height: size.height * 0.065,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "+91",
                      style: AppTextStyles.body(
                        isLandscape ? size.width * 0.035 : size.width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.015),
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
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              child: CustomTextField(
                hint: "Strong Password",
                icon: Icons.lock_outline,
                obscureText: true,
                onChanged: controller.setPassword,
                error: state.passwordError,
              ),
            ),
          ],
        ),
        SizedBox(height: fieldSpacing),


        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hint: "Confirm Password",
                icon: Icons.lock_reset_outlined,
                obscureText: true,
                onChanged: controller.setConfirmPassword,
                error: state.confirmPasswordError,
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              child: CustomTextField(
                hint: "Category (Eg: Organization / Individual)",
                icon: Icons.category_outlined,
                onChanged: controller.setCategory,
              ),
            ),
          ],
        ),
        SizedBox(height: fieldSpacing),


        Row(
          children: [
            Expanded(
              child: CustomTextField(
                hint: "Organization Name",
                icon: Icons.business_outlined,
                onChanged: controller.setOrgName,
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              child: _buildTimePicker(
                context,
                controller,
                state.startTime,
                "Select Start Time",
                Icons.access_time_outlined,
                    (time) => controller.setStartTime(time),
              ),
            ),
          ],
        ),
        SizedBox(height: fieldSpacing),


        Row(
          children: [
            Expanded(
              child: _buildTimePicker(
                context,
                controller,
                state.endTime,
                "Select End Time",
                Icons.access_time_filled_outlined,
                    (time) => controller.setEndTime(time),
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Expanded(
              child: CustomTextField(
                hint: "Address",
                icon: Icons.location_on_outlined,
                onChanged: controller.setAddress,
                error: state.addressError,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimePicker(
      BuildContext context,
      AuthController controller,
      String currentValue,
      String hint,
      IconData icon,
      Function(String) onTimeSelected,
      ) {
    return InkWell(
      onTap: () async {
        FocusScope.of(context).unfocus();
        final picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null) {
          onTimeSelected(_formatTime(picked));
        }
      },
      child: AbsorbPointer(
        absorbing: true,
        child: CustomTextField(
          hint: currentValue.isEmpty ? hint : currentValue,
          icon: icon,
        ),
      ),
    );
  }
}