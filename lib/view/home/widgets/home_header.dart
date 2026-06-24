import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/core/constants/extension.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/image_loader.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/date_uttils.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final profileController = Get.put(ProfileController(getProfileUseCase: sl(), profileUpdateUseCase: sl()));
    final isTablet = Responsive.isTablet(context);
    return Obx(() {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final isDark = themeController.isDarkMode;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                /// LEFT SIDE
                Expanded(
                  child: GestureDetector(
                    onTap: () {
  Get.toNamed(AppRoutes.profile);
},
                    child: Row(
                      children: [
                       Obx(() {
    final imageUrl =
    (profileController.profileData.value?.data?.profileimg ?? "")
        .addToBase();

print("🌐 Full URL: $imageUrl");
  return CircleAvatar(
    radius: 20,
    backgroundColor: Colors.red.withValues(alpha: 0.2),
    child: ClipOval(
      child: imageUrl.isNotEmpty
    ? Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print("❌ Image Error: $error");
          return const Icon(Icons.person);
        },
      )
    : const Icon(Icons.person),
    ),
  );
}),

                        SizedBox(width: 10.w),

                        /// NAME & GREETING
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateTimeFormater.getGreeting(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: colorScheme.onSurface,
                                ),
                              ),

                            Obx(() {
  return Text(
    profileController.profileData.value?.data?.name?.capitalize ?? "",
                                    
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface.withValues(
                                      alpha: 0.7,
                                    ),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 4.w),

                /// RIGHT SIDE
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// SEARCH
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                      icon: Icon(
                        Ionicons.search_outline,
                        size: isTablet ? 32.sp : 25.sp,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(width: 12.w),

                    /// NOTIFICATION
                    GestureDetector(
                      onTap: () {},
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Ionicons.notifications_outline,
                            size: isTablet ? 32.sp : 25.sp,
                            color: colorScheme.onSurface,
                          ),

                          Positioned(
                            right: -4,
                            top: -4,
                            child: FadeIn(
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    width: 1.5,
                                  ),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 16.w,
                                  minHeight: 16.h,
                                ),
                                child: Center(
                                  child: Text(
                                    "99",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 7.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12.w),

                    /// THEME SWITCH
                    // GestureDetector(
                    //   onTap: () {
                    //     themeController.toggleTheme();
                    //   },
                    //   child: Container(
                    //     width: isTablet ? 76.w : 68.w,
                    //     height: isTablet ? 32.h : 34.h,
                    //     decoration: BoxDecoration(
                    //       color: isDark
                    //           ? Colors.white
                    //           : const Color(0xFF1E1E2D),
                    //       borderRadius: BorderRadius.circular(24.r),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.black.withValues(alpha: 0.10),
                    //           blurRadius: 4,
                    //           offset: const Offset(0, 2),
                    //         ),
                    //       ],
                    //     ),
                    //     child: Stack(
                    //       children: [
                    //         RepaintBoundary(
                    //           child: AnimatedAlign(
                    //             duration: const Duration(milliseconds: 300),
                    //             curve: Curves.easeInOut,
                    //             alignment: isDark
                    //                 ? Alignment.centerLeft
                    //                 : Alignment.centerRight,
                    //             child: Padding(
                    //               padding: EdgeInsets.all(3.r),
                    //               child: Container(
                    //                 width: isTablet ? 34.w : 28.w,
                    //                 height: isTablet ? 34.w : 28.w,
                    //                 decoration: BoxDecoration(
                    //                   color: isDark
                    //                       ? const Color(0xFF1E1E2D)
                    //                       : Colors.white,
                    //                   shape: BoxShape.circle,
                    //                   boxShadow: [
                    //                     BoxShadow(
                    //                       color: Colors.black.withValues(
                    //                         alpha: 0.15,
                    //                       ),
                    //                       blurRadius: 5,
                    //                       offset: const Offset(0, 2),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 child: Icon(
                    //                   isDark
                    //                       ? Icons.nightlight_round
                    //                       : Icons.wb_sunny_rounded,
                    //                   size: 14.sp,
                    //                   color: isDark
                    //                       ? Colors.white
                    //                       : Colors.orange,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),

                    //         Align(
                    //           alignment: isDark
                    //               ? Alignment.centerRight
                    //               : Alignment.centerLeft,
                    //           child: Padding(
                    //             padding: EdgeInsets.symmetric(horizontal: 8.w),
                    //             child: Icon(
                    //               isDark
                    //                   ? Icons.wb_sunny_rounded
                    //                   : Icons.nightlight_round,
                    //               size: 13.sp,
                    //               color: isDark
                    //                   ? Colors.black.withValues(alpha: 0.4)
                    //                   : Colors.white.withValues(alpha: 0.4),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),



                    /// THEME SWITCH
GestureDetector(
  onTap: () {
    themeController.toggleTheme();
  },
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
    width: isTablet ? 76.w : 68.w,
    height: isTablet ? 32.h : 34.h,
    decoration: BoxDecoration(
      color: isDark
          ? Colors.white
          : const Color(0xFF1E1E2D),
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.10),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Stack(
      children: [
        AnimatedAlign(
          duration: const Duration(milliseconds: 450),
          curve: Curves.fastOutSlowIn,
          alignment: isDark
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(3.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: isTablet ? 34.w : 28.w,
              height: isTablet ? 34.w : 28.w,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E1E2D)
                    : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Icon(
                    isDark
                        ? Icons.nightlight_round
                        : Icons.wb_sunny_rounded,
                    key: ValueKey(isDark),
                    size: 14.sp,
                    color: isDark
                        ? Colors.white
                        : Colors.orange,
                  ),
                ),
              ),
            ),
          ),
        ),

        AnimatedAlign(
          duration: const Duration(milliseconds: 400),
          alignment: isDark
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Icon(
              isDark
                  ? Icons.wb_sunny_rounded
                  : Icons.nightlight_round,
              size: 13.sp,
              color: isDark
                  ? Colors.black.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ),
      ],
    ),
  ),
),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
