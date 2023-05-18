import 'package:demo_google_ads/persenstation/page/banner_ads/bindings/banner_ads_binding.dart';
import 'package:demo_google_ads/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BannerAdsBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
    );
  }
}
