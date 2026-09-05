import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/cable_tv_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/cabletv/cable_tv_success_page.dart';

class CableTvCustomerPage extends GetView<CableTvController> {
  CableTvCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final args = Get.arguments ?? {};
    final billData = args['bill_data'];
    final bool isReceived = args['is_received'] ?? true;

    final confirmData = controller.confirmResponse.value?.data;

    final productName =
        confirmData?.productName ?? billData?.product?.name ?? "N/A";
    final paymentStatus = isReceived ? "Received" : "Not Received";
    final transactionNo =
        confirmData?.transactionNo ?? billData?.bill?.billNumber ?? "N/A";
    final String amountStr =
        confirmData?.transactionAmount ??
        (billData?.bill?.amount ?? billData?.bill?.billAmount ?? 0).toString();
        
    final double amount =
        double.tryParse(amountStr.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    final operatorLogo = confirmData?.logo ?? billData?.product?.logo ?? '';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: ""),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
          child: SizedBox(
            height: 50.h,
            child: Center(
              child: CommonButton(
                title: 'Pay Now',
                onTap: () {
                  Get.to(CableTvSuccessPage());
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),

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
                      color: Colors.black.withValues(alpha: 0.05),
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
                      operatorLogo,
                      isLogo: true,
                      fallbackText: productName,
                    ),
                    SizedBox(height: 14.h),

                    _buildRow(
                      context,
                      "Payment Status",
                      paymentStatus,
                      valueColor: isReceived ? Colors.green : Colors.red,
                    ),
                    SizedBox(height: 14.h),

                    _buildRow(context, "Transaction No", transactionNo),
                    SizedBox(height: 14.h),

                    _buildRow(context, "Transaction Amount", "\u{20B9}$amount"),
                    SizedBox(height: 14.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),

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
    String fallbackText = "",
  }) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140.w,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 15.w),

        Text(
          ":  ",
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 10.w),

        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: isLogo
                ? (value.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: Image.network(
                            value,
                            width: 40.w,
                            height: 20.h,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Text(
                                fallbackText,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      valueColor ?? theme.colorScheme.onSurface,
                                ),
                              );
                            },
                          ),
                        )
                      : Text(
                          fallbackText,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: valueColor ?? theme.colorScheme.onSurface,
                          ),
                        ))
                : Text(
                    value,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: valueColor ?? theme.colorScheme.onSurface,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
