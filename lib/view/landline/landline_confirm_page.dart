import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/recharge/success_recharge_page.dart';
import 'package:maxpay/view/recharge/pending_screen.dart';
import 'package:maxpay/view/recharge/failed_recharge_page.dart';
import 'package:maxpay/controllers/landline_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/controllers/homepage_controller.dart';

class LandlineConfirmPage extends StatefulWidget {
  const LandlineConfirmPage({super.key});

  @override
  State<LandlineConfirmPage> createState() => _LandlineConfirmPageState();
}

class _LandlineConfirmPageState extends State<LandlineConfirmPage> {
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  late final LandlineController controller;
  late Map<String, dynamic> args;

  @override
  void initState() {
    super.initState();
    controller = Get.find<LandlineController>();
    args = Get.arguments ?? {};

    final pId = args['product_id']?.toString() ?? '';

    if (pId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.confirmTransaction(productid: pId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final homeController = Get.isRegistered<HomePageController>()
        ? Get.find<HomePageController>()
        : null;
    final walletBal =
        homeController?.walletBalance.value?.data?.balance?.toString() ?? '';

    return Obx(() {
      if (controller.isConfirmLoading.value) {
        return Scaffold(
          appBar: const CommonAppBar(title: "Confirm Transaction"),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      final confirmData = controller.confirmResponse.value?.data;

      if (confirmData == null) {
        return Scaffold(
          appBar: const CommonAppBar(title: "Confirm Transaction"),
          body: const Center(child: Text("No Data Found")),
        );
      }

      final String finalProductName =
          confirmData.productName ??
          args['actual_product_name']?.toString() ??
          '';
      final String logoUrl =
          confirmData.logo ?? args['actual_product_logo']?.toString() ?? '';
      final String customerId =
          args['customer_id']?.toString() ?? confirmData.transactionNo ?? 'N/A';

      final String availableBalanceStr =
          confirmData.availableBalance ?? walletBal;
      final String transactionAmountStr =
          confirmData.transactionAmount ?? confirmData.amount ?? '0';
      final String commissionRaw = confirmData.commision ?? '0';
      final String commissionType = confirmData.commissiontype ?? "Fixed";

      final String isReceivedParam = args['is_received'] == false
          ? "Pending"
          : "Received";

      return Scaffold(
        appBar: const CommonAppBar(title: "Confirm Transaction"),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TransactionSummaryCard(
                  productName: finalProductName,
                  logoUrl: logoUrl,
                  operatorInitial: finalProductName.isNotEmpty
                      ? finalProductName[0]
                      : 'L',
                  operatorColor: Colors.deepPurple,
                  transactionNo: customerId,
                  amount: transactionAmountStr.isNotEmpty
                      ? '\u{20B9}$transactionAmountStr'
                      : '',
                  paymentStatus: isReceivedParam,
                  paymentStatusColor: isReceivedParam == "Received"
                      ? const Color(0xFF00B050)
                      : Colors.red,
                  commission: commissionRaw.isNotEmpty
                      ? (commissionType.toLowerCase() == "percentage"
                            ? '$commissionRaw%'
                            : '\u{20B9}$commissionRaw')
                      : '',
                  surcharge: '',
                  availableBalance: availableBalanceStr.isNotEmpty
                      ? '\u{20B9}$availableBalanceStr'
                      : '',
                  remainingBalance:
                      (confirmData.remainingBalance ?? '').isNotEmpty
                      ? '\u{20B9}${confirmData.remainingBalance}'
                      : '',
                ),
                SizedBox(height: 18.h),
                _buildInputLabel(context, 'For Transaction Detail (Optional)'),
                _buildTextField(
                  context,
                  'Enter Whatsapp no',
                  controller: whatsappController,
                ),
                SizedBox(height: 18.h),
                _buildInputLabel(context, 'Re-enter Amount'),
                _buildTextField(
                  context,
                  'Enter amount',
                  controller: amountController,
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Obx(() {
                    return CommonButton(
                      title: 'Pay Now',
                      isLoading: controller.isPayLoading.value,
                      onTap: () async {
                        final reentered =
                            double.tryParse(amountController.text.trim()) ??
                            0.0;
                        final originalAmount =
                            double.tryParse(transactionAmountStr) ?? 0.0;

                        if (originalAmount != reentered) {
                          CustomToast.error(
                            "Re-entered amount does not match the transaction amount",
                          );
                          return;
                        }

                        bool isSuccess = await controller.payBill(
                          productId: args['product_id']?.toString() ?? '',
                          consumerNumber: customerId,
                          amount: transactionAmountStr,
                          reEnterAmount: amountController.text.trim(),
                          enquiryReference: '',
                          customerMobile: whatsappController.text.trim(),
                          whatsappNumber: whatsappController.text.trim(),
                        );

                        if (isSuccess) {
                          final payData =
                              controller.payBillResponse.value?.data;
                          final String status = payData?.status ?? '';
                          final String trTime =
                              payData?.dateTime ?? DateTime.now().toString();
                          final String txId = payData?.txnid ?? '';
                          final String pName =
                              payData?.product?.name ?? finalProductName;
                          final String logo = payData?.product?.logo ?? logoUrl;
                          final String rAmount =
                              payData?.transactionAmount ??
                              transactionAmountStr;
                          final String rId =
                              payData?.rechargeId?.toString() ?? '';
                          final String refId = payData?.referenceId ?? '';

                          if (status.toLowerCase() == 'success') {
                            Get.off(
                              () => SuccessRechargePage(
                                productName: pName,
                                operatorInitial: pName.isNotEmpty
                                    ? pName[0]
                                    : 'L',
                                operatorColor: Colors.deepPurple,
                                transactionNo: customerId,
                                rechargeAmount: rAmount,
                                transactionId: txId,
                                dateTime: trTime,
                                operatorLogo: logo,
                                rechargeId: rId,
                                refId: refId,
                              ),
                            );
                          } else if (status.toLowerCase() == 'pending' ||
                              status.toLowerCase() == 'processing') {
                            Get.off(
                              () => PendingScreen(
                                productName: pName,
                                operatorInitial: pName.isNotEmpty
                                    ? pName[0]
                                    : 'L',
                                operatorColor: Colors.deepPurple,
                                transactionNo: customerId,
                                rechargeAmount: rAmount,
                                transactionId: txId,
                                dateTime: trTime,
                                operatorLogo: logo,
                                rechargeId: rId,
                              ),
                            );
                          } else {
                            Get.off(
                              () => FailedRechargePage(
                                productName: pName,
                                operatorInitial: pName.isNotEmpty
                                    ? pName[0]
                                    : 'L',
                                operatorColor: Colors.deepPurple,
                                transactionNo: customerId,
                                rechargeAmount: rAmount,
                                transactionId: txId,
                                dateTime: trTime,
                                operatorLogo: logo,
                                rechargeId: rId,
                              ),
                            );
                          }
                        }
                      },
                    );
                  }),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInputLabel(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String hint, {
    required TextEditingController controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.number,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 14.sp, color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isDark ? AppColors.textclr : Colors.grey,
          fontSize: 13.sp,
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.35)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: AppColors.clrPrimary),
        ),
      ),
    );
  }
}

class _TransactionSummaryCard extends StatelessWidget {
  const _TransactionSummaryCard({
    required this.productName,
    required this.operatorInitial,
    required this.operatorColor,
    this.logoUrl,
    required this.transactionNo,
    required this.amount,
    required this.paymentStatus,
    required this.paymentStatusColor,
    required this.commission,
    required this.surcharge,
    this.availableBalance = '',
    this.remainingBalance = '',
  });

  final String productName;
  final String operatorInitial;
  final Color operatorColor;
  final String? logoUrl;
  final String transactionNo;
  final String amount;
  final String paymentStatus;
  final Color paymentStatusColor;
  final String commission;
  final String surcharge;
  final String availableBalance;
  final String remainingBalance;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : const Color(0xFFF6F7FF),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            context,
            label: 'Product Name',
            value: productName,
            trailing: (logoUrl != null && logoUrl!.isNotEmpty)
                ? Image.network(
                    logoUrl!,
                    width: 32.w,
                    height: 32.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        _OperatorBadge(
                          label: productName.isNotEmpty
                              ? productName
                              : operatorInitial,
                          color: operatorColor,
                        ),
                  )
                : _OperatorBadge(
                    label: productName.isNotEmpty
                        ? productName
                        : operatorInitial,
                    color: operatorColor,
                  ),
          ),
          SizedBox(height: 18.h),
          _buildDetailRow(
            context,
            label: 'Payment Status',
            value: paymentStatus,
            valueColor: paymentStatusColor,
          ),
          if (transactionNo.isNotEmpty) ...[
            SizedBox(height: 18.h),
            _buildDetailRow(
              context,
              label: 'Transaction No',
              value: transactionNo,
              compactValue: true,
            ),
          ],
          if (availableBalance.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _AmountBand(
              label: 'Available Balance',
              value: availableBalance,
              color: const Color(0xFF315CFF),
              backgroundColor: const Color(0xFFE1E6FF),
            ),
          ],
          if (amount.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _AmountBand(
              label: 'Transaction Amount',
              value: amount,
              color: const Color(0xFFFF003D),
              backgroundColor: const Color(0xFFFFDFE2),
            ),
          ],
          if (commission.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _AmountBand(
              label: 'Commission',
              value: commission,
              color: const Color(0xFF00B050),
              backgroundColor: const Color(0xFFDFF8E9),
            ),
          ],
          if (surcharge.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _AmountBand(
              label: 'Surcharge',
              value: surcharge,
              color: const Color(0xFFFF4F6D),
              backgroundColor: const Color(0xFFFFE2E7),
            ),
          ],
          if (remainingBalance.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _AmountBand(
              label: 'Remaining Balance',
              value: remainingBalance,
              color: const Color(0xFF315CFF),
              backgroundColor: const Color(0xFFE1E6FF),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
    Widget? trailing,
    bool compactValue = false,
  }) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        trailing ??
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: compactValue ? 12.sp : 13.sp,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? textColor,
                ),
              ),
            ),
      ],
    );
  }
}

class _OperatorBadge extends StatelessWidget {
  const _OperatorBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: color,
      child: Text(
        label.length <= 3 ? label : label.substring(0, 3),
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w800,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

class _AmountBand extends StatelessWidget {
  const _AmountBand({
    required this.label,
    required this.value,
    required this.color,
    required this.backgroundColor,
  });

  final String label;
  final String value;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
