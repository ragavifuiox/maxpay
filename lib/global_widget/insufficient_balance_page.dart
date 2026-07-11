import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class InsufficientBalancePage extends StatelessWidget {
  final double? currentBalance;
  final double? requiredAmount;

  const InsufficientBalancePage({
    super.key,
    this.currentBalance,
    this.requiredAmount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Retrieve arguments dynamically if constructors are not passed
    final args = Get.arguments;
    final double balance = currentBalance ??
        (args is Map && args['currentBalance'] != null
            ? double.tryParse(args['currentBalance'].toString())
            : null) ??
        0.0;
    final double required = requiredAmount ??
        (args is Map && args['requiredAmount'] != null
            ? double.tryParse(args['requiredAmount'].toString())
            : null) ??
        0.0;
    final double shortage = required - balance;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Insufficient Balance"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              const Spacer(),

              // Warning Illustration Container
              Container(
                width: 120.r,
                height: 120.r,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.red.withValues(alpha: 0.15)
                      : const Color(0xffFFECEF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 60.sp,
                        color: isDark
                            ? Colors.redAccent
                            : const Color(0xffFF3B30),
                      ),
                      Positioned(
                        bottom: 12.h,
                        right: 8.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? theme.scaffoldBackgroundColor
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.error,
                            size: 22.sp,
                            color: const Color(0xffFF3B30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Title
              Text(
                "Insufficient Wallet Balance",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 12.h),

              // Subtitle Description
              Text(
                "You do not have enough funds in your wallet to complete this transaction. Please add money to continue.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 36.h),

              // Breakdown Receipt Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? theme.colorScheme.surfaceContainer
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkFilterBorder
                        : Colors.grey.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    _buildRow(
                      context: context,
                      label: "Required Amount",
                      value: "₹ ${required.toStringAsFixed(2)}",
                      isBold: false,
                    ),
                    SizedBox(height: 14.h),
                    _buildRow(
                      context: context,
                      label: "Current Wallet Balance",
                      value: "₹ ${balance.toStringAsFixed(2)}",
                      isBold: false,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Divider(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : Colors.grey.withValues(alpha: 0.3),
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    _buildRow(
                      context: context,
                      label: "Amount to Add",
                      value:
                          "₹ ${(shortage > 0 ? shortage : 0.0).toStringAsFixed(2)}",
                      isBold: true,
                      valueColor: const Color(0xffFF3B30),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Primary Action: Add Money Button
              CommonButton(
                title: "Add Money to Wallet",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 52.h,
                width: double.infinity,
                borderRadius: BorderRadius.circular(12.r),
                onTap: () {
                  Get.toNamed(AppRoutes.addwallet);
                },
              ),
              SizedBox(height: 12.h),

              // Secondary Action: Go Back
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Cancel & Go Back",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow({
    required BuildContext context,
    required String label,
    required String value,
    required bool isBold,
    Color? valueColor,
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isBold ? 14.sp : 13.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            color: theme.colorScheme.onSurface.withValues(alpha: isBold ? 0.9 : 0.5),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: isBold ? 16.sp : 14.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: valueColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
