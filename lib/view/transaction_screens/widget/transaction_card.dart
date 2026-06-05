import 'package:flutter/material.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';


class TransactionCard extends StatelessWidget {
  final Color bgColor;
  final TransactionStatus status;

  const TransactionCard({
    super.key,
    required this.bgColor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isSuccess = status == TransactionStatus.success;
    final bool isPending = status == TransactionStatus.pending;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transaction ID: TXN6453564",
                style: TextStyle(
                  fontSize: 11,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date & Time:",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    "29-11-2026 07:38:43 PM",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
           Divider(
  color: Theme.of(context).brightness == Brightness.light
      ? Colors.black12
      : Colors.white24,
),
              const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Jio",
                  style: TextStyle(
                   color:
            Theme.of(context).brightness ==
                    Brightness.dark
                ? Colors.black
                : Colors.black,
                    
                
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jio",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color:
            Theme.of(context).brightness ==
                    Brightness.dark
                ? Colors.black
                : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Number: 9865647823",
                      style: TextStyle(
                        fontSize: 11,
                        color:
            Theme.of(context).brightness ==
                    Brightness.dark
                ? Colors.black
                : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
             const Divider(
              color: Colors.black12,
             ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹ 365.00",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color:
            Theme.of(context).brightness ==
                    Brightness.dark
                ? Colors.black
                : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isSuccess
                          ? Colors.green
                          : isPending
                              ? Colors.orange
                              : Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isSuccess
                          ? "Success"
                          : isPending
                              ? "Processing"
                              : "Failed",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (!isPending)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                customButton(
                  text: isSuccess ? "Dispute" : "View",
                  color: isSuccess ? Colors.red : Colors.blue,
                ),

                const SizedBox(width: 8),

                customButton(
                  text: isSuccess ? "View" : "Resend",
                  color: isSuccess ? Colors.blue : Colors.green,
                ),

                if (isSuccess) ...[
                  const SizedBox(width: 8),

                  customButton(
                    text: "Share",
                    color: Colors.green,
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget customButton({
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}