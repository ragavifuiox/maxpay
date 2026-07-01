import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/statement_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/extension.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/statement/statement_filter.dart';

class StatementScreen extends GetView<StatementController> {
  const StatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Statement"),
      body: Column(
        children: [
          /// FILTER
          const StatementFilter(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),

          SizedBox(height: 8.h),

          /// LIST
          Expanded(
            child: Obx(() {
              final controller = Get.find<StatementController>();

              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.statementlist.isEmpty) {
                return const Center(child: Text("No Data Found"));
              }

              return ListView.builder(
                itemCount: controller.statementlist.length,
                itemBuilder: (_, index) {
                  final item = controller.statementlist[index];

                  return _buildStatementCard(context, item, theme);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  /// CARD UI (same design, only data fixed)
  Widget _buildStatementCard(BuildContext context, item, ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? AppColors.darkplceholder
            : const Color(0xFFF6F7FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
         _row(
  "Date & Time",
  item.dateTime != null && item.dateTime!.isNotEmpty
      ? formatTransactionDate(item.dateTime!)
      : "-",
  theme,
),
          _divider(theme),

          _row("Description", item.description ?? "-", theme),
          _row("Transaction ID", item.transactionId ?? "-", theme),
          _row("Opening Balance", item.openingBalance ?? "-", theme),
          _row("Credit", item.credit ?? "0", theme, color: Colors.green),
          _row("Debit", item.debit ?? "0", theme, color: Colors.red),
          _row(
            "Closing Balance",
            item.closingBalance ?? "-",
            theme,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget _row(
    String label,
    String value,
    ThemeData theme, {
    Color? color,
    bool bold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextHelper.max6.copyWith(color: theme.colorScheme.onSurface),
          ),
          Text(
            value,
            style: TextHelper.max7.copyWith(
              color:
                  color ??
                  (theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Divider(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
    );
  }
}
