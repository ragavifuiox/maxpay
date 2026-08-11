import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:maxpay/controllers/wallet_trnasfer_detail_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';

import 'package:maxpay/view/transfer_detail/wallet_trnasfer.dart';

class TransactionCard extends StatelessWidget {
  final WalletTransaction transaction;
  final WalletTrnasferDetailController controller =
      Get.find<WalletTrnasferDetailController>();
   TransactionCard({super.key, required this.transaction});

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  String _formatDateTime(DateTime dt) {
    return "${dt.year}-${_twoDigits(dt.month)}-${_twoDigits(dt.day)} "
        "${_twoDigits(dt.hour)}:${_twoDigits(dt.minute)}:${_twoDigits(dt.second)}";
  }

  @override
  Widget build(BuildContext context) {
    final isReverse = transaction.type == TransferFilterType.reverse;
    final typeColor =
        isReverse ? const Color(0xFFE5484D) : const Color(0xFF1E9E5A);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.background
            : const Color(0xFF2F3349),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Transaction ID: ${transaction.transactionId}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                "Date & Time:\n${_formatDateTime(transaction.dateTime)}",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _row(
            context,
            "Transaction Type",
            transaction.type.label,
            valueColor: typeColor,
            // Only Wallet Transfer rows get the icon next to the label.
            // showIcon: !isReverse,
          ),
          _row(context, "User Type", transaction.userType),
          _row(context, "User Name", transaction.userName),
          _row(context, "Reg.Mob No", transaction.regMobNo),
_row(
  context,
  "Transaction Amount",
  "₹${transaction.amount.toStringAsFixed(2)}",
  valueColor: typeColor,
  showIcon: !isReverse, // Show icon only for Wallet Transfer
),
        ],
      ),
    );
  }

  /// Shows the "Do you want to Reverse the amount?" confirmation popup.
  /// Tapping Submit closes the dialog AND navigates back from this screen.
  void _showReverseConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Do you want to Reverse the amount ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFE5484D),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "₹${transaction.amount.toStringAsFixed(2)}",
                            style: const TextStyle(
                    color: Color(0xFFE5484D),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.clrPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    // onPressed: () {
                    

                    //   Navigator.of(dialogContext).pop(); // close the dialog
                    //   Navigator.of(context).pop(); // go back from this screen
                    // },

                    onPressed: () async {
  await controller.staffWalletReverse(
    id: transaction.id.toString(), // Pass transaction id
  );

  Navigator.of(dialogContext).pop(); // Close dialog

  // If API is successful, go back
  if (controller.reverseResponse.value?.success == true) {
    Navigator.of(context).pop();
  }
},
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _row(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
    bool showIcon = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 170,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                // Icon sits right after the label, like in the reference design.
                // Tapping it opens the "Do you want to Reverse the amount?" confirmation.
               
              ],
            ),
          ),
          const Text(": ", style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
         Expanded(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: valueColor,
          fontFamily: 'Poppins',
        ),
      ),

      if (showIcon) ...[
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _showReverseConfirmationDialog(context),
          child: SvgPicture.asset(
            AssetImages.transfer,
            width: 18,
            height: 18,
            // colorFilter: ColorFilter.mode(
            //   valueColor ?? Colors.grey,
            //   BlendMode.srcIn,
            // ),
          ),
        ),
      ],
    ],
  ),
),
    ],
  ),
),
        ],
      ),
    );
  }
}