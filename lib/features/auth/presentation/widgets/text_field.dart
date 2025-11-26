import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final String? error;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.error,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPassword = widget.obscureText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          obscureText: isPassword && !_isPasswordVisible,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          style: AppTextStyles.body(size.width * 0.04, color: Colors.black),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.body(size.width * 0.04, color: Colors.black38),
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            contentPadding: EdgeInsets.symmetric(
              vertical: size.height * 0.022,
              horizontal: size.width * 0.045,
            ),
            suffixIcon: isPassword
                ? Padding(
              padding: EdgeInsets.only(right: size.width * 0.01),
              child: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  size: size.width * 0.06,
                  color: const Color(0xFFCBCBCB),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            )
                : Padding(
              padding: EdgeInsets.only(right: size.width * 0.04),
              child: Icon(
                widget.icon,
                size: size.width * 0.06,
                color: const Color(0xFFCBCBCB),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: (widget.error != null && widget.error!.isNotEmpty) ? Colors.red : Colors.transparent,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: (widget.error != null && widget.error!.isNotEmpty) ? Colors.red : Colors.transparent,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: (widget.error != null && widget.error!.isNotEmpty) ? Colors.red : AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
        if (widget.error != null && widget.error!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.005, left: size.width * 0.01),
            child: Text(
              widget.error!,
              style: TextStyle(
                color: Colors.red,
                fontSize: size.width * 0.032,
              ),
            ),
          ),
      ],
    );
  }
}