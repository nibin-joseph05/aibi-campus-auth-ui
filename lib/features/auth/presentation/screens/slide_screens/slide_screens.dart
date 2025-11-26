import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/arrow_icon.dart';
import '../../controllers/slide_controller.dart';

class SlideScreens extends ConsumerWidget {
  const SlideScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(slideControllerProvider);
    final controller = ref.read(slideControllerProvider.notifier);
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    final slides = [
      {
        "image": "assets/images/slides/slide1.svg",
        "title": "Explore the world easily",
        "subtitle": "To your desire",
      },
      {
        "image": "assets/images/slides/slide2.svg",
        "title": "Reach the unknown spot",
        "subtitle": "To your destination",
      },
      {
        "image": "assets/images/slides/slide3.svg",
        "title": "Make connects with explora",
        "subtitle": "To your dream trip",
      }
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: controller.pageController,
              itemCount: slides.length,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (_, index) {
                final s = slides[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: isSmall ? size.height * 0.05 : size.height * 0.09),
                      Center(
                        child: SvgPicture.asset(
                          s["image"]!,
                          height: isSmall ? size.height * 0.34 : size.height * 0.42,
                        ),
                      ),
                      SizedBox(height: isSmall ? size.height * 0.06 : size.height * 0.10),
                      Text(
                        s["title"]!,
                        style: AppTextStyles.heading(size.width * 0.085, color: Colors.black),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        s["subtitle"]!,
                        style: AppTextStyles.body(size.width * 0.045, color: Colors.black54),
                      ),
                      SizedBox(height: size.height * 0.045),
                      _buildIndicators(currentIndex),
                    ],
                  ),
                );
              },
            ),


            Positioned(
              bottom: size.height * 0.06,
              right: size.width * 0.07,
              child: GestureDetector(
                onTap: () => controller.next(context),
                child: Container(
                  width: size.width * 0.15,
                  height: size.width * 0.15,
                  decoration: const BoxDecoration(
                    color: Color(0xFF252525),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: ArrowIcon(size: size.width * 0.06),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildIndicators(int index) {
    return Row(
      children: List.generate(
        3,
            (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(right: 6),
          width: index == i ? 26 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == i ? AppColors.primary : Colors.black54,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
