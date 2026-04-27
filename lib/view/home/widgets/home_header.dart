import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:maxpay/core/image_loader.dart';
import 'package:maxpay/core/utils/colors.dart';
import 'package:maxpay/core/utils/date_uttils.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/utils/theme.dart';

class HomeHeaderSection extends ConsumerWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    final isTablet = Responsive.isTablet(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.red.withValues(alpha: 0.2),
                      child: NetworkImageWithLoader(
                        'https://i.pravatar.cc/150?u=martin',
                        radius: 20,
                        errorWidget: Text(
                          'M',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.clrPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateTimeFormater.getGreeting(),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              'Aswanth',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Ionicons.search_outline,
                      size: isTablet ? 32.sp : 28.sp,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.notifications_outline,
                            size: isTablet ? 32.sp : 28.sp,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: FadeIn(
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.surface,
                                  width: 2,
                                ),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18.w,
                                minHeight: 18.h,
                              ),
                              child: Center(
                                child: Text(
                                  "99",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
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
                  GestureDetector(
                    onTap: () {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                    child: Container(
                      width: isTablet ? 86.w : 76.w,
                      height: isTablet ? 42.h : 38.h,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E1E2D)
                            : const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutBack,
                            alignment: isDark
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(4.r),
                              child: Container(
                                width: isTablet ? 34.w : 30.w,
                                height: isTablet ? 34.w : 30.w,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF0F0F1A)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  isDark
                                      ? Icons.nightlight_round
                                      : Icons.wb_sunny_rounded,
                                  size: 16.sp,
                                  color: isDark
                                      ? Colors.white
                                      : Colors.orangeAccent,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: isDark
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Icon(
                                isDark
                                    ? Icons.wb_sunny_rounded
                                    : Icons.nightlight_round,
                                size: 14.sp,
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.2,
                                ),
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
  }
}
