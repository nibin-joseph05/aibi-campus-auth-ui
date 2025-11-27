import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/arrow_icon.dart';
import '../../widgets/primary_button.dart';
import '../../controllers/auth_controller.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});
  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final List<TextEditingController> boxes =
  List.generate(6, (_) => TextEditingController());

  String get otp => boxes.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = ref.read(authControllerProvider.notifier);
    final state = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.06),

                  Text(
                    "Almost there",
                    style: AppTextStyles.heading(
                      size.width * 0.065,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: size.height * 0.018),

                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.body(
                        size.width * 0.04,
                        color: Colors.black87,
                      ),
                      children: [
                        const TextSpan(text: "Please enter the 6-digit code sent to your email "),
                        TextSpan(
                          text: state.email,
                          style: AppTextStyles.body(
                            size.width * 0.04,
                            color: Colors.black,
                          ).copyWith(fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(text: " for verification."),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.06),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (i) {
                      return Container(
                        width: size.width * 0.11,
                        height: size.width * 0.13,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: boxes[i],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                          ),
                          onChanged: (v) {
                            if (v.isNotEmpty && i < 5) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: size.height * 0.06),

                  PrimaryButton(
                    label: "VERIFY",
                    hasArrow: false,
                    onTap: () => controller.verifyOtp(context, otp),
                  ),

                  SizedBox(height: size.height * 0.06),

                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Didn’t receive any code? Resend Again",
                          style: AppTextStyles.body(
                            size.width * 0.04,
                            color: Colors.black,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: size.height * 0.004),
                        Text(
                          "Request new code in 00:30s",
                          style: AppTextStyles.body(
                            size.width * 0.035,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: size.height * 0.045,
              left: size.width * 0.06,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: size.width * 0.16,
                  height: size.width * 0.16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Transform.flip(
                      flipX: true,
                      child: ArrowIcon(size: size.width * 0.055),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
