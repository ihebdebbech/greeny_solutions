import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greeny_solution/consent_manager.dart';
import 'package:greeny_solution/features/Copilot/copiot_screen.dart';
import 'package:greeny_solution/features/Profile/profile_screen.dart';
import 'package:greeny_solution/features/deseaseDetection/camera_view.dart';
import 'package:greeny_solution/features/home/my_home_page.dart';
import 'package:greeny_solution/features/premium/premium_screen.dart';
import 'package:greeny_solution/icons/deseasedetectionicon1.dart';
import 'package:greeny_solution/main.dart';
import 'package:shared/ui/theme/app_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Import your navigation bar widget

class SkeletonApp extends StatefulWidget {
  @override
  _SkeletonAppState createState() => _SkeletonAppState();
}

class _SkeletonAppState extends State<SkeletonApp> {
  int previousindex = 0;
  int _selectedIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
 
  Future<void> _onItemTapped(int index) async {
    if (index == 1) {
      // Navigate to CameraView using Get.to()
      index = previousindex;
      setState(() {
        _selectedIndex = index;
      });
      Get.to(() => PremiumSubscriptionScreen(nextWidget: CameraView()));
     
    } else if (index == 2) {
      index = previousindex;

       Get.to(() => PremiumSubscriptionScreen(nextWidget: CopiotScreen()));
    } else {
      setState(() {
        _selectedIndex = index;
        previousindex = index;
      });
      
    }
    // Handle navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex), // Update body based on selected index
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _selectedIndex,
        items: <Widget>[
          const Icon(
            Icons.home_rounded,
            size: 30,
            color: AppColors.primary,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Main icon
              const Icon(
                MyFlutterApp.deseaseicon2,
                size: 30,
                color: AppColors.primary,
              ),
              // Positioned premium badge in the corner
              Positioned(
                right: -3, // Adjust position as needed
                top: -14,
                child: Transform.rotate(
                  angle:
                      0.5, // Rotation angle in radians (negative values rotate counterclockwise)
                  child: Icon(
                    FontAwesomeIcons.crown, // Premium badge icon
                    size: 18, // Adjust size as needed
                    color: Colors.amber, // Icon color
                  ),
                ),
              ),
            ],
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Main icon
              SvgPicture.asset(
                'assets/Images/chatbot.svg',
                width: 25,
                height: 25,
                color: AppColors.primary,
              ),
              // Positioned premium badge in the corner
              Positioned(
                right: -8, // Adjust position as needed
                top: -14,
                child: Transform.rotate(
                  angle:
                      0.5, // Rotation angle in radians (negative values rotate counterclockwise)
                  child: Icon(
                    FontAwesomeIcons.crown, // Premium badge icon
                    size: 18, // Adjust size as needed
                    color: Colors.amber, // Icon color
                  ),
                ),
              ),
            ],
          ),
          const Icon(
            FontAwesomeIcons.userGear,
            size: 25,
            color: AppColors.primary,
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          _onItemTapped(index);
        },
        letIndexChange: (index) => true,
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return CameraView();
      case 2:
        return CopiotScreen();
      case 3:
        return ProfileScreen(
          username: 'iheb',
        );
      // return BannerExample();
      default:
        return HomePage();
    }
  }


}
