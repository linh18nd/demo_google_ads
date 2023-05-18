import 'package:demo_google_ads/persenstation/page/rewarded_ads/controller/rewarded_ad_controller.dart';
import 'package:get/get.dart';

class RewardedAdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RewardedAdController>(() => RewardedAdController());
  }
}
