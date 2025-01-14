import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greeny_solution/consent_manager.dart';
import 'package:shared/domain/payment/usecase/check_subscription_usecase.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var subscribed = false.obs;
  RewardedInterstitialAd? rewardedInterstitialAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5354046379'
      : 'ca-app-pub-3940256099942544/6978759866';
  final _consentManager = ConsentManager();
  var showFirstImage = true.obs;
  Timer? timer;
  final CheckSubscriptionUsecase _checkSubscriptionUsecase =
      new CheckSubscriptionUsecase(Get.find());
  @override
  Future<void> onInit() async {
    super.onInit();
    await loadAd();
    await getSubcriptionStatus();
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      showFirstImage.value = !showFirstImage.value;
    });
  }

  Future<bool> getSubcriptionStatus() async {
    isLoading.value = true;
    try {
      final status = await _checkSubscriptionUsecase.getSubcriptionStatus();
      isLoading.value = false;
      print("premium");
      print(status);
      subscribed.value = status;
      return subscribed.value;
    } catch (error) {
      isLoading.value = false;
      return false;
    }
  }

  Future<String> initpayment() async {
    // isLoading.value = true;
    try {
      final link = await _checkSubscriptionUsecase.initpayment();
      //isLoading.value = false;

      return link;
    } catch (error) {
      isLoading.value = false;
      return "https://google.com";
    }
  }

  Future<void> loadAd() async {
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    RewardedInterstitialAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback:
            RewardedInterstitialAdLoadCallback(onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});

          // Keep a reference to the ad so you can show it later.
          rewardedInterstitialAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
          print('RewardedInterstitialAd failed to load: $error');
        }));
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks
    timer?.cancel();
   
  }
}
