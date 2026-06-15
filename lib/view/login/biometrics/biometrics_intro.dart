import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class BiometricsIntroPage extends StatelessWidget {
  const BiometricsIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final controller = Get.find<AuthController>();

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
        body: SafeArea(
          child: Padding(
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
                  'Add an extra layer of security to your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: AppColors.darktextclr,
                  ),
                ),

                const Spacer(),

                /// Enable Fingerprint Button
                Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  spacing: 20.h,
                  children: [
                    CommonButton(
                      title: "Enable Fingerprint",
                      onTap: () {
                        Get.toNamed(AppRoutes.biometricsScanning);
                      },
                    ),

                    GestureDetector(
                      onTap: () async {
                        await controller.fingerprint(0);

                        Get.offAllNamed(AppRoutes.successScreen);
                      },
                      child: Text(
                        "Skip For Now",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.clrPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
