import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_wallet_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddWalletPopup extends StatelessWidget {
  final String amount;
  final String url;
  final String txtionId;

  const AddWalletPopup({
    super.key,
    required this.amount,
    required this.url,
    required this.txtionId,
  });

  static const MethodChannel _upiChannel =
      MethodChannel('com.maxpay.app/upi_chooser');

  Future<void> _openUpiApp() async {
    if (url.trim().isEmpty) {
      Get.snackbar(
        "Alert",
        "UPI payment link is not available",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final bool? opened = await _upiChannel.invokeMethod<bool>(
        'openUpiChooser',
        {'url': url.trim()},
      );

      if (opened != true) {
        Get.snackbar(
          "Alert",
          "No UPI app found. Please install GPay, PhonePe, Paytm, or any UPI app.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on PlatformException catch (_) {
      Get.snackbar(
        "Alert",
        "No UPI app found. Please install GPay, PhonePe, Paytm, or any UPI app.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (_) {
      Get.snackbar(
        "Alert",
        "Something went wrong while opening UPI apps.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Select Button
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: _openUpiApp,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff18A7C9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Select",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          'assets/images/share-wal.svg',
                          width: 18,
                          height: 18,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// Title
              const Text(
                "Account Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 18),

              /// QR
              Container(
                width: 270,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
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

              /// Amount
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
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade300,
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

              /// Expiry
              Obx(() {
                final controller = Get.find<AddWalletController>();

                final minutes = (controller.remainingSeconds.value ~/ 60)
                    .toString()
                    .padLeft(2, '0');

                final seconds = (controller.remainingSeconds.value % 60)
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

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}