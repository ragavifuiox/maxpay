import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/utils/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final authController = Get.find<AuthController>();
    final isTablet = Responsive.isTablet(context);

    return Obx(() {
      final isDark = themeController.isDarkMode;
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      return Container(
        decoration: BoxDecoration(
          image: isDark
              ? null
              : DecorationImage(
                  image: AssetImage(AssetImages.bgOverlay),
                  fit: BoxFit.cover,
                ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: isTablet ? 24.sp : 20.sp,
                color: colorScheme.onSurface,
              ),
            ),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 46.h),
              child: Column(
                children: [
                  _buildMenuTile(
                    context,
                    'Profile',
                    () {
                      Get.toNamed(AppRoutes.profile);
                    },
                    SvgPicture.asset(AssetImages.profile, width: 24.w),
                  ),
                  _buildMenuTile(
                    context,
                    'Staff List',
                    () {
                      Get.toNamed(AppRoutes.stafflist);
                    },
                    SvgPicture.asset(AssetImages.stafflist, width: 24.w),
                  ),
                  _buildMenuTile(context, 'Grade', () {
                    Get.toNamed(AppRoutes.grade);
                  }, SvgPicture.asset(AssetImages.grade, width: 24.w)),
                  _buildMenuTile(context, 'KYC', () {
                    Get.toNamed(AppRoutes.kyc);
                  }, SvgPicture.asset(AssetImages.kyc, width: 24.w)),
                  _buildMenuTile(
                    context,
                    'Update Pin',
                    () {
                      Get.toNamed(AppRoutes.veirfypin, arguments: true);
                    },
                    SvgPicture.asset(AssetImages.updatePin, width: 24.w),
                  ),
                  _buildMenuTile(
                    context,
                    authController.isFingerPrint.value == 1
                        ? 'Update Fingerprint'
                        : 'Add Fingerprint',
                    () {
                      Get.toNamed(AppRoutes.biometricsIntro);
                    },
                    Icon(
                      Icons.fingerprint,
                      size: 24.w,
                      color: AppColors.clrPrimary,
                    ),
                  ),

                  _buildMenuTile(
                    context,
                    'Cashback',
                    () {
                      Get.toNamed(AppRoutes.cashback);
                    },
                    SvgPicture.asset(AssetImages.cashback, width: 24.w),
                  ),

                  _buildMenuTile(
                    context,
                    'Privacy Policy',
                    () {
                      Get.find<ProfileController>().fetchPrivacyPolicyLink();
                    },
                    SvgPicture.asset(AssetImages.privacyPolicy, width: 24.w),
                  ),

                  _buildMenuTile(
                    context,
                    'Rating Review',
                    () {
                      // Get.toNamed(AppRoutes.weblogin);
                      
                    },
                    SvgPicture.asset(AssetImages.review, width: 24.w),
                  ),

                  _buildMenuTile(
                    context,
                    'Login History',
                    () {
                      Get.toNamed(AppRoutes.loginhistory);
                    },
                    SvgPicture.asset(AssetImages.history, width: 24.w),
                  ),
                  // _buildMenuTile(
                  //   context,
                  //   'Web Signup',
                  //   () {
                  //     Get.toNamed(AppRoutes.weblogin);
                  //   },
                  //   SvgPicture.asset(AssetImages.webSignup, width: 24.w),
                  // ),
                  _buildMenuTile(
                    context,
                    'Web Login',
                    () {
                      Get.toNamed(AppRoutes.webloginqr);
                    },
                    SvgPicture.asset(AssetImages.webLogin, width: 24.w),

                    trailingWidget: FittedBox(
                      fit: BoxFit.scaleDown,

                      child: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4.r),
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text(
                                  'Link',

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                SizedBox(width: 2.w),

                                Icon(
                                  Icons.reply_rounded,
                                  color: Colors.white,
                                  size: 10.sp,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 6.w),

                          Image.asset(
                            AssetImages.qrcode,
                            width: 24.w,
                            height: 24.w,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildMenuTile(
                    context,
                    'Support',
                    () {
                      Get.toNamed(AppRoutes.support);
                    },
                    SvgPicture.asset(AssetImages.support, width: 24.w),
                  ),

                  /// 🔹 LOGOUT BUTTONS
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildLogoutButton(
                            context,
                            'Logout',
                            Icons.logout_rounded,
                            () {
                              Get.find<AuthController>().logout();
                            },
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: _buildLogoutButton(
                            context,
                            'Web Logout',
                            Icons.logout_rounded,
                            () {},
                            true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔹 VERSION TEXT
                  Text(
                    'Latest Version 1.0.0',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 45.h),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildMenuTile(
    BuildContext context,
    String title,
    VoidCallback onTap,

    Widget leadingIcon, {
    Widget? trailingWidget,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        leading: leadingIcon,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: colorScheme.onSurface,
          ),
        ),
        trailing:
            trailingWidget ??
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
              size: 24.sp,
            ),
      ),
    );
  }

  Widget _buildLogoutButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap, [
    bool isRight = false,
  ]) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 0,
      ),
      iconAlignment: isRight ? IconAlignment.end : IconAlignment.start,
      icon: Icon(icon, color: Colors.white, size: 20.sp),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
