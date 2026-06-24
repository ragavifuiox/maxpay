import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class PinTextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const PinTextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<PinTextFieldWidget> createState() => _PinTextFieldWidgetState();
}

class _PinTextFieldWidgetState extends State<PinTextFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      maxLength: 4,
      obscureText: _obscureText,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: _obscureText ? 8.0 : 0.0,
      ),
      decoration: InputDecoration(
        counterText: "",
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
          fontSize: 14.sp,
          letterSpacing: 0.0,
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : const Color(0xFFF7F7F7),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            size: 20.sp,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.clrPrimary, width: 1.5),
        ),
      ),
    );
  }
}
