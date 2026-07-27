import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/wallet-credit/widget/wallet_credit_filter.dart';

class WalletCreditScreen extends StatelessWidget {
  const WalletCreditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: "Wallet Credit"),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

        child: Column(
          children: [
            /// 🔹 Filter Box
            const WalletCreditFilterWidget(),

            const SizedBox(height: 16),

            Divider(
              color:  AppColors.darktextclr.withValues(alpha: 0.5),
            ),

            const SizedBox(height: 16),

            /// 🔹 List
             Expanded(
              child: ListView(
                children: [
                  _WalletCreditCard(isDashed: false),

                  SizedBox(height: 10),

                  _WalletCreditCard(isDashed: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Date Field
class _DateField extends StatelessWidget {
  final String hint;
  final TextStyle? style;

  const _DateField({
    required this.hint,
  }) : style = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light
              ? Colors.white
              : theme.colorScheme.surface,

          borderRadius: BorderRadius.circular(7),

          border: Border.all(
            color: theme.brightness == Brightness.light
                ? const Color(0xFFB5D4F4)
                : theme.colorScheme.outline,
          ),
        ),

        child: Text(
          hint,

          style: style?.copyWith(
                color:
                    theme.colorScheme.onSurfaceVariant,
              ) ??
              TextStyle(
                fontSize: 12,
                color:
                    theme.colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}

/// 🔹 Wallet Credit Card
class _WalletCreditCard extends StatelessWidget {
  final bool isDashed;

  const _WalletCreditCard({
    required this.isDashed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.background
            : theme.colorScheme.surfaceContainer,

        borderRadius: BorderRadius.circular(12),

        border: theme.brightness == Brightness.dark
            ? Border.all(
                color: theme.colorScheme.outline,
              )
            : null,
      ),

      child: Column(
        children: [
          /// 🔹 Top Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "Transaction ID: TXN6453564",

                style: TextHelper.max1.copyWith(
                  color:  AppColors.darktextclr,
                ),
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,

                children: [
                  Text(
                    "Date & Time:",

                    style: TextHelper.max1.copyWith(
                      color: theme
                          .colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "2026-11-29 14:38:43",

                    style: TextHelper.max1.copyWith(
                      color: theme
                          .colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          Divider(
            color: theme.colorScheme.outline,
          ),

          const SizedBox(height: 8),

          /// 🔹 Bottom Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    "Credit Type",

                    style: TextHelper.max1.copyWith(
                      color: theme
                          .colorScheme.onSurfaceVariant,
                    ),
                  ),

                  Text(
                    "Type",

                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color:
                          theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,

                children: [
                  Text(
                    "Amount",

                    style: TextHelper.max1.copyWith(
                      color: theme
                          .colorScheme.onSurfaceVariant,
                    ),
                  ),

                  Text(
                    "₹ 500.00",

                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color:
                          theme.colorScheme.onSurface,
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