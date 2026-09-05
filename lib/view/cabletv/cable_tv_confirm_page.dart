import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/controllers/cable_tv_controller.dart';
import 'package:maxpay/view/cabletv/cable_tv_customer_page.dart';
import 'package:maxpay/view/cabletv/cable_tv_success_page.dart';

class CableTvConfirmPage extends StatefulWidget {
  final String productName;
  final String operatorInitial;
  final Color operatorColor;
  final String transactionNo;
  final String amount;
  final String commission;
  final String surcharge;

  const CableTvConfirmPage({
    super.key,
    this.productName = 'Jio',
    this.operatorInitial = 'J',
    this.operatorColor = Colors.red,
    this.transactionNo = 'TXN24321232323',
    this.amount = '\u{20B9}365.00',
    this.commission = '\u{20B9}40.00',
    this.surcharge = '\u{20B9}5',
  });

  @override
  State<CableTvConfirmPage> createState() => _CableTvConfirmPageState();
}

class _CableTvConfirmPageState extends State<CableTvConfirmPage> {
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  late final CableTvController controller;

  late Map<String, dynamic> args;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CableTvController>();
    args = Get.arguments ?? {};

    final billData = args['bill_data'];
    final pId = (billData?.product?.id)?.toString() ?? '';

    if (pId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.confirmTransaction(pId);
      });
    }
  }

  Widget _pillButton({
    required String title,
    required Color color,
    required VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return Material(
      color: onTap == null ? color.withValues(alpha: 0.6) : color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) ...[
                const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final billData = args['bill_data'];
    final String finalProductName =
        billData?.product?.name ?? widget.productName;
    final rawAmountVal =
        billData?.bill?.amount ?? billData?.bill?.billAmount ?? 0.0;
    final double rawAmount = rawAmountVal is num
        ? rawAmountVal.toDouble()
        : double.tryParse(rawAmountVal.toString()) ?? 0.0;
    final String logoUrl = billData?.product?.logo ?? '';
    final String customerId = billData?.bill?.customerNumber ?? 'N/A';

    return Obx(() {
      final confirmData = controller.confirmResponse.value?.data;

      if (controller.isConfirmLoading.value) {
        return Scaffold(
          appBar: const CommonAppBar(title: "Confirm Transaction"),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      if (confirmData == null) {
        return Scaffold(
          appBar: const CommonAppBar(title: "Confirm Transaction"),
          body: const Center(child: Text("No Data Found")),
        );
      }

      final String availableBalanceStr = confirmData.availableBalance ?? '0';
      final String transactionAmountStr =
          confirmData.transactionAmount ?? rawAmount.toString();
      final String commissionRaw = confirmData.commision ?? '0';
      final String commissionType = confirmData.commissiontype ?? "Fixed";

      final double parsedAvailable =
          double.tryParse(
            availableBalanceStr.replaceAll(RegExp(r'[^0-9.]'), ''),
          ) ??
          0.0;
      final double parsedTransaction =
          double.tryParse(
            transactionAmountStr.replaceAll(RegExp(r'[^0-9.]'), ''),
          ) ??
          0.0;
      final double parsedCommissionRaw = double.tryParse(commissionRaw) ?? 0.0;

      double commissionAmount = 0.0;
      String commissionStr = "0";

      if (commissionType.toLowerCase() == "percentage" ||
          commissionType.toLowerCase() == "percent") {
        commissionAmount = (parsedTransaction * parsedCommissionRaw) / 100;
        commissionStr = commissionAmount.toStringAsFixed(2);
      } else {
        commissionAmount = parsedCommissionRaw;
        commissionStr = commissionRaw;
      }

      final String remainingBalanceStr =
          (parsedAvailable - parsedTransaction + commissionAmount)
              .toStringAsFixed(2);
      final String finalAmount = '\u{20B9}$parsedTransaction';

      final bool isReceived = args['is_received'] ?? true;
      final String paymentStatus = isReceived ? "Received" : "Pending";

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: const CommonAppBar(title: "Confirm Transaction"),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                Container(
                  padding: EdgeInsets.all(15.w),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkplceholder
                        : const Color(0xFFE5FBFF),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkFilterBorder
                          : AppColors.clrPrimary,
                      width: 1.5,
                    ),
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
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product Name',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: logoUrl.isNotEmpty
                                  ? Image.network(
                                      logoUrl,
                                      width: 40.w,
                                      height: 25.h,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) => Text(
                                            finalProductName,
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                    )
                                  : Text(
                                      finalProductName,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),

                      _buildDetailRow(
                        context,
                        'Payment Status',
                        paymentStatus,
                        valueColor: isReceived
                            ? const Color(0xFF0DB561)
                            : Colors.red,
                      ),
                      _buildDetailRow(context, 'Transaction No', customerId),
                      _buildDetailRow(
                        context,
                        'Available Balance',
                        '\u{20B9}$parsedAvailable',
                        valueColor: const Color(0xFF314CFF),
                      ),
                      _buildDetailRow(
                        context,
                        'Transaction Amount',
                        finalAmount,
                        valueColor: Colors.red,
                      ),
                      _buildDetailRow(
                        context,
                        'Commission',
                        '\u{20B9}$commissionStr',
                        valueColor: const Color(0xFF00C261),
                      ),
                      _buildDetailRow(
                        context,
                        'Remaining Balance',
                        '\u{20B9}$remainingBalanceStr',
                        valueColor: const Color(0xFF314CFF),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkFilterBorder
                        : const Color(0xFFE5FBFF),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isDark ? Colors.white24 : AppColors.clrPrimary,
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputLabel(
                        context,
                        'For Transaction Receipt',
                        true,
                      ),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        context,
                        'Enter Whatsapp no',
                        controller: whatsappController,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
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
                      SizedBox(height: 15.h),
                      _buildInputLabel(context, 'Re-enter Amount', false),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        context,
                        'Enter amount',
                        isHighlighted: true,
                        controller: amountController,
                        textColor: Colors.red,
                        hintColor: Colors.red,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                Center(
                  child: Container(
                    width: 380.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 20.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFDDE2),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        "Note:Transaction amount is not refundable",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffFF001F),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: _pillButton(
                          title: "Customer Confirmation",
                          color: const Color(0xFF0B1440),
                          onTap: () {
                            if (whatsappController.text.trim().isEmpty) {
                              CustomToast.error("Please enter WhatsApp number");
                              return;
                            }
                            final reentered =
                                double.tryParse(amountController.text.trim()) ??
                                0.0;
                            if (parsedTransaction != reentered) {
                              CustomToast.error(
                                "Re-entered amount does not match the transaction amount",
                              );
                              return;
                            }
                            Get.to(CableTvCustomerPage(), arguments: args);
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _pillButton(
                          title: "Pay Now",
                          color: const Color(0xFF1CACC2),
                          onTap: () {
                            if (amountController.text.trim().isEmpty) {
                              Get.snackbar(
                                "Validation",
                                "Please Re-enter amount",
                              );
                              return;
                            }
                            final reentered =
                                double.tryParse(amountController.text.trim()) ??
                                0.0;
                            if (parsedTransaction != reentered) {
                              CustomToast.error(
                                "Re-entered amount does not match the transaction amount",
                              );
                              return;
                            }
                            Get.to(CableTvSuccessPage());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInputLabel(BuildContext context, String label, bool optional) {
    return Text(
      optional ? "$label (Optional)" : label,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String hint, {
    required TextEditingController controller,
    Widget? prefixIcon,
    TextInputType keyboardType = TextInputType.number,
    bool isHighlighted = false,
    Color? textColor,
    Color? hintColor,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(
        fontSize: 14.sp,
        color: textColor ?? theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor ?? (isDark ? Colors.grey : Colors.grey.shade500),
          fontSize: 13.sp,
          fontFamily: 'Poppins',
        ),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: isHighlighted
                ? Colors.red
                : Colors.grey.withValues(alpha: 0.35),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(
            color: isHighlighted ? Colors.red : AppColors.clrPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? (isDark ? Colors.white : Colors.black),
              fontSize: 15.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
