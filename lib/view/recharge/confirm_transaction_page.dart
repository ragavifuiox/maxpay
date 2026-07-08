// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/recharge/success_recharge_page.dart';

import 'package:get/get.dart';
import 'package:maxpay/controllers/prepaid_controller.dart';

class ConfirmTransactionPage extends GetView<PrePaidController> {
  TextEditingController whatsappController = TextEditingController();

  TextEditingController amountController = TextEditingController();
  ConfirmTransactionPage({super.key});
late String productdetid;

final args = Get.arguments ?? {};
String get enteredAmount => (args["amount"] ?? "").toString();
  String get type => args["type"] ?? "mobile";

  void setProductId(String id) {
    productdetid = id;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final args = Get.arguments ?? {};
    final String mobileNumber = args['mobileNumber'] ?? '';
    // final String productId = args['productId'] ?? '';
    whatsappController.text = mobileNumber;
    if (amountController.text.isEmpty) {
  amountController.text = enteredAmount;
}
    return Obx(() {
      final confirmData = controller.transConfirmData.value?.data;
      // final operatorLogo = confirmData?.logo ?? '';

      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      if (confirmData == null) {
        return const Scaffold(body: Center(child: Text("No Data Found")));
      }

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: CommonAppBar(title: "Confirm Transaction"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                Container(
                  padding: EdgeInsets.all(15.w),
                  margin: .symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkplceholder
                        : Color(0xffF6F7FF),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(1, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product Name',
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
                                confirmData.logo ?? '',
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
                        confirmData.paymentStatus ?? '',
                        valueColor: Colors.green,
                      ),

                      _buildDetailRow(context, 'Transaction No', mobileNumber),

                      SizedBox(height: 10.h),

                      _buildAmountBox(
                        context,
                        'Available Balance',
                        (confirmData.availableBalance ?? '0').currencyIndian,
                        Colors.blue,
                        const Color(0xffE8EEFF),
                        const Color(0xffE0E4FF),
                      ),

                  _buildAmountBox(
  context,
  'Transaction Amount',
  (enteredAmount.isNotEmpty
          ? enteredAmount
          : (confirmData.transactionAmount ?? "0"))
      .currencyIndian,
  Colors.red,
  const Color(0xffFFE5E5),
  const Color(0xffFFE4E8),
),

                      _buildAmountBox(
                        context,
                        'Commission',
                        (confirmData.commision ?? '0').currencyIndian,
                        Colors.green,
                        const Color(0xffE4FFF1),
                        const Color(0xffE6FFF3),
                      ),

                      _buildAmountBox(
                        context,
                        'Remaining Balance',
                        (confirmData.remainingBalance ?? '0').currencyIndian,
                        Colors.blue,
                        const Color(0xffE8EEFF),
                        const Color(0xffE0E4FF),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildInputLabel('For Transaction Detail', true),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildTextField(
                    context,
                    'Enter Whatsapp no',
                    controller: whatsappController,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        AssetImages.whatsapp,
                        height: 20.h,
                        width: 20.w,
                        colorFilter: ColorFilter.mode(
                          theme.textTheme.bodyMedium!.color ?? Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),

                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildInputLabel('Re-enter Amount', false),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildTextField(
                    context,
                    'Enter amount',
                    isHighlighted: true,
                    controller: amountController,
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Container(
                    height: 29,
                    width: 380,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFDDE2),
                      borderRadius: .circular(4),
                    ),
                    child: Center(
                      child: Text(
                        "Note: Wrong recharge amount is not refundable",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffFF001F),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: CommonButton(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 50.h,
                    title: "Customer Confirmation",
                    backgroundColor: AppColors.clrSecondary,
                    onTap: () {
                      if (whatsappController.text.trim().isEmpty) {
                        CustomToast.error("Please enter WhatsApp number");

                        return;
                      }

                      if (amountController.text.trim().isEmpty) {
                        CustomToast.error("Please enter amount");
                        return;
                      }

                      final args = Get.arguments ?? {};

                      Get.toNamed(
                        AppRoutes.customertrans,
                        arguments: {
                          "mobileNumber": mobileNumber,
                          "productdetid": args['productdetid'],
                          "productName": confirmData.productName ?? '',
                          "paymentStatus": confirmData.paymentStatus ?? '',
                          "transactionNo": mobileNumber,
                          "transactionAmount": amountController.text,
                          "whatsappNumber": whatsappController.text,
                          "operatorInitial":
                              (confirmData.productName ?? '').isNotEmpty
                              ? confirmData.productName![0]
                              : '',
                          "operatorColor": Colors.red,
                          "operatorLogo": confirmData.logo ?? '',
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
                      isLoading: controller.isRechargeLoading.value,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 50.h,
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: controller.isRechargeLoading.value
                          ? null
                          : () async {
                              // if (whatsappController.text.trim().isEmpty) {
                              //   Get.snackbar(
                              //     "Validation",
                              //     "Please enter WhatsApp number",
                              //   );
                              //   return;
                              // }

                              if (amountController.text.trim().isEmpty) {
                                Get.snackbar(
                                  "Validation",
                                  "Please Re-enter amount",
                                );
                                return;
                              }

                              AppLogger.debugPrint(
                                "👉 FINAL PRODUCT ID: ${controller.productdetid}",
                              );

                              final success = await controller.mobilerecharge(
                                controller.productdetid,
                                mobileNumber,
                                amountController.text.trim(),
                              );

                              AppLogger.debugPrint("AFTER API CALL");
                              // final rechargeData =
                              //     controller.rechargeResponse.value;

                              // if (success && rechargeData != null) {
                              //   final apiData = rechargeData.data?.apiResponse;

                              //   Get.to(
                              //     () => SuccessRechargePage(
                              //       productName:
                              //           apiData?.logo ??
                              //           confirmData.productName ??
                              //           "",
                              //       operatorLogo: apiData?.logo ?? "",
                              //       operatorInitial:
                              //           (apiData?.operatorName?.isNotEmpty ??
                              //               false)
                              //           ? apiData!.operatorName![0]
                              //           : "J",

                              //       operatorColor: Colors.red,
                              //     rechargeId: response.data!.recharge!.id.toString(), // <-- add this
                              //       transactionNo:
                              //           apiData?.mobileno ?? mobileNumber,

                              //       rechargeAmount:
                              //           (apiData?.amount ??
                              //                   amountController.text)
                              //               .currencyIndian,

                              //       transactionId: apiData?.txnid ?? "",

                              //       dateTime: apiData?.requestDatetime ?? "",
                              //     ),
                              //   );
                              // }


                              final rechargeData = controller.rechargeResponse.value;

if (success && rechargeData != null) {
  final apiData = rechargeData.data?.apiResponse;

  Get.to(
    () => SuccessRechargePage(
      rechargeId: rechargeData.data?.recharge?.id?.toString() ?? "",
      productName: apiData?.logo ?? confirmData.productName ?? "",
      operatorLogo: apiData?.logo ?? "",
      operatorInitial:
          (apiData?.operatorName?.isNotEmpty ?? false)
              ? apiData!.operatorName![0]
              : "J",
      operatorColor: Colors.red,
      transactionNo: apiData?.mobileno ?? mobileNumber,
      rechargeAmount:
          (apiData?.amount ?? amountController.text).currencyIndian,
      transactionId: apiData?.txnid ?? "",
      dateTime: apiData?.requestDatetime ?? "",
    ),
  );
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
      );
    });
  }
}

Widget _buildDetailRow(
  BuildContext context,
  String label,
  String value, {
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
            fontFamily: 'Poppins',
            fontWeight: .w400,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                color: valueColor ?? (isDark ? Colors.white : Colors.black),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
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
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
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
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
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
