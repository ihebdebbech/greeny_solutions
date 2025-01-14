import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeny_solution/Skeleton_app.dart';
import 'package:greeny_solution/features/home/my_home_page.dart';
import 'package:greeny_solution/features/login/login_page.dart';
import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/ui/theme/app_color.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  Future<bool> _checkSessionStatus() async {
    print("in spashscreen");
    final repo = Get.find<AuthenticationRepository>();
    final sessionStatus = await repo.getToken();
    return sessionStatus;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkSessionStatus(),
      builder: (context, snapshot) {
       if (snapshot.hasError) {
          // Handle any error that occurred during the future
          return Center(child: Text("An error occurred"));
        } else {
          // Navigate to the appropriate screen based on the session status
         return AnimatedSplashScreen(
            duration: 2500,
            animationDuration: Duration(milliseconds: 2000),
            splash: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.Heightmedia(0.05)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                
                    child: Image.asset('assets/Images/greenycolor.png',
                     fit: BoxFit.cover,   
                        ),
                  
                ),
              ],
            ),
            splashIconSize: 250,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.leftToRight,
            backgroundColor: AppColors.white,
            nextScreen: snapshot.data == true ? SkeletonApp() : LoginPage(), // Placeholder
          ); 
        }
      },
    );
  }
}
