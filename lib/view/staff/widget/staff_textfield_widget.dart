import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class StaffTextFieldWidget extends StatelessWidget {
  final String hintText;

  const StaffTextFieldWidget({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: theme.colorScheme.outline,
          fontSize: 14.sp,
        ),

        filled: true,
       
fillColor: theme.brightness == Brightness.dark
    ? AppColors.darkplceholder
    : AppColors.background,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 14.h,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}