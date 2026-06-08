// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/recharge/success_recharge_page.dart';

class CustomerTransConfirmationScreen extends GetView<PrePaidController> {
   CustomerTransConfirmationScreen({super.key});

  final TextEditingController whatsappController =
      TextEditingController();

  final TextEditingController amountController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
      final confirmData = controller.transConfirmData.value?.data;
      final operatorlogo = confirmData?.logo ?? '';

    final productName = args['productName'] ?? '';
    final paymentStatus = args['paymentStatus'] ?? '';
    final transactionNo = args['transactionNo'] ?? '';
    final transactionAmount = args['transactionAmount'] ?? '';
    final whatsappNumber = args['whatsappNumber'] ?? '';
    final operatorInitial = args['operatorInitial'] ?? '';
    final operatorColor = args['operatorColor'] ?? Colors.red;
    final operatorLogo = args['operatorLogo'] ?? '';
    final mobileNumber = args['mobileNumber'] ?? '';

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(

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
          color: Colors.black.withValues(alpha:0.05),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),

    child: Column(
      children: [
    _buildRow(context, "Operator", operatorLogo, isLogo: true),

        SizedBox(height: 14.h),

        _buildRow(
          context,
          "Payment Status",
          paymentStatus,
          valueColor: Colors.green,
        ),

        SizedBox(height: 14.h),

        _buildRow(
  context,
  "Transaction No",
  transactionNo,
),

        SizedBox(height: 14.h),

        _buildRow(
          context,
          "Transaction Amount",
          transactionAmount,
        ),

        SizedBox(height: 14.h),

       

        SizedBox(height: 14.h),

       _buildRow(
  context,
  "Whatsapp no",
  whatsappNumber,
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
            Obx(() => Center(
  child: CommonButton(
    title: controller.isRechargeLoading.value
        ? "Processing..."
        : "Pay Now",

    onTap: controller.isRechargeLoading.value
        ? null
        : () async {

           

            AppLogger.debugPrint("👉 FINAL PRODUCT ID: ${controller.productdetid}");

            final success = await controller.mobilerecharge(
              controller.productdetid,
                mobileNumber,
             transactionAmount,
            );

AppLogger.debugPrint("AFTER API CALL");
            final rechargeData =
    controller.rechargeResponse.value;

if (success && rechargeData != null) {
  final apiData = rechargeData.data?.apiResponse;

  Get.to(
    () => SuccessRechargePage(
      productName: apiData?.logo ??
          confirmData?.productName ??
          "",
 operatorLogo: apiData?.logo ?? "",
      operatorInitial:
          (apiData?.operatorName?.isNotEmpty ?? false)
              ? apiData!.operatorName![0]
              : "J",

      operatorColor: Colors.red,

      transactionNo:
          apiData?.mobileno ?? mobileNumber,

      rechargeAmount:
          "₹${apiData?.amount ?? amountController.text}",

      transactionId:
          apiData?.txnid ?? "",

      dateTime:
          apiData?.requestDatetime ?? "",
    ),
  );
}
          },
  ),
)),

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
      /// LABEL
      SizedBox(
        width: 140.w, // fixed width = alignment fix
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
      /// COLON
      Text(
        ":  ",
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(width: 10.w),
      /// VALUE
      Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: isLogo
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Image.network(
                    value,
                    width: 40.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported, size: 20.sp);
                    },
                  ),
                )
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