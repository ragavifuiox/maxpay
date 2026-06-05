import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class BiometricsIntroPage extends StatelessWidget {
  const BiometricsIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final isDark = themeController.isDarkMode;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: isDark ? Colors.white : Colors.black,
              size: 20.sp,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),

              Center(
                child: Icon(
                  Icons.fingerprint,
                  size: 120.r,
                  color: AppColors.clrPrimary.withValues(alpha: 0.6),
                ),
              ),

              SizedBox(height: 40.h),

              Text(
                'Protect your account\nwith biometrics',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 25.sp,
                  color: colorScheme.onSurface,
                  height: 1.2,
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                'Add an extra layer of security to your wise app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: AppColors.darktextclr,
                ),
              ),

              const Spacer(),

              /// Common Button
              Center(
                child: CommonButton(
                  title: 'Set Fingerprint',
                  onTap: () {
                    Get.toNamed(AppRoutes.biometricsScanning);
                  },
                ),
              ),

              

              SafeArea(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.pinCodeCreation);
                  },
                  child: Container(
                    width: 222,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark
                            ? AppColors.clrPrimary
                            : AppColors.clrSecondary.withValues(alpha: 0.5),
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      'Set Pin',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: isDark
                            ? AppColors.clrPrimary
                            : AppColors.clrSecondary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      );
    });
  }
}