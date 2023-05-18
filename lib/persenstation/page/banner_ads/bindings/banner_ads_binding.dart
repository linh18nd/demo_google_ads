import 'package:demo_google_ads/persenstation/page/banner_ads/controller/banner_ads_controller.dart';
import 'package:get/get.dart';

class BannerAdsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannerAdsController>(() => BannerAdsController());
  }
}