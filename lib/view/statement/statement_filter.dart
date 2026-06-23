import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/statement_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class StatementFilter extends GetView<StatementController> {
  const StatementFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GetBuilder<StatementController>(
      builder: (controller) {
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
          child: Column(
            children: [
              /// DROPDOWN
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkplceholder
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkFilterBorder
                        : AppColors.totalborde2,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child:DropdownButton<String>(
  isExpanded: true,
  value: controller.selectedtype.value.isEmpty
      ? null
      : controller.selectedtype.value,

  hint: const Text("Payment Type"),

  items: controller.Type.map((item) {
    return DropdownMenuItem<String>(
      value: item,
      child: Text(item),
    );
  }).toList(),

  onChanged: (value) {
   controller.setType(value ?? "");
controller.statement();// 🔥 MUST SET THIS;
     debugPrint(
    "Selected Payment Type => ${controller.selectedtype.value}",
  );

     controller.statement();
  },
)
                ),
              ),

              const SizedBox(height: 10),

              /// DATE
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          controller.selectFromDate(context),
                      child: _DateField(
                        hint: controller.fromDate.isEmpty
                            ? "Start Date"
                            : controller.fromDate,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Icon(
                    Icons.arrow_forward,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          controller.selectToDate(context),
                      child: _DateField(
                        hint: controller.toDate.isEmpty
                            ? "End Date"
                            : controller.toDate,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// SEARCH
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.onSearch(value);
                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      AssetImages.search,
                      colorFilter: ColorFilter.mode(
                        isDark
                            ? AppColors.textclr
                            : theme.colorScheme.onSurfaceVariant,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  hintText: "Enter Mobile Number",
                  hintStyle: TextHelper.max1.copyWith(
                    color: isDark
                        ? AppColors.textclr
                        : AppColors.clrTextgrey,
                  ),
                  filled: true,
                  fillColor: isDark
                      ? AppColors.darkplceholder
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DateField extends StatelessWidget {
  final String hint;

  const _DateField({required this.hint});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
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
        style: TextHelper.max1.copyWith(
          color: isDark
              ? AppColors.textclr
              : theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}