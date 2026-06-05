import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/auth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:pinput/pinput.dart';

/// ================= CUSTOM KEYBOARD =================

class CustomNumericKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const CustomNumericKeyboard({
    super.key,
    required this.onKeyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 400 : double.infinity,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildKeyboardRow(['1', '2', '3'], context),
            SizedBox(height: 16.h),

            _buildKeyboardRow(['4', '5', '6'], context),
            SizedBox(height: 16.h),

            _buildKeyboardRow(['7', '8', '9'], context),
            SizedBox(height: 16.h),

            _buildKeyboardRow(['backspace', '0', 'submit'], context),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboardRow(List<String> keys, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        return Expanded(
          child: _buildKeyboardButton(key, context),
        );
      }).toList(),
    );
  }

  Widget _buildKeyboardButton(
  String key,
  BuildContext context,
) {
  final isTablet =
      MediaQuery.of(context).size.width > 600;

  final isDark = Get.isDarkMode;

  return SizedBox(
    height: isTablet ? 80 : 60,

    child: TextButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        onKeyPressed(key);
      },

      style: TextButton.styleFrom(
        shape: const CircleBorder(),
      ),

     child: key == 'backspace'
    ? Icon(
        Icons.backspace_outlined,
        color: isDark
            ? Colors.white
            : Colors.black,
        size: 22,
      )
    : key == 'submit'
        ? Container(
            width: 50.w,
            height: 50.w,
            decoration: const BoxDecoration(
              color: AppColors.clrPrimary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 22,
            ),
          )
        : Text(
            key,
            style: TextStyle(
              fontSize: isTablet ? 28 : 23,
              color: isDark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
    ),
  );
}
}