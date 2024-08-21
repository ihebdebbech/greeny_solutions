import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeny_solution/features/home/my_home_page.dart';
import 'package:greeny_solution/features/login/login_page.dart';
import 'package:shared/ui/theme/app_color.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Get.off(LoginPage());
    });
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          SizedBox(height: context.Heightmedia(0.05)),
          Center(
            child: Image.asset('assets/Images/greenywhite.png',
                width: MediaQuery.of(context).size.width * 0.55,
                fit: BoxFit.contain),
          ),
        ],
      ),
      splashIconSize: 150,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      backgroundColor: AppColors.primary,
      nextScreen: LoginPage(),
    );
  }
}
