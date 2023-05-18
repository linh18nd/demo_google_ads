import 'dart:developer';

import 'package:demo_google_ads/common/constaint.dart';
import 'package:demo_google_ads/persenstation/app_controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdsController extends GetxController with AppController {
  late InterstitialAd _interstitialAd;
  RxBool isInterstitialAdReady = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _createInterstitialAd();
  }

  @override
  void onReady() async {
    super.onReady();

    await showInterstitialAd();
  }

  @override
  void onClose() {
    _interstitialAd.dispose();
    super.onClose();
  }

  Future _createInterstitialAd() async {
    await InterstitialAd.load(
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          isInterstitialAdReady.value = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error');
          showAboutDialog(
              context: Get.context!, applicationName: error.message);
        },
      ),
      adUnitId: Constaints.interstitialId,
      request: const AdRequest(),
    );
  }

  Future showInterstitialAd() async {
    if (isInterstitialAdReady.value) {
      await _interstitialAd.show();
      return;
    }
  }
}
