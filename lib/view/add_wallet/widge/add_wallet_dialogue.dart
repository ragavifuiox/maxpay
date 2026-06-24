import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// TITLE
            /// TITLE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// LEFT SIDE TITLE
                Text("Account Details", style: TextHelper.max10(context)),

                /// RIGHT SIDE ICONS
                Row(
                  children: [
                    /// SHARE ICON
                    IconButton(
                      onPressed: () {
                        // share function
                      },
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
              ],
            ),

            const SizedBox(height: 10),

            /// QR IMAGE
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
                errorStateBuilder: (cxt, err) {
                  return const Center(
                    child: Text(
                      "Uh oh! Something went wrong...",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            /// AMOUNT
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Amount", style: TextHelper.max12(context)),
            ),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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

            /// TIMER
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
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              );
            }),

            const SizedBox(height: 14),

            /// INFO TEXT
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
    );
  }
}
