import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greeny_solution/app_bar_item.dart';
import 'package:greeny_solution/consent_manager.dart';
import 'package:greeny_solution/deseasedetectionscreen.dart';
import 'package:greeny_solution/features/deseaseDetection/desease_detection_screen.dart';
import 'package:greeny_solution/features/translations/translation_service.dart';
import 'package:greeny_solution/firebase_options.dart';
import 'package:greeny_solution/firebasemessagingservice.dart';
import 'package:greeny_solution/local_notification_service.dart';
import 'package:greeny_solution/spash_creen.dart';

import 'package:greeny_solution/theme/default_theme.dart';
import 'package:greeny_solution/di.dart';
import 'package:permission_handler/permission_handler.dart';

//late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firebaseMessagingService = FirebaseMessagingService();
  await firebaseMessagingService.grantAppPermission();
  await FirebaseMessagingService.init();
  // this is where the notification service was initialized
  await LocalNotificationService.initialize();
  // _cameras = await availableCameras();
  await requestPermissions();

  runApp(const MyApp());
}

Future<void> requestPermissions() async {
  if (!kIsWeb) {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> initFM() async {
    // Call the static method directly
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       translations: TranslationService(),
      locale: Locale('en', 'US'), 
      fallbackLocale: Locale('en', 'US'),
      
      debugShowCheckedModeBanner: false,
      title: 'Greeny Solutions',
      theme: DefaultTheme.themeData,
      home: SplashScreen(),
      initialBinding: DI(),
    );
  }
}

/// An example app that loads a banner ad.
class BannerExample extends StatefulWidget {
  const BannerExample({super.key});

  @override
  BannerExampleState createState() => BannerExampleState();
}

class BannerExampleState extends State<BannerExample> {
  final _consentManager = ConsentManager();

  final CountdownTimer _countdownTimer = CountdownTimer();
  var _showWatchVideoButton = false;
  var _gamePaused = false;
  var _gameOver = false;
  var _isMobileAdsInitializeCalled = false;
  var _isPrivacyOptionsRequired = false;
  var _coins = 0;
  RewardedAd? _rewardedAd;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  @override
  void initState() {
    super.initState();

    _consentManager.gatherConsent((consentGatheringError) {
      if (consentGatheringError != null) {
        // Consent not obtained in current session.
        debugPrint(
            "${consentGatheringError.errorCode}: ${consentGatheringError.message}");
      }

      // Kick off the first play of the "game".
      _startNewGame();

      // Check if a privacy options entry point is required.
      _getIsPrivacyOptionsRequired();

      // Attempt to initialize the Mobile Ads SDK.
      _initializeMobileAdsSDK();
    });

    // This sample attempts to load ads using consent obtained in the previous session.
    _initializeMobileAdsSDK();

    // Show the "Watch video" button when the timer reaches zero.
    _countdownTimer.addListener(() => setState(() {
          if (_countdownTimer.isComplete) {
            _gameOver = true;
            _showWatchVideoButton = true;
            _coins += 1;
          } else {
            _showWatchVideoButton = false;
          }
        }));
  }

  void _startNewGame() {
    _countdownTimer.start();
    _gameOver = false;
    _gamePaused = false;
  }

  void _pauseGame() {
    if (_gameOver || _gamePaused) {
      return;
    }
    _countdownTimer.pause();
    _gamePaused = true;
  }

  void _resumeGame() {
    if (_gameOver || !_gamePaused) {
      return;
    }
    _countdownTimer.resume();
    _gamePaused = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rewarded Example',
      home: Scaffold(
          appBar: AppBar(
              title: const Text('Rewarded Example'), actions: _appBarActions()),
          body: Stack(
            children: [
              const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'The Impossible Game',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_countdownTimer.isComplete
                          ? 'Game over!'
                          : '${_countdownTimer.timeLeft} seconds left!'),
                      Visibility(
                        visible: _countdownTimer.isComplete,
                        child: TextButton(
                          onPressed: () {
                            _startNewGame();
                            _loadAd();
                          },
                          child: const Text('Play Again'),
                        ),
                      ),
                      Visibility(
                          visible: _showWatchVideoButton,
                          child: TextButton(
                            onPressed: () {
                              setState(() => _showWatchVideoButton = false);

                              _rewardedAd?.show(onUserEarnedReward:
                                  (AdWithoutView ad, RewardItem rewardItem) {
                                // ignore: avoid_print
                                print('Reward amount: ${rewardItem.amount}');
                                setState(
                                    () => _coins += rewardItem.amount.toInt());
                              });
                            },
                            child: const Text(
                                'Watch video for additional 10 coins'),
                          ))
                    ],
                  )),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text('Coins: $_coins')),
              ),
            ],
          )),
    );
  }

  List<Widget> _appBarActions() {
    var array = [AppBarItem(AppBarItem.adInpsectorText, 0)];

    if (_isPrivacyOptionsRequired) {
      array.add(AppBarItem(AppBarItem.privacySettingsText, 1));
    }

    return <Widget>[
      PopupMenuButton<AppBarItem>(
          itemBuilder: (context) => array
              .map((item) => PopupMenuItem<AppBarItem>(
                    value: item,
                    child: Text(
                      item.label,
                    ),
                  ))
              .toList(),
          onSelected: (item) {
            _pauseGame();
            switch (item.value) {
              case 0:
                MobileAds.instance.openAdInspector((error) {
                  // Error will be non-null if ad inspector closed due to an error.
                  _resumeGame();
                });
              case 1:
                _consentManager.showPrivacyOptionsForm((formError) {
                  if (formError != null) {
                    debugPrint("${formError.errorCode}: ${formError.message}");
                  }
                  _resumeGame();
                });
            }
          })
    ];
  }

  /// Loads a rewarded ad.
  void _loadAd() async {
    // Only load an ad if the Mobile Ads SDK has gathered consent aligned with
    // the app's configured messages.
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    RewardedAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
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
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
          print('RewardedAd failed to load: $error');
        }));
  }

  /// Redraw the app bar actions if a privacy options entry point is required.
  void _getIsPrivacyOptionsRequired() async {
    if (await _consentManager.isPrivacyOptionsRequired()) {
      setState(() {
        _isPrivacyOptionsRequired = true;
      });
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
      MobileAds.instance.initialize();

      // Load an ad.
      _loadAd();
    }
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    _countdownTimer.dispose();
    super.dispose();
  }
}

enum CountdownState {
  notStarted,
  active,
  paused,
  ended,
}

/// A simple class that keeps track of a decrementing timer.
class CountdownTimer extends ChangeNotifier {
  final _countdownTime = 5;
  late var timeLeft = _countdownTime;
  var _countdownState = CountdownState.notStarted;
  Timer? _timer;

  bool get isComplete => _countdownState == CountdownState.ended;

  void start() {
    timeLeft = _countdownTime;
    _startTimer();
    _countdownState = CountdownState.active;

    notifyListeners();
  }

  void resume() {
    if (_countdownState != CountdownState.paused) {
      return;
    }
    _startTimer();
    _countdownState = CountdownState.active;
  }

  void pause() {
    if (_countdownState != CountdownState.active) {
      return;
    }
    _timer?.cancel();
    _countdownState = CountdownState.paused;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft--;

      if (timeLeft == 0) {
        _countdownState = CountdownState.ended;
        timer.cancel();
      }

      notifyListeners();
    });
  }
}
