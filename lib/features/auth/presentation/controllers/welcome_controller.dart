import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/slide_screens/slide_screens.dart';

final welcomeControllerProvider =
StateNotifierProvider<WelcomeController, bool>(
      (ref) => WelcomeController(),
);

class WelcomeController extends StateNotifier<bool> {
  WelcomeController() : super(false);

  void goToSlides(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, animation, __) {
          return FadeTransition(
            opacity: animation,
            child: const SlideScreens(),
          );
        },
      ),
    );
  }
}
