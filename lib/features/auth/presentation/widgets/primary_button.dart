import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool hasArrow;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: size.height * 0.022),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTextStyles.heading(
                size.width * 0.045,
                color: Colors.white,
              ),
            ),
            if (hasArrow) ...[
              SizedBox(width: size.width * 0.02),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: size.width * 0.045,
                color: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}