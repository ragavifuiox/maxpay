import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/controllers/broadband_controller.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/view/broadband/broad_band_customer_page.dart';
import 'package:maxpay/view/broadband/broad_band_success_page.dart';


class BroadbandConfirmPage extends StatefulWidget {
  final String productName;
  final String operatorInitial;
  final Color operatorColor;
  final String transactionNo;
  final String amount;
  final String commission;
  final String surcharge;

  const BroadbandConfirmPage({
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
  State<BroadbandConfirmPage> createState() => _BroadbandConfirmPageState();
}

class _BroadbandConfirmPageState extends State<BroadbandConfirmPage> {
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  late final BroadbandController controller;

  late Map<String, dynamic> args;

  @override
  void initState() {
    super.initState();
    controller = Get.find<BroadbandController>();
    args = Get.arguments ?? {};

    final billData = args['bill_data'];
    final pId = (billData?.product?.id)?.toString() ?? '';

    if (pId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.confirmTransaction(pId);
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final billData = args['bill_data'];
    final isReceived = args['is_received'] ?? true;
    final String paymentStatus = isReceived ? "Received" : "Pending";
    final String finalProductName =
        billData?.product?.name ?? widget.productName;
    final String customerId = billData?.bill?.customerNumber ?? 'N/A';
    final String logoUrl = billData?.product?.logo ?? '';

    final rawAmountVal =
        billData?.bill?.amount ?? billData?.bill?.billAmount ?? 0.0;
    final double rawAmount = rawAmountVal is num
        ? rawAmountVal.toDouble()
        : double.tryParse(rawAmountVal.toString()) ?? 0.0;

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
                  operatorInitial: widget.operatorInitial,
                  operatorColor: widget.operatorColor,
                  transactionNo: customerId,
                  amount: finalAmount,
                  paymentStatus: paymentStatus,
                  paymentStatusColor: isReceived
                      ? const Color(0xFF00B050)
                      : Colors.red,
                  commission: '\u{20B9}$commissionStr',
                  surcharge: widget.surcharge,
                  availableBalance: '\u{20B9}$parsedAvailable',
                  remainingBalance: '\u{20B9}$remainingBalanceStr',
                ),

                SizedBox(height: 18.h),
                _buildInputLabel(context, 'For Transaction Detail (Optional)'),
                _buildTextField(
                  context,
                  'Enter Whatsapp no ',
                  textController: whatsappController,
                ),
                SizedBox(height: 18.h),
                _buildInputLabel(context, 'Re-enter Amount'),
                _buildTextField(
                  context,
                  'Enter amount',
                  textController: amountController,
                ),
                SizedBox(height: 20.h),
                Center(
                  child: CommonButton(
                    title: "Customer Confirmation",
                    backgroundColor: AppColors.clrSecondary,
                    onTap: () {
                      if (whatsappController.text.trim().isEmpty) {
                        CustomToast.error("Please enter WhatsApp number");
                        return;
                      }
                      final reentered =
                          double.tryParse(amountController.text.trim()) ?? 0.0;
                      if (parsedTransaction != reentered) {
                        CustomToast.error(
                          "Re-entered amount does not match the transaction amount",
                        );
                        return;
                      }
                      Get.to(BroadBandCustomerPage(), arguments: args);
                    },
                  ),
                ),
                const SizedBox(height: 21),
                Center(
                  child: CommonButton(
                    title: 'Pay Now',
                    onTap: () {
                      if (amountController.text.trim().isEmpty) {
                        Get.snackbar("Validation", "Please Re-enter amount");
                        return;
                      }
                      final reentered =
                          double.tryParse(amountController.text.trim()) ?? 0.0;
                      if (parsedTransaction != reentered) {
                        CustomToast.error(
                          "Re-entered amount does not match the transaction amount",
                        );
                        return;
                      }
                      Get.to(BroadBandSuccessPage());
                    },
                  ),
                ),
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
    TextEditingController? textController,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      controller: textController,
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
    required this.transactionNo,
    required this.amount,
    required this.paymentStatus,
    required this.paymentStatusColor,
    required this.commission,
    required this.surcharge,
    required this.availableBalance,
    required this.remainingBalance,
  });

  final String productName;
  final String operatorInitial;
  final Color operatorColor;
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
            trailing: _OperatorBadge(
              label: productName.isNotEmpty ? productName : operatorInitial,
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
          SizedBox(height: 18.h),
          _buildDetailRow(
            context,
            label: 'Transaction No',
            value: transactionNo,
            compactValue: true,
          ),
          SizedBox(height: 12.h),
          _AmountBand(
            label: 'Available Balance',
            value: availableBalance,
            color: const Color(0xFF315CFF),
            backgroundColor: const Color(0xFFE1E6FF),
          ),
          SizedBox(height: 10.h),
          _AmountBand(
            label: 'Transaction Amount',
            value: amount,
            color: const Color(0xFFFF003D),
            backgroundColor: const Color(0xFFFFDFE2),
          ),
          SizedBox(height: 10.h),
          _AmountBand(
            label: 'Commission',
            value: commission,
            color: const Color(0xFF00B050),
            backgroundColor: const Color(0xFFDFF8E9),
          ),
          SizedBox(height: 10.h),
          // _AmountBand(
          //   label: 'Surcharge',
          //   value: surcharge,
          //   color: const Color(0xFFFF4F6D),
          //   backgroundColor: const Color(0xFFFFE2E7),
          // ),
          // SizedBox(height: 10.h),
          _AmountBand(
            label: 'Remaining Balance',
            value: remainingBalance,
            color: const Color(0xFF315CFF),
            backgroundColor: const Color(0xFFE1E6FF),
          ),
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
