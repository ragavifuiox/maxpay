import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NavbarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxBool isMenuOpen = false.obs;

  void openMenu() {
    isMenuOpen.value = true;
  }

  void closeMenu() {
    isMenuOpen.value = false;
  }

  void setIndex(int index) {
    selectedIndex.value = index;
  }
}