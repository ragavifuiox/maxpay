// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/controllers/dth_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/dth_recharge/dth_failed_recharge_screen.dart';
import 'package:maxpay/view/dth_recharge/dth_success_page.dart';
import 'package:maxpay/core/data/model/confirm_dth_model.dart';

import 'package:get/get.dart';

class ConfirmDthPage extends GetView<DthController> {
  TextEditingController whatsappController = TextEditingController();

  TextEditingController amountController = TextEditingController();
  ConfirmDthPage({super.key});
  String get paymentStatus => args['paymentStatus'] ?? '';
  late String productdetid;
  final args = Get.arguments ?? {};
  String get type => args["type"] ?? "mobile";

  void setProductId(String id) {
    productdetid = id;
  }

  String get convertedPaymentStatus {
    final status = paymentStatus.toLowerCase();

    if (status == "paid") {
      return "received";
    } else {
      return "not received";
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};

    final String customerId = args['customerId'] ?? '';

    final String selectedAmount = args['amount']?.toString() ?? '';

    print("========== Confirm DTH ==========");
    print("Arguments: $args");
    print("Customer ID: $customerId");
    print("Amount: $selectedAmount");
    print("Product ID: ${args['productdetid']}");

    print("SELECTED AMOUNT => $selectedAmount");

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    AppLogger.logError(args.toString());
    final confirmData = controller.confirmdth.value?.data;
    final isFromTranactionPage = Get.arguments['isFromTranactionPage'] ?? false;

    if (controller.isLoading.value) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (confirmData == null && !isFromTranactionPage) {
      return const Scaffold(body: Center(child: Text("No Data Found")));
    }

    final String productName =
        confirmData?.productName ?? args['operator'] ?? '';
    final String logoUrl = confirmData?.logo ?? args['logo'] ?? '';

    final String availableBalanceStr = confirmData?.availableBalance ?? '0';
    final String transactionAmountStr = selectedAmount.isNotEmpty
        ? selectedAmount
        : (confirmData?.transactionAmount ?? args['amount'] ?? "0").toString();
    final String commissionStr = confirmData?.commission ?? '0';
    final String remainingBalanceStr =
        confirmData?.remainingBalance?.toString() ?? '0';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar(title: "Confirm Transaction"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkplceholder : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                     
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                            Container(
                              width: 40.w,
                              height: 30.h,
                              alignment: Alignment.centerRight,
                              child: Image.network(
                                logoUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image_not_supported);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      _buildDetailRow(
                        context,
                        'Payment Status',
                        paymentStatus,
                        valueColor: paymentStatus == "Paid"
                            ? Colors.green
                            : Colors.red,
                      ),
                      _buildDetailRow(context, 'Transaction No', customerId),

                      SizedBox(height: 10.h),

                      _buildAmountBox(
                        context,
                        'Available Balance',
                        availableBalanceStr.currencyIndian,
                        Colors.blue,
                        const Color(0xffE8EEFF),
                        const Color(0xffE0E4FF),
                      ),

                      _buildAmountBox(
                        context,
                        'Transaction Amount',
                        transactionAmountStr.currencyIndian,
                        Colors.red,
                        const Color(0xffFFE5E5),
                        const Color(0xffFFE4E8),
                      ),

                      _buildAmountBox(
                        context,
                        'Commission',
                        commissionStr.currencyIndian,
                        Colors.green,
                        const Color(0xffE4FFF1),
                        const Color(0xffE6FFF3),
                      ),

                      _buildAmountBox(
                        context,
                        'Remaining Balance',
                        remainingBalanceStr.currencyIndian,
                        Colors.blue,
                        const Color(0xffE8EEFF),
                        const Color(0xffE0E4FF),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                _buildInputLabel('For Transaction Detail', true),

                _buildTextField(
                  context,
                  'Enter Whatsapp no',
                  controller: whatsappController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 15.h),
                _buildInputLabel('Re-enter Amount', false),
                _buildTextField(
                  context,
                  'Enter amount',
                  isHighlighted: true,
                  controller: amountController,
                ),
                SizedBox(height: 20.h),
                Center(
                  child: CommonButton(
                    title: "Customer Confirmation",
                    backgroundColor: AppColors.clrSecondary,
                    onTap: () {
                      // if (whatsappController.text.trim().isEmpty) {
                      //   CustomToast.error("Please enter WhatsApp number");

                      //   return;
                      // }

                      if (amountController.text.trim().isEmpty) {
                        CustomToast.error("Please enter amount");
                        return;
                      }

                      // Validate entered amount with selected amount
                      if (amountController.text.trim() !=
                          selectedAmount.trim()) {
                        CustomToast.error(
                          "Entered amount does not match the transaction amount",
                        );
                        return;
                      }

                      final args = Get.arguments ?? {};

                      Get.toNamed(
                        AppRoutes.dthcustomer,
                        arguments: {
                          "mobileNumber": customerId,
                          "productdetid": args['productdetid'],
                          "productName": productName,
                          "paymentStatus": convertedPaymentStatus,
                          "transactionNo": customerId,
                          "transactionAmount":
                              amountController.text.trim().isNotEmpty
                              ? amountController.text.trim()
                              : transactionAmountStr,
                          "whatsappNumber":
                              whatsappController.text.trim().isEmpty
                              ? "N/A"
                              : whatsappController.text.trim(),
                          "operatorInitial": productName.isNotEmpty
                              ? productName[0]
                              : '',
                          "operatorColor": Colors.red,
                          "operatorLogo": logoUrl,
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                Obx(
                  () => Center(
                    child: CommonButton(
                      title: controller.isRechargeLoading.value
                          ? "Processing..."
                          : "Pay Now",

                      onTap: controller.isRechargeLoading.value
                          ? null
                          : () async {
                              if (whatsappController.text.trim().isEmpty) {
                                if (amountController.text.trim().isEmpty) {
                                  CustomToast.error("Please enter amount");

                                  return;
                                }

                                // Validate entered amount with selected amount
                                if (amountController.text.trim() !=
                                    selectedAmount.trim()) {
                                  CustomToast.error(
                                    "Entered amount does not match the transaction amount",
                                  );

                                  return;
                                }
                              }

                              print(
                                "ARGS PRODUCT ID => ${args['productdetid']}",
                              );
                              print(
                                "CONTROLLER PRODUCT ID => ${controller.productdetid}",
                              );

                              AppLogger.debugPrint(
                                "👉 FINAL PRODUCT ID: ${controller.productdetid}",
                              );

                              final success = await controller.dthrecharge(
                                args['productdetid'].toString(),
                                customerId,
                                amountController.text.trim(),
                                convertedPaymentStatus,
                              );

                              AppLogger.debugPrint("AFTER API CALL");
                              final rechargeData =
                                  controller.rechargeResponse.value;

                              if (rechargeData != null) {
                                final apiData = rechargeData.data?.data;

                                final status =
                                    rechargeData.status?.toLowerCase() ?? "";

                                if (success && status == "success") {
                                  Get.to(
                                    () => DthSuccessPage(
                                      productName: productName,
                                      operatorInitial:
                                          (apiData?.operatorName?.isNotEmpty ??
                                              false)
                                          ? apiData!.operatorName![0]
                                          : "J",
                                      operatorColor: Colors.red,
                                      transactionNo:
                                          apiData?.mobileno ?? customerId,
                                      rechargeAmount:
                                          (apiData?.amount ??
                                                  amountController.text)
                                              .currencyIndian,
                                      transactionId: apiData?.tnxId ?? "",
                                      dateTime: apiData?.rechargeDate ?? "",
                                    ),
                                  );
                                } else {
                                  Get.to(
                                    () => DthFailedRechargeScreen(
                                      productName: productName,
                                      operatorInitial:
                                          (apiData?.operatorName?.isNotEmpty ??
                                              false)
                                          ? apiData!.operatorName![0]
                                          : "J",
                                      operatorColor: Colors.red,
                                      transactionNo:
                                          apiData?.mobileno ?? customerId,
                                      rechargeAmount:
                                          (apiData?.amount ??
                                                  amountController.text)
                                              .currencyIndian,
                                      transactionId: apiData?.tnxId ?? "",
                                      dateTime: apiData?.rechargeDate ?? "",
                                    ),
                                  );
                                }
                              }
                            },
                    ),
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
        ),
        Row(
          children: [
            if (isIcon) ...[
              CircleAvatar(
                radius: 10.r,
                backgroundColor: AppColors.clrPrimary,
                child: Text(
                  "jio",
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
                color: valueColor ?? (isDark ? Colors.white : Colors.black),
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

Widget _buildAmountBox(
  BuildContext context,
  String label,
  String amount,
  Color textColor,
  Color lightBg,
  Color darkBg,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Container(
    margin: EdgeInsets.only(bottom: 8.h),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: isDark ? darkBg : lightBg,
      borderRadius: BorderRadius.circular(6.r),
      border: Border.all(
        color: isDark ? darkBg.withValues(alpha: 0.8) : lightBg,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
}

Widget _buildInputLabel(String label, [bool isOptionOrNot = false]) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          if (isOptionOrNot)
            TextSpan(
              text: " (Optional)",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            )
          else
            TextSpan(
              text: " *",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildTextField(
  BuildContext context,

  String hint, {
  TextEditingController? controller,
  Widget? prefixIcon,
  TextInputType? keyboardType,
  bool isHighlighted = false,
  List<TextInputFormatter>? inputFormatters,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    decoration: BoxDecoration(
      color: isDark ? AppColors.darkplceholder : AppColors.clrplceholder,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.number,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hint,
        enabledBorder: isHighlighted
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.clrPrimary),
              )
            : InputBorder.none,
        focusedBorder: isHighlighted
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.clrPrimary),
              )
            : InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    ),
  );
}
