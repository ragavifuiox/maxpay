import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class AddWalletPopup extends StatelessWidget {
  const AddWalletPopup({super.key});

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
    Text(
      "Account Details",
      style: TextHelper.max10(context),
    ),

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
              child: Image.asset(
                AssetImages.qrCode,
                height: 220,
                width: 220,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 18),

            /// AMOUNT
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Amount",
                style: TextHelper.max12(context),
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
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "₹ 10,000.00",
                style: TextHelper.max12(context),
              ),
            ),

            const SizedBox(height: 12),

            /// TIMER
            const Text(
              "Expiry: 04:59",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}