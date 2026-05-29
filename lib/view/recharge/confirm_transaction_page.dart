import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/recharge/customer_trnas_confirmation.dart';
import 'package:maxpay/view/recharge/success_recharge_page.dart';

class ConfirmTransactionPage extends StatelessWidget {
  final String productName;
  final String operatorInitial;
  final Color operatorColor;
  final String transactionNo;
  final String amount;
  final String commission;
  final String surcharge;

  const ConfirmTransactionPage({
    super.key,
    this.productName = 'Jio',
    this.operatorInitial = 'J',
    this.operatorColor = Colors.red,
    this.transactionNo = 'TXN24321232323',
    this.amount = '₹365.00',
    this.commission = '₹40.00',
    this.surcharge = '₹5',
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: CommonAppBar(title: "Confirm Transaction"),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              /// PRODUCT NAME
              _buildDetailRow(
                context,
                'Product Name',
                productName,
                isIcon: true,
              ),

              /// PAYMENT STATUS
              _buildDetailRow(
                context,
                'Payment Status',
                'Received',
                valueColor: Colors.green,
              ),

              /// TRANSACTION NO
              _buildDetailRow(
                context,
                'Transaction No',
                transactionNo,
              ),

              SizedBox(height: 15.h),

              /// AMOUNT BOXES
_buildAmountBox(
  context,
  'Available Balance',
  '₹76954.70',
  Colors.blue,
  const Color(0xffE8EEFF), // light bg
  const Color(0xffE0E4FF), // dark bg
),

_buildAmountBox(
  context,
  'Transaction Amount',
  amount,
  Colors.red,
  const Color(0xffFFE5E5),
  const Color(0xffFFE4E8),
),

_buildAmountBox(
  context,
  'Commission',
  commission,
  Colors.green,
  const Color(0xffE4FFF1),
  const Color(0xffE6FFF3),
),

_buildAmountBox(
  context,
  'Surcharge',
  surcharge,
  Colors.orange,
  const Color(0xffFFF1DD),
  const Color(0xffFFE4E8),
),

_buildAmountBox(
  context,
  'Remaining Balance',
  '₹76954.70',
  Colors.blue,
  const Color(0xffE8EEFF), // light bg
  const Color(0xffE0E4FF), // dark bg
),
              SizedBox(height: 30.h),

              /// WHATSAPP LABEL
              _buildInputLabel('For Transaction Detail'),

              /// WHATSAPP FIELD
              _buildTextField(
                context,
                'Enter Whatsapp no',
              ),

              SizedBox(height: 20.h),

              /// AMOUNT LABEL
              _buildInputLabel('Re-enter Amount'),

              /// AMOUNT FIELD
              _buildTextField(
                context,
                'Enter amount',
              ),

              SizedBox(height: 40.h),

              /// CUSTOMER CONFIRMATION BUTTON
              Center(
                child: SizedBox(
                  width: isTablet ? 320.w : 190.w,
                  height: isTablet ? 55.h : 48.h,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerTransConfirmationScreen(
                            // productName: productName,
                            // operatorInitial: operatorInitial,
                            // operatorColor: operatorColor,
                            // rechargeAmount: amount,
                          ),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.clrSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),

                    child: FittedBox(
                      fit: BoxFit.scaleDown,

                      child: Text(
                        'Customer Confirmation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Lufga',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              /// PAY NOW BUTTON
              SizedBox(height: 20.h),

/// PAY NOW BUTTON
SafeArea(
  top: false,
  child: Padding(
    padding: EdgeInsets.only(
      bottom: 20.h,
    ),

    child: SizedBox(
      width: double.infinity,
      height: 50.h,

      child: CommonButton(
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
    ),
  ),
),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  /// DETAIL ROW
  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isIcon = false,
    Color? valueColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
          ),

          Row(
            children: [
              if (isIcon) ...[
                CircleAvatar(
                  radius: 10.r,
                  backgroundColor: operatorColor,

                  child: Text(
                    operatorInitial,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(width: 8.w),
              ],

              Text(
                value,
                style: TextStyle(
                  color:
                      valueColor ??
                      (isDark ? Colors.white : Colors.black),

                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// AMOUNT BOX
  /// AMOUNT BOX
Widget _buildAmountBox(
  BuildContext context,
  String label,
  String amount,
  Color textColor,
  Color lightBg,
  Color darkBg,
) {
  final isDark =
      Theme.of(context).brightness == Brightness.dark;

  return Container(
    margin: EdgeInsets.only(bottom: 8.h),

    padding: EdgeInsets.symmetric(
      horizontal: 12.w,
      vertical: 10.h,
    ),

    decoration: BoxDecoration(
      color: isDark ? darkBg : lightBg,

      borderRadius: BorderRadius.circular(6.r),

      border: Border.all(
        color: isDark
            ? darkBg.withOpacity(0.8)
            : lightBg,
      ),
    ),

    child: Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),

        Text(
          amount,
          style: TextStyle(
            color: textColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}  /// INPUT LABEL
  Widget _buildInputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),

      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  /// TEXT FIELD
  Widget _buildTextField(
    BuildContext context,
    String hint, {
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : AppColors.clrplceholder,

        borderRadius: BorderRadius.circular(10.r),
      ),

      child: TextField(
        keyboardType:
            keyboardType ?? TextInputType.number,

        inputFormatters:
            inputFormatters ??
            [FilteringTextInputFormatter.digitsOnly],

        style: TextStyle(
          fontSize: 14.sp,
          color: isDark ? Colors.white : Colors.black,
        ),

        decoration: InputDecoration(
          hintText: hint,

          hintStyle: TextStyle(
            color: Colors.grey.withValues(alpha: 0.5),
            fontSize: 14.sp,
          ),

          border: InputBorder.none,

          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }
}



