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
    final height = size.height;
    final width = size.width;

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
        child: Column(
          children: [

            Expanded(
              flex: 8,
              child: Expanded(
                flex: 8,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: slides.length,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (_, index) {
                    final s = slides[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                      child: LayoutBuilder(
                        builder: (_, c) {
                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: c.maxHeight),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: SvgPicture.asset(
                                      s["image"]!,
                                      height: height * 0.33,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.04),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      s["title"]!,
                                      style: AppTextStyles.heading(width * 0.085, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.015),
                                  Text(
                                    s["subtitle"]!,
                                    style: AppTextStyles.body(width * 0.045, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

            ),


            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    _buildIndicators(currentIndex),


                    GestureDetector(
                      onTap: () => controller.next(context),
                      child: Container(
                        width: width * 0.16,
                        height: width * 0.16,
                        decoration: const BoxDecoration(
                          color: Color(0xFF252525),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: ArrowIcon(size: width * 0.055),
                      ),
                    ),
                  ],
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
            color: index == i ? AppColors.primary : Colors.black26,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
