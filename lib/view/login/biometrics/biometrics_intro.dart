import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class BiometricsIntroPage extends StatelessWidget {
  const BiometricsIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isUpdate = Get.arguments['is_update'] ?? false;

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
                SizedBox(height: 50.h),

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
              ],
            ),
          ),
        ),

        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonButton(
                  title: isUpdate ? "Update Fingerprint" : "Enable Fingerprint",
                  onTap: () {
                    Get.toNamed(AppRoutes.biometricsScanning);
                  },
                ),
                if (isUpdate) ...[
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Confirm Delete",
                        titleStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          color: colorScheme.onSurface,
                        ),
                        middleText:
                            "Are you sure you want to delete your fingerprint?",
                        middleTextStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: colorScheme.onSurface,
                        ),
                        textCancel: "No",
                        textConfirm: "Yes, Delete",
                        confirmTextColor: Colors.white,
                        cancelTextColor: Colors.grey,
                        buttonColor: Colors.red,
                        barrierDismissible: false,
                        onCancel: () {
                          Get.back();
                        },
                        onConfirm: () async {
                          Get.back(); // close dialog
                          final authController = Get.find<AuthController>();
                          await authController.fingerprint(
                            0,
                          ); // 0 corresponds to disable/delete
                          Get.back(); // exit intro screen
                        },
                      );
                    },
                    child: Text(
                      "Delete Fingerprint",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }
}
