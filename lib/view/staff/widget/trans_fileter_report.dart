import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class TransactionFilterWidget extends StatefulWidget {
  final Function(
    String? status,
    String? fromDate,
    String? toDate,
    String? search,
    String? prdtId,
  )?
  onFilter;

  const TransactionFilterWidget({super.key, this.onFilter});

  @override
  State<TransactionFilterWidget> createState() =>
      _TransactionFilterWidgetState();
}

class _TransactionFilterWidgetState extends State<TransactionFilterWidget> {
  String? selectedStatus;
  DateTime? fromDate;
  DateTime? toDate;
  String? prd;
  final TextEditingController _searchController = TextEditingController();

  void _triggerFilter() {
    if (widget.onFilter != null) {
      String? fromStr = fromDate != null
          ? "${fromDate!.year}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}"
          : null;
      String? toStr = toDate != null
          ? "${toDate!.year}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}"
          : null;
      widget.onFilter!(
        selectedStatus,
        fromStr,
        toStr,
        _searchController.text.trim().isNotEmpty
            ? _searchController.text.trim()
            : null,
        prd,
      );
    }
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != fromDate) {
      setState(() {
        fromDate = picked;
      });
      _triggerFilter();
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != toDate) {
      setState(() {
        toDate = picked;
      });
      _triggerFilter();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.find<TransReportController>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: Obx(() {
                  final productList = controller.producttype.value?.data ?? [];

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkplceholder : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkFilterBorder
                            : AppColors.totalborde2,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,

                        value:
                            productList.any(
                              (e) =>
                                  e.id.toString() ==
                                  controller.selectedProductId.value,
                            )
                            ? controller.selectedProductId.value
                            : null,

                        hint: Text(
                          "Select",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                        ),

                        items: productList.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(item.name ?? ""),
                          );
                        }).toList(),

                        onChanged: (value) {
                          if (value == null) return;

                          prd = value;
                        },
                      ),
                    ),
                  );
                }),
              ),

              /// SELECT STATUS (Dropdown)
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkplceholder : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkFilterBorder
                          : AppColors.totalborde2,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedStatus,
                      hint: Text(
                        "Select Status",
                        style: TextHelper.max1.copyWith(fontSize: 12),
                      ),
                      dropdownColor: isDark
                          ? AppColors.darkplceholder
                          : Colors.white,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: isDark
                            ? AppColors.textclr
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: "success",
                          child: Text("Success"),
                        ),
                        DropdownMenuItem(
                          value: "pending",
                          child: Text("Pending"),
                        ),
                      ],
                      onChanged: (val) {
                        setState(() {
                          selectedStatus = val;
                        });
                        _triggerFilter();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// DATE FIELD
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectFromDate(context),
                  child: _DateField(
                    hint: fromDate != null
                        ? "${fromDate!.year}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}"
                        : "Start Date",
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
                child: InkWell(
                  onTap: () => _selectToDate(context),
                  child: _DateField(
                    hint: toDate != null
                        ? "${toDate!.year}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}"
                        : "End Date",
                    style: TextHelper.max1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// SEARCH FIELD
          TextField(
            controller: _searchController,
            style: TextStyle(color: theme.colorScheme.onSurface),
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _triggerFilter(),
            decoration: InputDecoration(
              prefixIconConstraints: const BoxConstraints(
                maxWidth: 50,
                maxHeight: 50,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
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
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: _triggerFilter,
              ),
              hintText: "Search",
              hintStyle: TextHelper.max1.copyWith(
                color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
              ),
              filled: true,
              fillColor: isDark ? AppColors.darkplceholder : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: theme.colorScheme.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ],
      ),
    );
  }
}

/// DATE FIELD
class _DateField extends StatelessWidget {
  final String hint;
  final TextStyle? style;

  const _DateField({required this.hint, this.style});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: isDark ? AppColors.darkFilterBorder : AppColors.totalborde2,
        ),
      ),
      child: Text(
        hint,
        style:
            style?.copyWith(
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
