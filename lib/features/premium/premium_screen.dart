import 'dart:async'; // For the Timer
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greeny_solution/consent_manager.dart';
import 'package:greeny_solution/features/Copilot/copiot_screen.dart';
import 'package:greeny_solution/features/deseaseDetection/camera_view.dart';
import 'package:greeny_solution/features/premium/payment_controller.dart';
import 'package:greeny_solution/features/premium/payment_screen.dart';
import 'package:shared/shared.dart';

class PremiumSubscriptionScreen extends GetView<PaymentController> {
  final Widget  nextWidget; // Declare the variable

  PremiumSubscriptionScreen({required this.nextWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(
      () {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (!controller.subscribed.value) {
          return Stack(
            children: [
              // Animated image switching
              AnimatedSwitcher(
                duration: Duration(seconds: 2),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: controller.showFirstImage.value
                    ? Image.asset(
                        'assets/Images/imagehydroponic1.jpg', // Replace with your first image
                        key: ValueKey(1),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Image.asset(
                        'assets/Images/imagehydroponic2.jpg', // Replace with your second image
                        key: ValueKey(2),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
              ),
              Container(
                height: context.Heightmedia(1),
                width: context.widthmedia(1),
                color: const Color.fromARGB(167, 1, 40, 24),
              ),
              Positioned(
                top: context.Heightmedia(0.03),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white),
                      iconSize: 25,
                      onPressed: () {
                        Navigator.pop(context); // Go back to retake the picture
                      },
                    ),
                    /* Text(
                      'Back',
                      style: TextStyle(fontSize: context.widthmedia(0.035),color: AppColors.white),
                    ),*/
                  ],
                ),
              ),
              // Subscription content

              Card(
                elevation: 20,
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(
                    left: context.widthmedia(0.07),
                    right: context.widthmedia(0.05),
                    top: context.Heightmedia(0.15),
                    bottom: context.Heightmedia(0.05)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 13.0, bottom: 2.0),
                  child: SizedBox(
                    height: context.Heightmedia(0.7),
                    width: context.widthmedia(0.85),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Premium crown icon with rotation
                        Transform.rotate(
                          angle: -0.2,
                          child: Icon(
                            FontAwesomeIcons.crown,
                            size: context.widthmedia(0.2),
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(height: context.Heightmedia(0.04)),

                        // Title
                        Text(
                          'Unlock Premium Features'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: context.widthmedia(0.05),
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: context.Heightmedia(0.04)),
                        Text(
                          '59 DNT',
                          style: GoogleFonts.poppins(
                            fontSize: context.widthmedia(0.12),
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: context.Heightmedia(0.03)),

                        // Premium Benefits List
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPremiumBenefit(context,
                                '✔️ Unlimited Access to desease detection'.tr),
                            SizedBox(height: context.Heightmedia(0.008)),
                            _buildPremiumBenefit(context,
                                '✔️ Unlimited Access to Copilot for support'.tr),
                            SizedBox(height: context.Heightmedia(0.008)),
                            _buildPremiumBenefit(context, '✔️ Expert Meetings'.tr),
                            SizedBox(height: context.Heightmedia(0.008)),
                            _buildPremiumBenefit(context, '✔️ No Ads'.tr),
                          ],
                        ),

                        SizedBox(height: context.Heightmedia(0.035)),
                        // Subscribe Now Button
                        ElevatedButton(
                          onPressed: () async {
                            final link = await controller.initpayment();
                            Get.off(() => PaymentScreen(link: link,nextWidget: nextWidget));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber, // Background color
                            padding: EdgeInsets.symmetric(
                                horizontal: context.widthmedia(0.08),
                                vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Subscribe Now'.tr,
                            style: TextStyle(
                                fontSize: context.widthmedia(0.03),
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: context.Heightmedia(0.015)),

                        // Watch Ad Button
                        TextButton(
                          onPressed: () async {
                            await controller.loadAd();
                            await controller.rewardedInterstitialAd?.show(
                                onUserEarnedReward: (AdWithoutView view,
                                    RewardItem rewardItem) {
                              // ignore: avoid_print
                              print('Reward amount: ${rewardItem.amount}');
                              controller.rewardedInterstitialAd?.dispose();
                              _showAdToUnlock(context);
                            });
                            // Simulate watching an ad
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.secondarydark,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15), // Text color
                          ),
                          child: Text(
                            'Watch an Ad to Unlock Once'.tr,
                            style: TextStyle(
                              fontSize: context.widthmedia(0.025),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
         // Get.to(() => nextWidget());
          return nextWidget;
        }
        ;
      },
    ));
  }

  // A method to create premium benefit list items
  Widget _buildPremiumBenefit(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: context.widthmedia(0.03),
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  // Simulate watching an ad to unlock the premium feature
  void _showAdToUnlock(BuildContext context) {
    // You can integrate an ad service here, such as Google AdMob or Unity Ads
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Ad Watched'.tr),
          content:  Text(
              'You have successfully watched an ad and unlocked the premium feature once!'.tr),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.to(() => nextWidget);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
