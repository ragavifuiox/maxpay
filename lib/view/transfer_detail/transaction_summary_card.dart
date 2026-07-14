import 'package:flutter/material.dart';
import 'package:maxpay/view/transfer_detail/wallet_trnasfer.dart';

/// Pink "Wallet Reverse" banner when Reverse is selected,
/// teal "Wallet Transfer" banner when Wallet Transfer is selected.
class TransferSummaryCard extends StatelessWidget {
  final TransferFilterType? filterType;
  final double amount;

  const TransferSummaryCard({
    super.key,
    required this.filterType,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final isReverse = filterType == TransferFilterType.reverse;

    final Color backgroundColor =
        isReverse ? const Color(0xFFFFE4E8) : const Color(0xFF15879D);

    final Color textColor = isReverse ? const Color(0xFFEE0023) : Colors.white;

    final String title = isReverse ? "Wallet Reverse" : "Wallet Transfer";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}