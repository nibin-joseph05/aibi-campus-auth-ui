import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/logout_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Home",
          style: AppTextStyles.heading(size.width * 0.06, color: Colors.black),
        ),
        actions: const [
          LogoutButton(),
          SizedBox(width: 12),
        ],
      ),


      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome To Home",
                  style: AppTextStyles.heading(
                    size.width * 0.065,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SizedBox(
                  width: size.width * 0.8,
                  child: SvgPicture.asset(
                    "assets/images/home/home-welcome.svg",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Text(
                  "Currently the next part of Home Activity &\nFragmentation is under development.\nThe upcoming Part 2 is coming soon...",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body(
                    size.width * 0.04,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
