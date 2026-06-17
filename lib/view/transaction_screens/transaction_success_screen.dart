import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/transaction_screens/widget/transaction_card.dart';

enum TransactionStatus {
  success,
 pending,
 failed,
}

class TransactionScreen extends GetView<TransReportController> {
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

      appBar: CommonAppBar(
        title:title,
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
      : AppColors.darkplceholder,
  borderRadius: BorderRadius.circular(10),
  border: theme.brightness == Brightness.light
      ? Border.all(
          color: const Color(0xFFB5D4F4),
        )
      : null,
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

          /// INNER FIELD BORDER
          border: Border.all(
            color: theme.brightness == Brightness.light
                ? const Color(0xFFD6D6D6)
                : const Color.fromARGB(255, 159, 159, 159),
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Select Credit Type",
              style: TextHelper.max1.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
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
              color: theme.colorScheme.onSurface,
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
            Divider(
  color: Theme.of(context).brightness == Brightness.light
      ? Colors.black12
      : Colors.white24,
),
              const SizedBox(height: 15),
            /// TRANSACTION LIST
           Expanded(
  child: Obx(() {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.transreportList.isEmpty) {
      return const Center(
        child: Text("No Data Found"),
      );
    }

    return ListView.builder(
      itemCount: controller.transreportList.length,
      itemBuilder: (context, index) {
        return TransactionCard(
          data: controller.transreportList[index],
        );
      },
    );
  }),
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

      /// FIELD BORDER
      border: Border.all(
        color: theme.brightness == Brightness.light
            ? const Color(0xFFD6D6D6)
            : const Color.fromARGB(255, 159, 159, 159),
      ),
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
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    ),
  );
}
}