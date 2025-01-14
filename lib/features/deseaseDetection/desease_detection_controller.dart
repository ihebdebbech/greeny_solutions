import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greeny_solution/consent_manager.dart';
import 'package:shared/domain/copilot/usecase/chat_with_copilort_usecase.dart';
import 'package:shared/domain/room/usecase/consult_rooms_usecase.dart';
import 'package:shared/domain/roomManagement/entity/room_entity.dart';
import 'package:image/image.dart' as img;

class DeseaseDetectionController extends GetxController {
  var _isMobileAdsInitializeCalled = false;
  var _isPrivacyOptionsRequired = false.obs;
  RewardedInterstitialAd? rewardedInterstitialAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5354046379'
      : 'ca-app-pub-3940256099942544/6978759866';
  final _consentManager = ConsentManager();
  var isLoading = false.obs;
  var rooms = <RoomEntity>[].obs; // Observable list of RoomEntity
  RxDouble _opacityThermometer = 0.0.obs;
  final ConsultRoomUsecase _consultRoomUsecase = Get.find<ConsultRoomUsecase>();
  late CameraController controllercam;
  Rx<File?> imageFile = Rx<File?>(
      null); // Make imageFile observable// Variable to store the captured image file
  var predictedResult = "".obs;
  var deseaseDescription = "".obs;
  final ChatWithCopilortUsecase _chatWithCopilortUsecase =
      new ChatWithCopilortUsecase(Get.find());

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await initializeCamera();
      print("Camera initialized");
      _consentManager.gatherConsent((consentGatheringError) {
        if (consentGatheringError != null) {
          // Consent not obtained in current session.
          debugPrint(
              "${consentGatheringError.errorCode}: ${consentGatheringError.message}");
        }

        // Attempt to initialize the Mobile Ads SDK.
        // _initializeMobileAdsSDK();
      });
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> fetchRooms() async {
    isLoading.value = true;
    try {
      final fetchedRooms = await _consultRoomUsecase.getRooms();
      rooms.assignAll(fetchedRooms); // Update the observable list
    } catch (error) {
      print(error);
      rooms.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getchatresponse(String question) async {
    try {
      final response = await _chatWithCopilortUsecase.getchatresponsedisease(question);

      deseaseDescription.value = response;
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  void loadAd() async {
    // Only load an ad if the Mobile Ads SDK has gathered consent aligned with
    // the app's configured messages.
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

  /// Redraw the app bar actions if a privacy options entry point is required.
  void _getIsPrivacyOptionsRequired() async {
    if (await _consentManager.isPrivacyOptionsRequired()) {
      _isPrivacyOptionsRequired.value = true;
    }
  }

  /// Initialize the Mobile Ads SDK if the SDK has gathered consent aligned with
  /// the app's configured messages.
  void _initializeMobileAdsSDK() async {
    if (_isMobileAdsInitializeCalled) {
      return;
    }

    if (await _consentManager.canRequestAds()) {
      _isMobileAdsInitializeCalled = true;

      // Initialize the Mobile Ads SDK.
      //MobileAds.instance.initialize();

      // Load an ad.
    }
  }

  @override
  void onClose() {
    controllercam.dispose();
    rewardedInterstitialAd?.dispose();
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (controllercam == null || !controllercam!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // App is inactive (e.g., user is switching apps)
      controllercam?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // App resumed, re-initialize the camera
      await initializeCamera();
    }
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    controllercam = CameraController(cameras[0], ResolutionPreset.high);
    controllercam.setFocusMode(FocusMode.auto);
    controllercam.lockCaptureOrientation();

    await controllercam.initialize();
  }
}
