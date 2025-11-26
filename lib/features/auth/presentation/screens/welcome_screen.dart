import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/welcome_controller.dart';
import '../../../../core/theme/text_styles.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1300), () {
      ref.read(welcomeControllerProvider.notifier).goToSlides(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: isSmall ? size.height * 0.10 : size.height * 0.20),


              SvgPicture.asset(
                "assets/images/welcome/balloon.svg",
                height: isSmall ? size.height * 0.28 : size.height * 0.34,
              ),

              SizedBox(height: isSmall ? size.height * 0.04 : size.height * 0.06),


              FittedBox(
                child: Row(
                  children: [
                    Text(
                      "Explora",
                      style: AppTextStyles.heading(size.width * 0.11, color: Colors.white),
                    ),
                    SizedBox(width: size.width * 0.02),
                    SvgPicture.asset(
                      "assets/images/welcome/logo_wave.svg",
                      width: size.width * 0.12,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
