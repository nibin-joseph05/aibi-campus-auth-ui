import 'package:flutter/material.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      style: AppTextStyles.body(size.width * 0.04, color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.body(size.width * 0.04, color: Colors.black38),
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        contentPadding: EdgeInsets.symmetric(
          vertical: size.height * 0.022,
          horizontal: size.width * 0.045,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: size.width * 0.04),
          child: Icon(
            icon,
            size: size.width * 0.06,
            color: const Color(0xFFCBCBCB),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}