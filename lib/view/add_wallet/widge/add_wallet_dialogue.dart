import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_wallet_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AddWalletPopup extends StatelessWidget {
  final String amount;
  final String url;

  final String? phonepeLink;
  final String txtionId;

  const AddWalletPopup({
    super.key,
    required this.amount,
    required this.url,
    required this.txtionId,
    required this.phonepeLink,
  });

  static const MethodChannel _upiChannel = MethodChannel(
    'com.paylink.retailor/upi_choose',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ----------------------------------------------------------
              // Header
              // ----------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),

                  Text(
                    "Account Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      final controller =
                          Get.find<AddWalletController>();

                      controller.stopTimer();
                      controller.amountController.clear();

                      Get.back();

                      await controller.getWalletHistory();
                    },
                    child: const Icon(
                      Icons.cancel,
                      size: 24,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ----------------------------------------------------------
              // QR Code
              // ----------------------------------------------------------
              Container(
                width: 220,
                height: 220,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: QrImageView(
                    data: url,
                    version: QrVersions.auto,
                    size: 220,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ----------------------------------------------------------
              // Amount
              // ----------------------------------------------------------
              SizedBox(
                width: 270,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Amount",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkbgBlack
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        amount.currencyIndian,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ----------------------------------------------------------
              // Expiry Timer
              // ----------------------------------------------------------
              Obx(() {
                final controller =
                    Get.find<AddWalletController>();

                final minutes =
                    (controller.remainingSeconds.value ~/ 60)
                        .toString()
                        .padLeft(2, '0');

                final seconds =
                    (controller.remainingSeconds.value % 60)
                        .toString()
                        .padLeft(2, '0');

                return Text(
                  "Expiry: $minutes:$seconds",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),

              const SizedBox(height: 20),

              // ----------------------------------------------------------
              // QR Code Instruction
              // ----------------------------------------------------------
              const Text(
                "Note: Please scan this QR code and add the amount.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// Open UPI Payment
// ----------------------------------------------------------------------
Future<void> openUpiPayment(String paymentUrl) async {
  final uri = Uri.parse(paymentUrl);

  AppLogger.debugPrint("UPI URL = $paymentUrl");

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    CustomToast.error("No UPI app installed");
  }
}

// ----------------------------------------------------------------------
// Convert UPI URL
// ----------------------------------------------------------------------
String convertToStandardUpiUrl(String customUrl) {
  try {
    final uri = Uri.parse(customUrl);

    if (uri.hasQuery) {
      return 'upi://pay?${uri.query}';
    }

    return customUrl;
  } catch (e) {
    debugPrint("Error converting UPI URL: $e");
    return customUrl;
  }
}