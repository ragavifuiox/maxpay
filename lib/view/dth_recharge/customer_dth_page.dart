// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/dth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/dth_recharge/dth_failed_recharge_screen.dart';
import 'package:maxpay/view/dth_recharge/dth_success_page.dart';

class CustomerDthPage extends GetView<DthController> {
  CustomerDthPage({super.key});

  final TextEditingController whatsappController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final confirmData = controller.confirmdth.value?.data;
    final operatorlogo = confirmData?.logo ?? '';

    final productName = args['productName'] ?? '';
    final paymentStatus = args['paymentStatus'] ?? '';
    final transactionNo = args['transactionNo'] ?? '';
    final transactionAmount = args['transactionAmount'] ?? '';
    final whatsappNumber = args['whatsappNumber'] ?? "N/A";
    final operatorInitial = args['operatorInitial'] ?? '';
    final operatorColor = args['operatorColor'] ?? Colors.red;
    final operatorLogo = args['operatorLogo'] ?? '';
    final mobileNumber = args['mobileNumber'] ?? '';
    final productdetid = args['productdetid'] ?? '';
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: CommonAppBar(title: ""),
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
                    _buildRow(context, "Operator", operatorLogo, isLogo: true),

                    SizedBox(height: 14.h),

                    _buildRow(
                      context,
                      "Payment Status",
                      paymentStatus.toString().toLowerCase() == "received"
                          ? "Paid"
                          : "Pending",
                      valueColor:
                          paymentStatus.toString().toLowerCase() == "received"
                          ? Colors.green
                          : Colors.orange,
                    ),
                    SizedBox(height: 14.h),

                    _buildRow(context, "Transaction No", transactionNo),

                    SizedBox(height: 14.h),

                    _buildRow(
                      context,
                      "Transaction Amount",
                      (transactionAmount as String).currencyIndian,
                    ),

                    SizedBox(height: 14.h),

                    SizedBox(height: 14.h),

                    _buildRow(context, "Whatsapp no", whatsappNumber),
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
            Obx(
              () => Center(
                child: CommonButton(
                  title: controller.isRechargeLoading.value
                      ? "Processing..."
                      : "Pay Now",

                  onTap: controller.isRechargeLoading.value
                      ? null
                      : () async {
                          AppLogger.debugPrint(
                            "👉 FINAL PRODUCT ID: $productdetid",
                          );

                          final commissionAmount = args['commission'] ?? "0.00";
                          final success = await controller.dthrecharge(
                            productdetid.toString(),
                            mobileNumber.toString(),
                            transactionAmount.toString(),
                            paymentStatus.toString(),
                            commissionAmount,
                          );

                          AppLogger.debugPrint("AFTER API CALL");

                          final rechargeData =
                              controller.rechargeResponse.value;

                          if (rechargeData != null) {
                            final apiData = rechargeData.response;

                            final status =
                                rechargeData.status?.toLowerCase() ?? "";

                            if (success && status == "success") {
                              Get.to(
                                () => DthSuccessPage(
                                  rechargeId:
                                      rechargeData.transactionId?.toString() ??
                                      "",
                                  productName:
                                      confirmData?.productName ?? productName,
                                  operatorLogo: operatorLogo,

                                  operatorInitial: productName.isNotEmpty
                                      ? productName[0]
                                      : "J",

                                  operatorColor: Colors.red,

                                  transactionNo:
                                      apiData?.mobileNo ?? mobileNumber,

                                  rechargeAmount:
                                      (apiData?.amount?.toString() ??
                                              transactionAmount)
                                          .toString()
                                          .currencyIndian,

                                  transactionId:
                                      rechargeData.transactionDetails?.txnId ??
                                      apiData?.tnxId ??
                                      "",

                                  dateTime:
                                      apiData?.rechargeDate ??
                                      DateTime.now().toString(),
                                ),
                              );
                            } else {
                              Get.to(
                                () => DthFailedRechargeScreen(
                                  productName:
                                      confirmData?.productName ?? productName,

                                  operatorInitial: productName.isNotEmpty
                                      ? productName[0]
                                      : "J",

                                  operatorColor: Colors.red,

                                  transactionNo:
                                      apiData?.mobileNo ?? mobileNumber,

                                  rechargeAmount:
                                      (apiData?.amount?.toString() ??
                                              transactionAmount)
                                          .toString()
                                          .currencyIndian,

                                  transactionId:
                                      rechargeData.transactionDetails?.txnId ??
                                      apiData?.tnxId ??
                                      "",

                                  dateTime:
                                      apiData?.rechargeDate ??
                                      DateTime.now().toString(),
                                ),
                              );
                            }
                          }
                        },
                ),
              ),
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
