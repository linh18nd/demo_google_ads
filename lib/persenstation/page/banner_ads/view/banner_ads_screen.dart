import 'package:demo_google_ads/persenstation/page/banner_ads/controller/banner_ads_controller.dart';
import 'package:demo_google_ads/persenstation/page/flutter_map.dart/views/widget/chat_bubble_painter.dart';
import 'package:demo_google_ads/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdsScreen extends GetView<BannerAdsController> {
  const BannerAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banner Ads'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50,
          child: AdWidget(
            ad: controller.myBanner,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Banner Ads'),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.interstitialAds);
              },
              child: const Text('interstitial ads'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.rewardedAds);
              },
              child: const Text('rewarded ads'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.googleMap);
              },
              child: const Text('flutter map'),
            ),
          ],
        ),
      ),
    );
  }
}
