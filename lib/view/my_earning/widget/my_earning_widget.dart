import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/extension.dart';
import 'package:maxpay/core/data/model/my_earnings_model.dart';

class EarningsCard extends StatelessWidget {
  final EarningItem item;

  const EarningsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.background
            : const Color(0xFF2F3349),
        borderRadius: BorderRadius.circular(12),
        border: theme.brightness == Brightness.dark
            ? Border.all(color: const Color(0xFF3C3F52))
            : null,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time:",
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                item.commissionDate != null
                    ? formatTransactionDate(item.commissionDate!)
                    : "-",
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Divider(
            color: theme.brightness == Brightness.light
                ? Colors.black12
                : Colors.white24,
          ),

          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.background,
                child: ClipOval(
                  child:
                      (item.productLogo != null && item.productLogo!.isNotEmpty)
                      ? Image.network(
                          item.productLogo!,
                          width: 36,
                          height: 36,
                          fit: BoxFit.contain, // shows full logo
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image,
                              size: 20,
                              color: Colors.grey,
                            );
                          },
                        )
                      : const Icon(Icons.image, size: 20, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productType ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      " Amount : ₹${item.amount ?? "0"}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      item.mobile ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text(
                   
                  //   style: TextStyle(
                  //     fontSize: 11,
                  //     color: theme.colorScheme.onSurface,
                  //   ),
                  // ),

                  const SizedBox(height: 4),

                  Text(
                    "₹ ${item.commissionAmount ?? "0"}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
