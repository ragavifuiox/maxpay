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
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/dth_recharge/dth_failed_recharge_screen.dart';
import 'package:maxpay/view/dth_recharge/dth_success_page.dart';
import 'package:get/get.dart';

class ConfirmDthPage extends StatefulWidget {
  const ConfirmDthPage({super.key});

  @override
  State<ConfirmDthPage> createState() => _ConfirmDthPageState();
}

class _ConfirmDthPageState extends State<ConfirmDthPage> {
  late final DthController controller;
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  late String productdetid;

  late final Map<String, dynamic> args;

  @override
  void initState() {
    super.initState();
    controller = Get.find<DthController>();
    args = Get.arguments ?? {};

    final isFromTranactionPage = args['isFromTranactionPage'] ?? false;
    final String pId = args['productdetid']?.toString() ?? '';

    if (isFromTranactionPage && pId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.getconfirmdth(pId);
      });
    }
  }

  String get paymentStatus => args['paymentStatus'] ?? '';
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
    final String customerId = args['customerId'] ?? '';
    final String selectedAmount = args['amount']?.toString() ?? '';

    AppLogger.debugPrint("========== Confirm DTH ==========");
    AppLogger.debugPrint("Arguments: $args");
    AppLogger.debugPrint("Customer ID: $customerId");
    AppLogger.debugPrint("Amount: $selectedAmount");
    AppLogger.debugPrint("Product ID: ${args['productdetid']}");

    AppLogger.debugPrint("SELECTED AMOUNT => $selectedAmount");

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    AppLogger.logError(args.toString());

    return Obx(() {
      final confirmData = controller.confirmdth.value?.data;
      final isFromTranactionPage = args['isFromTranactionPage'] ?? false;

      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      if (confirmData == null && !isFromTranactionPage) {
        return const Scaffold(body: Center(child: Text("No Data Found")));
      }

      final String productName =
          confirmData?.productName ?? args['operator'] ?? '';
      final String logoUrl = confirmData?.logo ?? args['logo'] ?? '';

      final String availableBalanceStr =
          confirmData?.availableBalance ?? args['availableBalance'] ?? '0';
      final String transactionAmountStr = selectedAmount.isNotEmpty
          ? selectedAmount
          : (confirmData?.transactionAmount ?? args['amount'] ?? "0")
                .toString();

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

      final String commissionRaw =
          confirmData?.commission ?? args['commission'] ?? '0';
      final String commissionType = confirmData?.commissiontype ?? "Fixed";

      final double transactionAmount = parsedTransaction;

      final double commissionValue =
          double.tryParse(commissionRaw.replaceAll(RegExp(r'[^0-9.]'), '')) ??
          0.0;
      AppLogger.debugPrint("===== COMMISSION DEBUG =====");
      AppLogger.debugPrint("Transaction Amount: $transactionAmountStr");
      AppLogger.debugPrint("Commission Raw: $commissionRaw");
      AppLogger.debugPrint("Commission Type: $commissionType");
      AppLogger.debugPrint("Parsed Transaction: $transactionAmount");
      AppLogger.debugPrint("Parsed Commission: $commissionValue");
      AppLogger.debugPrint(confirmData?.toJson().toString() ?? "null");

      double commissionAmount = 0.0;
      String commissionStr = "0";

      if (commissionType.toLowerCase() == "percentage" ||
          commissionType.toLowerCase() == "percent") {
        commissionAmount = (transactionAmount * commissionValue) / 100;
        commissionStr = commissionAmount.toStringAsFixed(2);
      } else {
        commissionAmount = commissionValue;
        commissionStr = commissionAmount.toStringAsFixed(2);
      }
      final String remainingBalanceStr =
          (parsedAvailable - parsedTransaction + commissionAmount)
              .toStringAsFixed(2);

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

                  // ===== Transaction summary card =====
                  Container(
                    padding: EdgeInsets.all(15.w),
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
                                width: 60.w,
                                height: 30.h,
                                alignment: Alignment.centerRight,
                                child: logoUrl.isNotEmpty
                                    ? Image.network(
                                        logoUrl,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.image_not_supported,
                                              );
                                            },
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),

                        _buildDetailRow(
                          context,
                          'Payment Status',
                          paymentStatus,
                          valueColor:
                              paymentStatus.toLowerCase() == "paid" ||
                                  paymentStatus.toLowerCase() == "received"
                              ? const Color(0xFF0DB561)
                              : Colors.red,
                        ),

                        _buildDetailRow(
                          context,
                          'Transaction No',
                          customerId,
                          valueColor: isDark ? Colors.white : Colors.black,
                        ),

                        _buildDetailRow(
                          context,
                          'Available Balance',
                          availableBalanceStr.currencyIndian,
                          valueColor: const Color(0xFF314CFF),
                        ),

                        _buildDetailRow(
                          context,
                          'Transaction Amount',
                          transactionAmountStr.currencyIndian,
                          valueColor: Colors.red,
                        ),

                        _buildDetailRow(
                          context,
                          'Commission',
                          commissionStr.currencyIndian,
                          valueColor: const Color(0xFF00C261),
                        ),

                        _buildDetailRow(
                          context,
                          'Remaining Balance',
                          remainingBalanceStr.currencyIndian,
                          valueColor: const Color(0xFF314CFF),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ===== Transaction detail input card =====
                  Container(
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
                          'For Transaction Detail',
                          true,
                        ),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          context,
                          'Enter Whatsapp no',
                          controller: whatsappController,
                          // Note: DTH page did not import SvgPicture or asset, but keeping behavior similar without prefixIcon if it's missing, let's leave it as plain.
                          // Wait, does confirm_dth have SvgPicture? Let's assume it doesn't and skip prefixIcon to prevent errors, or maybe it does?
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
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ===== Warning note =====
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
                          "Note: Wrong recharge amount is not refundable",
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
                  // ===== Bottom action buttons (side by side) =====
                  Row(
                    children: [
                      Expanded(
                        child: _pillButton(
                          title: "Customer Confirmation",
                          color: const Color(0xFF0B1440),
                          onTap: () {
                            if (amountController.text.trim().isEmpty) {
                              CustomToast.error("Please enter amount");
                              return;
                            }

                            final entered =
                                double.tryParse(
                                  selectedAmount.trim().replaceAll(
                                    RegExp(r'[^0-9.]'),
                                    '',
                                  ),
                                ) ??
                                0.0;
                            final reEntered =
                                double.tryParse(
                                  amountController.text.trim().replaceAll(
                                    RegExp(r'[^0-9.]'),
                                    '',
                                  ),
                                ) ??
                                0.0;

                            if (entered != reEntered) {
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
                                "commission": commissionStr,
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Obx(
                          () => _pillButton(
                            title: controller.isRechargeLoading.value
                                ? "Processing..."
                                : "Pay Now",
                            color: const Color(0xFF1CACC2),
                            isLoading: controller.isRechargeLoading.value,
                            onTap: controller.isRechargeLoading.value
                                ? null
                                : () async {
                                    if (amountController.text.trim().isEmpty) {
                                      CustomToast.error("Please enter amount");
                                      return;
                                    }

                                    final entered =
                                        double.tryParse(
                                          selectedAmount.trim().replaceAll(
                                            RegExp(r'[^0-9.]'),
                                            '',
                                          ),
                                        ) ??
                                        0.0;
                                    final reEntered =
                                        double.tryParse(
                                          amountController.text
                                              .trim()
                                              .replaceAll(
                                                RegExp(r'[^0-9.]'),
                                                '',
                                              ),
                                        ) ??
                                        0.0;

                                    if (entered != reEntered) {
                                      CustomToast.error(
                                        "Entered amount does not match the transaction amount",
                                      );
                                      return;
                                    }

                                    final success = await controller
                                        .dthrecharge(
                                          args['productdetid'].toString(),
                                          customerId,
                                          amountController.text.trim(),
                                          convertedPaymentStatus,
                                          commissionStr,
                                        );

                                    final rechargeData =
                                        controller.rechargeResponse.value;

                                    if (rechargeData != null) {
                                      final apiData = rechargeData.response;

                                      if (success) {
                                        Get.to(
                                          () => DthSuccessPage(
                                            productName: productName,
                                            operatorLogo: logoUrl,
                                            rechargeId:
                                                rechargeData.transactionId
                                                    ?.toString() ??
                                                "",

                                            operatorInitial:
                                                productName.isNotEmpty
                                                ? productName[0]
                                                : "J",
                                            operatorColor: Colors.red,

                                            transactionNo:
                                                apiData?.mobileNo ?? customerId,
                                            rechargeAmount:
                                                (apiData?.amount?.toString() ??
                                                        amountController.text)
                                                    .currencyIndian,
                                            transactionId:
                                                rechargeData
                                                    .transactionDetails
                                                    ?.txnId ??
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
                                            productName: productName,
                                            operatorInitial:
                                                productName.isNotEmpty
                                                ? productName[0]
                                                : "J",
                                            operatorColor: Colors.red,
                                            transactionNo:
                                                apiData?.mobileNo ?? customerId,
                                            rechargeAmount:
                                                (apiData?.amount?.toString() ??
                                                        amountController.text)
                                                    .currencyIndian,
                                            transactionId:
                                                rechargeData
                                                    .transactionDetails
                                                    ?.txnId ??
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
                    ],
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      );
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
            color: isDark ? Colors.white70 : Colors.black,
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
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

Widget _buildInputLabel(
  BuildContext context,
  String label, [
  bool isOptionOrNot = false,
]) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

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
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          if (isOptionOrNot)
            TextSpan(
              text: " (Optional)",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white70 : Colors.black54,
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
      color: isDark ? AppColors.darkplceholder : Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(
        color: isHighlighted
            ? AppColors.darktextclr
            : (isDark ? Colors.white24 : const Color(0xFFE0E0E0)),
        width: 1,
      ),
    ),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.number,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hint,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    ),
  );
}
