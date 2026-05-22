import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class CashbackScreen extends StatelessWidget {
  const CashbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : theme.scaffoldBackgroundColor,

      /// ✅ Global AppBar
      appBar: const CommonAppBar(
        title: "Cash Back",
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// 🔵 Filter Box
            Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? AppColors.background
                    : theme.colorScheme.surfaceContainer,

                borderRadius: BorderRadius.circular(14),

                border: theme.brightness == Brightness.dark
                    ? Border.all(
                        color: theme.colorScheme.outline,
                      )
                    : null,
              ),

              /// Search / Dropdown
              child: Container(
                height: 52,

                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),

                decoration: BoxDecoration(
                  color:
                      theme.brightness == Brightness.light
                          ? Colors.white
                          : theme.colorScheme.surface,

                  borderRadius: BorderRadius.circular(10),

                  border: Border.all(
                    color: theme.colorScheme.outline,
                  ),
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      "Select Product Type",

                      style: TextHelper.max2.copyWith(
                        color:
                            theme.colorScheme.onSurface,
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,

                      color: theme.colorScheme
                          .onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// Cashback List
             Expanded(
              child: ListView(
                children: [
                  CashbackTile(
                    cashback: "5.0%",
                    cashbackColor: Colors.green,
                  ),

                  SizedBox(height: 12),

                  CashbackTile(
                    cashback: "-5.0%",
                    cashbackColor: Colors.red,
                  ),

                  SizedBox(height: 12),

                  CashbackTile(
                    cashback: "₹ 5.00",
                    cashbackColor: Colors.green,
                  ),

                  SizedBox(height: 12),

                  CashbackTile(
                    cashback: "₹ -5.00",
                    cashbackColor: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CashbackTile extends StatelessWidget {
  final String cashback;
  final Color cashbackColor;

  const CashbackTile({
    super.key,
    required this.cashback,
    required this.cashbackColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),

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

      child: Row(
        children: [
          /// Jio Logo
          Container(
            height: 42,
            width: 42,

            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),

            alignment: Alignment.center,

            child: const Text(
              "Jio",

              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// Name
          Expanded(
            child: Text(
              "Jio",

              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),

          /// Cashback
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,

            children: [
              Text(
                "Cashback",

                style: TextHelper.max2.copyWith(
                  color:
                      theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                cashback,

                style: TextStyle(
                  color: cashbackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}