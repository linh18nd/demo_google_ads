import 'package:get/get.dart';

class MainController extends GetxController {
  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int index) => _selectedIndex.value = index;

  @override
  void onInit() {
    super.onInit();
    _selectedIndex.value = 0;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
