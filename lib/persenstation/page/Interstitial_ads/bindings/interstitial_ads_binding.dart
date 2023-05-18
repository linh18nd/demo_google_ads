import 'package:demo_google_ads/persenstation/page/Interstitial_ads/controllers/interstitial_ads_controller.dart';
import 'package:get/get.dart';

class InterstitialAdsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InterstitialAdsController>(
      () => InterstitialAdsController(),
    );
  }
}
