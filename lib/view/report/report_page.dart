import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/utils/theme.dart';
import 'package:maxpay/view/coming_soon.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isTablet = Responsive.isTablet(context);
    final profileController = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(
            ProfileController(
              getProfileUseCase: sl(),
              profileUpdateUseCase: sl(),
              updateprofileotpusecase: sl(),
            ),
          );

    return Obx(() {
      print(
        "STAFF VALUE => ${profileController.profileData.value?.data?.isstaff}",
      );

      final isStaff =
          profileController.profileData.value?.data?.isstaff ?? false;

      print("IS STAFF => $isStaff");
      final isDark = themeController.isDarkMode;
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      return Container(
        decoration: isDark
            ? null
            : BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.bgOverlay),
                  fit: BoxFit.cover,
                ),
              ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Report',
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  _buildMenuTile(
                    context,
                    'My Earnings',
                    () {
                      Get.toNamed(AppRoutes.myearning);
                    },
                    SvgPicture.asset(AssetImages.earnings, width: 24.w),
                  ),
                  _buildMenuTile(
                    context,
                    'Wallet Credit',
                    () {
                      Get.toNamed(AppRoutes.walletcredit);
                    },
                    SvgPicture.asset(AssetImages.walletcredit, width: 24.w),
                  ),

                  _buildMenuTile(
                    context,
                    'Transfer Detail',
                    () {
                      Get.toNamed(AppRoutes.transferdetail);
                    },
                    SvgPicture.asset(AssetImages.TransferDetial, width: 24.w),
                  ),
                  _buildMenuTile(
                    context,
                    'Refunds',
                    () {
                      Get.toNamed(AppRoutes.refund);
                    },

                    SvgPicture.asset(AssetImages.refunds, width: 24.w),
                  ),

                  // _buildMenuTile(
                  //   context,
                  //   'Cash Back',
                  //   () {
                  //       Get.toNamed(AppRoutes.cashback);
                  //   },
                  //   SvgPicture.asset(AssetImages.cashback, width: 24.w),
                  // ),
                  _buildMenuTile(
                    context,
                    'Dispute Report',
                    () {
                      Get.toNamed(AppRoutes.dispute);
                    },
                    SvgPicture.asset(AssetImages.bank, width: 24.w),
                  ),

                  _buildMenuTile(
                    context,
                    'Statement',
                    () {
                      Get.toNamed(AppRoutes.statement);
                    },
                    SvgPicture.asset(AssetImages.dispute, width: 21.w),
                  ),
                  if (!isStaff)
                    _buildMenuTile(
                      context,
                      'Staff List',
                      () {
                        Get.toNamed(AppRoutes.stafflist);
                      },
                      SvgPicture.asset(AssetImages.stafflist, width: 21.w),
                    ),
                  _buildMenuTile(context, 'Grade', () {
                    Get.to(() => ComingSoonPage());
                  }, SvgPicture.asset(AssetImages.grade, width: 21.w)),
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
    Widget icon,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        dense: true,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(vertical: 4.h),
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: colorScheme.onSurface.withValues(alpha: 0.5),
          size: 24.sp,
        ),
      ),
    );
  }
}
