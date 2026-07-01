import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/add_wallet_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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

    final upiUri = Uri.tryParse(url.trim());
    if (upiUri == null) {
      Get.snackbar(
        "Alert",
        "Invalid UPI payment link",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final bool isOpened;
    try {
      isOpened = await launchUrl(upiUri, mode: LaunchMode.externalApplication);
    } catch (_) {
      Get.snackbar(
        "Alert",
        "No UPI app found. Please install GPay, PhonePe, Paytm, or any UPI app.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isOpened) {
      Get.snackbar(
        "Alert",
        "No UPI app found. Please install GPay, PhonePe, Paytm, or any UPI app.",
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
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.85, // 👈 important fix
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Account Details", style: TextHelper.max10(context)),
                  IconButton(
                    onPressed: _openUpiApp,
                    icon: SvgPicture.asset(
                      AssetImages.shareSvg,
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        Colors.green,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: QrImageView(
                  data: url,
                  version: QrVersions.auto,
                  size: 220,
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Amount", style: TextHelper.max12(context)),
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  amount.currencyIndian,
                  style: TextHelper.max12(context),
                ),
              ),

              const SizedBox(height: 12),

              Obx(() {
                final controller = Get.find<AddWalletController>();
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
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),

              const SizedBox(height: 14),

              Text(
                "Note: It may take a few seconds to update the status after payment.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
