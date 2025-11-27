import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/logout_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    final isSmallScreen = size.height < 700;
    final isTinyScreen = size.height < 600;
    final isLandscape = size.width > size.height;
    final isTablet = size.shortestSide >= 600;


    final titleSize = isTablet
        ? size.width * 0.04
        : (isLandscape ? size.width * 0.045 : size.width * 0.06);

    final welcomeSize = isTablet
        ? size.width * 0.045
        : (isLandscape
        ? size.width * 0.04
        : (isTinyScreen ? size.width * 0.055 : size.width * 0.065));

    final bodySize = isTablet
        ? size.width * 0.03
        : (isLandscape
        ? size.width * 0.028
        : (isTinyScreen ? size.width * 0.035 : size.width * 0.04));


    final svgWidth = isLandscape
        ? size.width * 0.4
        : (isTablet ? size.width * 0.5 : size.width * 0.8);

    final svgMaxHeight = isLandscape
        ? size.height * 0.4
        : (isTinyScreen ? size.height * 0.25 : size.height * 0.35);


    final topSpacing = isLandscape
        ? size.height * 0.02
        : (isTinyScreen ? size.height * 0.02 : size.height * 0.03);

    final bottomSpacing = isLandscape
        ? size.height * 0.02
        : (isTinyScreen ? size.height * 0.025 : size.height * 0.04);

    final horizontalPadding = isLandscape
        ? size.width * 0.15
        : (isTablet ? size.width * 0.12 : size.width * 0.07);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: isLandscape ? 56 : null,
        title: Text(
          "Home",
          style: AppTextStyles.heading(titleSize, color: Colors.black),
        ),
        actions: [
          const LogoutButton(),
          SizedBox(width: isLandscape ? 8 : 12),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: isLandscape
                        ? _buildLandscapeLayout(
                      size,
                      welcomeSize,
                      bodySize,
                      svgWidth,
                      svgMaxHeight,
                      topSpacing,
                      bottomSpacing,
                    )
                        : _buildPortraitLayout(
                      size,
                      welcomeSize,
                      bodySize,
                      svgWidth,
                      svgMaxHeight,
                      topSpacing,
                      bottomSpacing,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  Widget _buildPortraitLayout(
      Size size,
      double welcomeSize,
      double bodySize,
      double svgWidth,
      double svgMaxHeight,
      double topSpacing,
      double bottomSpacing,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome To Home",
          textAlign: TextAlign.center,
          style: AppTextStyles.heading(
            welcomeSize,
            color: Colors.black,
          ),
        ),
        SizedBox(height: topSpacing),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: svgWidth,
            maxHeight: svgMaxHeight,
          ),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: SvgPicture.asset(
              "assets/images/home/home-welcome.svg",
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: bottomSpacing),
        Text(
          "Currently the next part of Home Activity &\nFragmentation is under development.\nThe upcoming Part 2 is coming soon...",
          textAlign: TextAlign.center,
          style: AppTextStyles.body(
            bodySize,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }


  Widget _buildLandscapeLayout(
      Size size,
      double welcomeSize,
      double bodySize,
      double svgWidth,
      double svgMaxHeight,
      double topSpacing,
      double bottomSpacing,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Flexible(
          flex: 5,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: svgWidth,
              maxHeight: svgMaxHeight,
            ),
            child: AspectRatio(
              aspectRatio: 1.2,
              child: SvgPicture.asset(
                "assets/images/home/home-welcome.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),

        Flexible(
          flex: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome To Home",
                style: AppTextStyles.heading(
                  welcomeSize,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "Currently the next part of Home Activity & Fragmentation is under development.\n\nThe upcoming Part 2 is coming soon...",
                style: AppTextStyles.body(
                  bodySize,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}