import 'package:demo_google_ads/persenstation/page/flutter_map.dart/controllers/map_controller.dart';
import 'package:get/get.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapViewController>(() => MapViewController());
  }
}
