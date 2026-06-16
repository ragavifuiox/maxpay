import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

import 'package:get/get.dart';
import 'package:maxpay/controllers/dispute_controller.dart';

class Disputefilter extends GetView<DisputeController> {
  const Disputefilter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2.withValues(alpha: 0.1),
        ),
      ),
      child: GetBuilder<DisputeController>(
        builder: (controller) {
          return Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      controller.selectFromDate(context),
                  child: _DateField(
                    hint: controller.fromDate.isEmpty
                        ? "From Date"
                        : controller.fromDate,
                    style: TextHelper.max1,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.arrow_forward,
                size: 16,
                color: theme.colorScheme.primary,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      controller.selectToDate(context),
                  child: _DateField(
                    hint: controller.toDate.isEmpty
                        ? "To Date"
                        : controller.toDate,
                    style: TextHelper.max1,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// DATE FIELD
class _DateField extends StatelessWidget {
  final String hint;
  final TextStyle? style;

  const _DateField({
    required this.hint,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkplceholder
            : Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2,
        ),
      ),
      child: Text(
        hint,
        style: style?.copyWith(
              color: isDark
                  ? AppColors.textclr
                  : theme.colorScheme.onSurfaceVariant,
            ) ??
            TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.textclr
                  : theme.colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}