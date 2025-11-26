import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final slideControllerProvider =
StateNotifierProvider<SlideController, int>((ref) => SlideController());

class SlideController extends StateNotifier<int> {
  SlideController() : super(0);

  final PageController pageController = PageController();

  void onPageChanged(int index) {
    state = index;
  }

  void next(BuildContext context) {
    if (state < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }
}
