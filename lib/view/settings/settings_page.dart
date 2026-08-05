import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/controllers/update_pin_controller.dart';
import 'package:maxpay/controllers/web_login_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final authController = Get.find<AuthController>();
    final updatePinController = Get.put(
      UpdatePinController(
        updatepinusecase: sl(),
        updateSendOtpUsecase: sl(),
        updateotpusecase: sl(),
      ),
    );
    final webcontroller = Get.isRegistered<WebLoginController>()
        ? Get.find<WebLoginController>()
        : Get.put(
            WebLoginController(webloginusecase: sl(), webLogoutUsecase: sl()),
            permanent: true,
          );
    final isTablet = Responsive.isTablet(context);

    Future<void> openRatingReview() async {
      final InAppReview inAppReview = InAppReview.instance;
      try {
        await inAppReview.openStoreListing(appStoreId: 'com.paylink.retailor');
      } catch (e) {
        debugPrint("Could not open store listing: $e");
      }
    }

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
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            title: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: isTablet ? 24.sp : 20.sp,
                color: colorScheme.onSurface,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Share.share(
                    'http://139.59.91.7/test_paylinkonline.in/public/retailer/login',
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Link",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Icon(
                        Icons.reply_rounded,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.webloginqr);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 37.w),
                  child: Image.asset(
                    AssetImages.qrcode,
                    width: 26.w,
                    height: 26.w,
                  ),
                ),
              ),
            ],
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
                    'Cashback',
                    () {
                      Get.toNamed(AppRoutes.cashback);
                    },
                    SvgPicture.asset(AssetImages.cashback, width: 24.w),
                  ),

                  _buildMenuTile(context, 'KYC', () {
                    Get.toNamed(AppRoutes.kyc);
                  }, SvgPicture.asset(AssetImages.kyc, width: 24.w)),

                   _buildMenuTile(context, 'Bank Details', () {
                    Get.toNamed(AppRoutes.bank);
                  }, SvgPicture.asset(AssetImages.cashback, width: 24.w)),
                  _buildMenuTile(
                    context,
                    'Update M-Pin',
                    () {
                      Get.defaultDialog(
                        title: "Confirm",
                        titleStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        middleText:
                            "Are you sure you want to update your M-PIN?",
                        middleTextStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        textCancel: "No",
                        textConfirm: "Yes",
                        confirmTextColor: Colors.white,
                        cancelTextColor: Colors.grey,
                        buttonColor: AppColors.clrPrimary,
                        barrierDismissible: false,
                        onCancel: () {
                          Get.back();
                        },
                        onConfirm: () {
                          Get.back(); // Close dialog
                          updatePinController.sendUpdatePinOtp();
                        },
                      );
                    },
                    SvgPicture.asset(AssetImages.updatePin, width: 24.w),
                  ),
                  _buildMenuTile(
                    context,
                    authController.isFingerPrint.value == 1
                        ? 'Update Fingerprint'
                        : 'Add Fingerprint',
                    () {
                      Get.toNamed(
                        AppRoutes.biometricsIntro,
                        arguments: {
                          'is_update': authController.isFingerPrint.value == 1,
                        },
                      );
                    },
                    Icon(
                      Icons.fingerprint,
                      size: 24.w,
                      color: AppColors.clrPrimary,
                    ),
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
                      openRatingReview();
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

                  /// 🔹 LOGOUT BUTTONS
                  /// 
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
                              Get.defaultDialog(
                                title: "Confirm Logout",
                                titleStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),

                                middleText: "Do you want to logout?",
                                middleTextStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),

                                textCancel: "No",
                                textConfirm: "Yes",

                                confirmTextColor: Colors.white,
                                cancelTextColor: Colors.grey,
                                buttonColor: AppColors.clrPrimary,

                                barrierDismissible: false,

                                onCancel: () {
                                  Get.back();
                                },

                                onConfirm: () {
                                  Get.back(); // close dialog first
                                  Get.find<AuthController>().logout();
                                  // OR your web logout:
                                  // webcontroller.WebLogout(isweb: "0");
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: _buildLogoutButton(
                            context,
                            'Web Logout',
                            Icons.logout_rounded,
                            () {
                              Get.defaultDialog(
                                title: "Confirm Logout",
                                titleStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                  color: theme.colorScheme.onSurface,
                                ),
                                middleText: "Do you want to logout from Web?",
                                middleTextStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: theme.colorScheme.onSurface,
                                ),
                                textCancel: "No",
                                textConfirm: "Yes",
                                confirmTextColor: Colors.white,
                                buttonColor: AppColors.clrPrimary,
                                cancelTextColor: Colors.grey,
                                onConfirm: () {
                                  Get.back();
                                  webcontroller.WebLogout(isweb: "0");
                                },
                              );
                            },
                            true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔹 VERSION TEXT
                  FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      final version = snapshot.data?.version ?? '';
                      return Text(
                        version.isNotEmpty
                            ? 'Latest Version $version'
                            : 'Latest Version',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                        ),
                      );
                    },
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
