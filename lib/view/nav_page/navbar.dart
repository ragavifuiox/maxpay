import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

class CustomBottomNavBar extends GetView<NavbarController> {
  const CustomBottomNavBar({super.key});

  final List<Map<String, dynamic>> _baseIcons = const [
    {"image": AssetImages.home, "label": "Home"},
    {"image": AssetImages.report, "label": "Report"},
    {"image": AssetImages.request, "label": "Request"},
    {"image": AssetImages.support, "label": "Support"},
    {"image": AssetImages.settings, "label": "Settings"},
  ];

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final selectedIndex = controller.selectedIndex.value;
      final isMenuOpen = controller.isMenuOpen.value;
      final isDark = themeController.isDarkMode;

      Color activeColor = (selectedIndex == 0 && isMenuOpen)
          ? Colors.orange
          : (isDark ? AppColors.clrPrimary : AppColors.blueColor);

      return BottomNavigationBar(
        currentIndex: selectedIndex,
        elevation: 12,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: activeColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          color: activeColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        onTap: (value) {
          print("Clicked => $value");

          controller.closeMenu();
          controller.setIndex(value);
        },
        items: _baseIcons.map((e) {
          final bool isSelected = selectedIndex == _baseIcons.indexOf(e);
          final bool isHomeIcon = e["label"] == "Home";
          final bool isMenuOpen = controller.isMenuOpen.value;

          Color itemColor;
          if (isHomeIcon && isMenuOpen) {
            itemColor = Colors.orange;
          } else if (isSelected) {
            itemColor = isDark ? AppColors.clrPrimary : AppColors.blueColor;
          } else {
            itemColor = Colors.grey;
          }

          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              e["image"],
              colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
            ),
            label: e["label"],
          );
        }).toList(),
      );
    });
  }
}
