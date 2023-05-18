import 'package:demo_google_ads/common/constaint.dart';
import 'package:demo_google_ads/persenstation/app_controller/app_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdsController extends GetxController with AppController {
  BannerAd myBanner = BannerAd(
    adUnitId: Constaints.bannerId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  @override
  void onInit() {
    super.onInit();
    loadAd();
  }

  void loadAd() {
    myBanner.load();
  }
}
