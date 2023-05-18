import 'package:demo_google_ads/common/enum.dart';
import 'package:get/get.dart';

mixin AppController {
  Rx<AppLoadingState> appLoadingState = AppLoadingState.start.obs;
}
