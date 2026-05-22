import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/view/transaction_screens/widget/transaction_card.dart';

enum TransactionStatus {
  success,
 pending,
 failed,
}

class TransactionScreen extends StatelessWidget {
  final TransactionStatus status;

  const TransactionScreen({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isSuccess = status == TransactionStatus.success;
    final bool isPending = status == TransactionStatus.pending;

    Color bgColor;
    String title;

    if (isSuccess) {
      bgColor = isDark
          ? const Color(0xFFE2F8E9)
          : const Color(0xFFE2F8E9);

      title = "Transaction Success";
    } else if (isPending) {
      bgColor = isDark
          ? const Color(0xFFFFF1DD)
          : const Color(0xFFFFF1DD);

      title = "Transaction Pending";
    } else {
      bgColor = isDark
          ? const Color(0xFFFFE4E6)
          : const Color(0xFFFFE4E6);

      title = "Transaction Failed";
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.colorScheme.onSurface,
            size: 18,
          ),
        ),

        title: Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(14),

        child: Column(
          children: [
            /// FILTER CONTAINER
            Container(
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? const Color(0xFFE3F0FB)
                    : theme.colorScheme.surfaceContainer,

                borderRadius: BorderRadius.circular(10),

                border: Border.all(
                  color: theme.brightness == Brightness.light
                      ? const Color(0xFFB5D4F4)
                      : Colors.grey,
                ),
              ),

              child: Column(
                children: [
                  /// SELECT CREDIT TYPE
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.light
      ? Colors.white
      : AppColors.darkplceholder,
                      borderRadius: BorderRadius.circular(8),

                     
                    ),

                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          "Select Credit Type",

                          style: TextHelper.max1.copyWith(
                            color:
                                theme.colorScheme.onSurface,
                          ),
                        ),

                        Icon(
                          Icons.chevron_right,
                          color: theme
                              .colorScheme.onSurfaceVariant,
                          size: 18,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// DATE FIELD
                  Row(
                    children: [
                      Expanded(
                        child: customField(
                          context,
                          hint: "DD/MM/YYYY",
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color:
                              theme.colorScheme.onSurface,
                        ),
                      ),

                      Expanded(
                        child: customField(
                          context,
                          hint: "DD/MM/YYYY",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// SEARCH FIELD
                  customField(
                    context,
                    hint: "Search",
                    prefix: Icons.search,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// TRANSACTION LIST
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TransactionCard(
                    bgColor: bgColor,
                    status: status,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customField(
    BuildContext context, {
    required String hint,
    IconData? prefix,
  }) {
    final theme = Theme.of(context);

    return Container(
      height: 45,

      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),

      decoration: BoxDecoration(
       color: theme.brightness == Brightness.light
      ? Colors.white
      : AppColors.darkplceholder,

        borderRadius: BorderRadius.circular(8),

        // border: Border.all(
        //   color: theme.brightness == Brightness.light
        //       ? const Color(0xFFB5D4F4)
        //       : theme.colorScheme.outline,
        // ),
      ),

      child: Row(
        children: [
          if (prefix != null) ...[
            Icon(
              prefix,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),

            const SizedBox(width: 8),
          ],

          Expanded(
            child: Text(
              hint,

              style: TextHelper.max1.copyWith(
                color:
                    theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}