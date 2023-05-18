import 'package:demo_google_ads/persenstation/page/Interstitial_ads/controllers/interstitial_ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterstitialAdsView extends GetView<InterstitialAdsController> {
  const InterstitialAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InterstitialAdsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interstitial Ads'),
      ),
      body: Obx(
        () => (!controller.isInterstitialAdReady.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Builder(builder: (context) {
                  controller.showInterstitialAd();
                  return const Text('Interstitial Ads');
                }),
              ),
      ),
    );
  }
}
