import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap; // ✅ make nullable
  final Color? backgroundColor;
  final bool isLoading;

  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    return SafeArea(
      child: SizedBox(
        width: isTablet ? 220.w : 222.w,
        height: isTablet ? 55.h : 50.h,
        child: ElevatedButton(
          onPressed: isLoading ? null : onTap, // ✅ disable safely
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.clrPrimary,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
