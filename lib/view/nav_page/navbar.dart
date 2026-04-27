import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maxpay/core/utils/asset_images.dart';
import 'package:maxpay/core/utils/colors.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  final List<Map<String, dynamic>> _baseIcons = const [
    {"image": AssetImages.home, "label": "Home"},
    {"image": AssetImages.report, "label": "Report"},
    {"image": AssetImages.request, "label": "Request"},
    {"image": AssetImages.qr, "label": "My QR"},
    {"image": AssetImages.settings, "label": "Settings"},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navbarProvider);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: .fixed,
      selectedItemColor: AppColors.blueColor,
      unselectedItemColor: Colors.grey,

      selectedLabelStyle: TextStyle(
        color: AppColors.blueColor,
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
        ref.read(navbarProvider.notifier).setIndex(value);
      },
      items: _baseIcons.map((e) {
        final bool isSelected = selectedIndex == _baseIcons.indexOf(e);
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            e["image"],
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.blueColor : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: e["label"],
        );
      }).toList(),

      //  <BottomNavigationBarItem>[
      //   BottomNavigationBarItem(
      //     icon: SvgPicture.asset(
      //       AssetImages.home,
      //       colorFilter: ColorFilter.mode(
      //         selectedIndex == 0 ? AppColors.clrPrimary : Colors.grey,
      //         BlendMode.srcIn,
      //       ),
      //     ),
      //     label: 'Home',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: SvgPicture.asset(
      //       AssetImages.home,
      //       colorFilter: ColorFilter.mode(
      //         selectedIndex == 1 ? AppColors.clrPrimary : Colors.grey,
      //         BlendMode.srcIn,
      //       ),
      //     ),
      //     label: 'Report',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: SvgPicture.asset(AssetImages.home),
      //     label: 'Request',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: SvgPicture.asset(AssetImages.home),
      //     label: 'Settings',
      //   ),
      // ],
    );

    // return SizedBox(
    //   height: 90,
    //   child: Stack(
    //     alignment: Alignment.bottomCenter,
    //     children: [
    //       /// Bottom Rounded Bar
    //       Container(
    //         margin: const EdgeInsets.all(16),
    //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //         height: 65,
    //         decoration: BoxDecoration(
    //           color: Theme.of(context).colorScheme.surface,
    //           borderRadius: BorderRadius.circular(20),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.black.withValues(alpha: 0.15),
    //               blurRadius: 10,
    //               offset: const Offset(0, 4),
    //             ),
    //           ],
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             _navItem(context, ref, 0, selectedIndex),
    //             _navItem(context, ref, 1, selectedIndex),
    //             const SizedBox(width: 40),
    //             _navItem(context, ref, 2, selectedIndex),
    //             _navItem(context, ref, 3, selectedIndex),
    //           ],
    //         ),
    //       ),

    //       /// Center Floating Button (QR)
    //       Positioned(
    //         bottom: 35,
    //         child: GestureDetector(
    //           onTap: () {

    //           },
    //           child: Container(
    //             width: 50,
    //             height: 50,
    //             decoration: BoxDecoration(
    //               color: AppColors.clrPrimary,
    //               shape: BoxShape.circle,
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: AppColors.clrPrimary.withValues(alpha: 0.4),
    //                   blurRadius: 12,
    //                 ),
    //               ],
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.all(12.r),
    //               child: Image.asset(AssetImages.qr, color: Colors.white),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
