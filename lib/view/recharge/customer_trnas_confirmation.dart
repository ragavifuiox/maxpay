import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/recharge/success_recharge_page.dart';

class CustomerTransConfirmationScreen extends StatelessWidget {
   final String productName;
  final String operatorInitial;
  final Color operatorColor;
  final String transactionNo;
  final String amount;
  final String commission;
  final String surcharge;

const CustomerTransConfirmationScreen({  super.key,
    this.productName = 'Jio',
    this.operatorInitial = 'J',
    this.operatorColor = Colors.red,
    this.transactionNo = 'TXN24321232323',
    this.amount = '₹365.00',
    this.commission = '₹40.00',
    this.surcharge = '₹5',});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: CommonAppBar(title: ""),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),

        child: Column(
          children: [
            SizedBox(height: 20.h),

            /// DETAILS CARD
            /// DETAILS CARD
RotatedBox(
  quarterTurns: 2,
  child: Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),

    decoration: BoxDecoration(
      color: isDark
          ? AppColors.darkplceholder
          : const Color(0xFFF5F5FA),

      borderRadius: BorderRadius.circular(12.r),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),

    child: Column(
      children: [
        _buildRow(
          context,
          "Product Name",
          "Jio",
          isLogo: true,
        ),

        SizedBox(height: 14.h),

        _buildRow(
          context,
          "Payment Status",
          "Paid",
          valueColor: Colors.green,
        ),

        SizedBox(height: 14.h),

        _buildRow(
          context,
          "Transaction No",
          "TXN24321232323",
        ),

        SizedBox(height: 14.h),

        _buildRow(
          context,
          "Transaction Amount",
          "₹365.00",
        ),

        SizedBox(height: 14.h),

        _buildRow(
          context,
          "User Name",
          "Non Stop Unlimited",
        ),

        SizedBox(height: 14.h),

        _buildRow(
          context,
          "Whatsapp no",
          "9856389363",
        ),
      ],
    ),
  ),
),

            SizedBox(height: 30.h),

            /// CONFIRM BUTTON
           RotatedBox(
  quarterTurns: 2,
  child: SizedBox(
    width: 220.w,
    child: ElevatedButton(
      onPressed: () {},

      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF001B6B),

        padding: EdgeInsets.symmetric(vertical: 14.h),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),

      child: Text(
        "Please Confirm",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
),
            const Spacer(),

            /// PAY NOW
            CommonButton(
              title: "Pay Now",
              onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessRechargePage(
                          productName: productName,
                          operatorInitial: operatorInitial,
                          operatorColor: operatorColor,
                          rechargeAmount: amount,
                        ),
                      ),
                    );
                  },
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String title,
    String value, {
    bool isLogo = false,
    Color? valueColor,
  }) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Expanded(
          flex: 5,
          child: Row(
            children: [
              if (isLogo) ...[
                CircleAvatar(
                  radius: 10.r,
                  backgroundColor: Colors.red,

                  child: Text(
                    "Jio",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 7.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(width: 8.w),
              ],

              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color:
                        valueColor ??
                        theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}