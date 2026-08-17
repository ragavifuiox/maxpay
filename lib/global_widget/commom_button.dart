import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap; 
  final Color? backgroundColor;
  final bool isLoading;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final BorderRadius? borderRadius;

  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.isLoading = false,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final dWidth = MediaQuery.of(context).size.width;
    final isTablet = dWidth > 600;

    return SafeArea(
      child: SizedBox(
        width: width ?? (isTablet ? 220.w : 222.w),
        height: height ?? (isTablet ? 55.h : 50.h),
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
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
