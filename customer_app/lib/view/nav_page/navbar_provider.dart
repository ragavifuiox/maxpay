import 'package:get/get.dart';

class NavbarController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  RxBool isMenuOpen = false.obs;
  void openMenu() {
    isMenuOpen.value = true;
  }

  void closeMenu() {
    isMenuOpen.value = false;
  }

  void setIndex(int index) {
    _selectedIndex.value = index;
  }
}
