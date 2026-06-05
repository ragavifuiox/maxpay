import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class StaffTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  final ValueChanged<String>? onChanged;

  const StaffTextFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      onChanged: onChanged,

      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 14.sp,
      ),

      decoration: InputDecoration(
        counterText: "",
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
      ),
    );
  }
}