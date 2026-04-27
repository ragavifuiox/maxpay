import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/utils/asset_images.dart';
import 'package:maxpay/core/utils/responsive.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
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
                  () {},
                  SvgPicture.asset(AssetImages.profile, width: 24.w),
                ),
                _buildMenuTile(
                  context,
                  'Grade',
                  () {},
                  SvgPicture.asset(AssetImages.grade, width: 24.w),
                ),
                _buildMenuTile(
                  context,
                  'KYC',
                  () {},
                  SvgPicture.asset(AssetImages.kyc, width: 24.w),
                ),
                _buildMenuTile(
                  context,
                  'Update Pin',
                  () {},
                  SvgPicture.asset(AssetImages.updatePin, width: 24.w),
                ),
                _buildMenuTile(
                  context,
                  'Privacy Policy',
                  () {},
                  SvgPicture.asset(AssetImages.privacyPolicy, width: 24.w),
                ),
                _buildMenuTile(
                  context,
                  'Login History',
                  () {},
                  SvgPicture.asset(AssetImages.history, width: 24.w),
                ),
                _buildMenuTile(
                  context,
                  'Web Signup',
                  () {},
                  SvgPicture.asset(AssetImages.webSignup, width: 24.w),
                ),
                _buildMenuTile(
                  context,
                  'Web Login',
                  () {},
                  SvgPicture.asset(AssetImages.webLogin, width: 24.w),
                ),
                _buildMenuTile(
                  context,
                  'Support',
                  () {},
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
                          () {},
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
  }

  Widget _buildMenuTile(
    BuildContext context,
    String title,
    VoidCallback onTap,
    Widget leadingIcon,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // final isTablet = Responsive.isTablet(context);

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
        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
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
        trailing: Icon(
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
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
