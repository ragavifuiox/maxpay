import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/credit_controller.dart';
import 'package:maxpay/controllers/wallet_credit_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/data/model/wallet_credit_model.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/wallet-credit/widget/wallet_credit_filter.dart';

class WalletCreditScreen extends GetView<WalletCreditController> {
  const WalletCreditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Wallet Credit",
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

        child: Column(
          children: [

            const WalletCreditFilter(),

            const SizedBox(height: 16),

            Divider(
  color: Theme.of(context).brightness == Brightness.light
      ? Colors.black12
      : Colors.white24,
),
const SizedBox(height: 16),
            Obx(
              () => Container(
                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),

                decoration: BoxDecoration(
                  color: AppColors.clrPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Column(
                  children: [

                    const Text(
                      "Total Credit",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                       "₹ ${controller.creditData.value?.data?.totalCredit?.toStringAsFixed(2) ?? "0.00"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// List
           Expanded(
  child: Obx(() {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.Searchcredit.isEmpty) {
      return const Center(
        child: Text("No Data Found"),
      );
    }

    return ListView.builder(
      itemCount: controller.Searchcredit.length,
      itemBuilder: (context, index) {
        final item = controller.Searchcredit[index];

        return _WalletCreditCard(
          data: item,
        );
      },
    );
  }),
)
          ],
        ),
      ),
    );
  }
}

/// Wallet Credit Card


class _WalletCreditCard extends StatelessWidget {
  final CreditData data;

  const _WalletCreditCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.background
            : const Color(0xFF2F3349),
        borderRadius: BorderRadius.circular(12),
        border: isDark
            ? Border.all(
                color: const Color(0xFF3C3F52),
              )
            : null,
      ),
      child: Column(
        children: [
          /// Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Transaction ID: ${data.transactionId ?? '-'}",
                  style: TextHelper.max1.copyWith(
                    color: isDark
                        ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                        : AppColors.darktextclr,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date & Time",
                    style: TextHelper.max1.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.createdAt ?? "-",
                    style: TextHelper.max1.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),
                ],
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

          /// Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Credit Type",
                    style: TextHelper.max1.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),
                  Text(
                    data.walletType ?? "-",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Amount",
                    style: TextHelper.max1.copyWith(
                      color: isDark
                          ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                          : AppColors.darktextclr,
                    ),
                  ),
                  Text(
                    "₹ ${data.amount ?? '0.00'}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
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
