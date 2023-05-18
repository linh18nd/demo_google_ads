import 'package:demo_google_ads/persenstation/page/Interstitial_ads/bindings/interstitial_ads_binding.dart';
import 'package:demo_google_ads/persenstation/page/Interstitial_ads/views/interstitial_ads_view.dart';
import 'package:demo_google_ads/persenstation/page/banner_ads/view/banner_ads_screen.dart';
import 'package:demo_google_ads/persenstation/page/flutter_map.dart/binding/map_binding.dart';
import 'package:demo_google_ads/persenstation/page/flutter_map.dart/views/map_view.dart';
import 'package:demo_google_ads/persenstation/page/rewarded_ads/binding/rewarded_ad_binding.dart';
import 'package:demo_google_ads/persenstation/page/rewarded_ads/views/rewarded_ad_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String bannerAds = '/bannerAds';
  static const String interstitialAds = '/interstitialAds';
  static const String nativeAds = '/nativeAds';
  static const String rewardedAds = '/rewardedAds';

  static String googleMap = '/googleMap';

  static String mapbox = '/mapbox';
}

class AppPages {
  static const initial = AppRoutes.bannerAds;
  static List<GetPage> pages = [
    GetPage(name: AppRoutes.bannerAds, page: () => const BannerAdsScreen()),
    GetPage(
      binding: InterstitialAdsBinding(),
      name: AppRoutes.interstitialAds,
      page: () => const InterstitialAdsView(),
    ),
    GetPage(
      name: AppRoutes.rewardedAds,
      page: () => const RewardedAdView(),
      binding: RewardedAdBinding(),
    ),
    GetPage(
        binding: MapBinding(),
        name: AppRoutes.googleMap,
        page: () => const MapView()),
  ];
}
