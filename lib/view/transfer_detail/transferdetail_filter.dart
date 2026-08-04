import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/wallet_trnasfer_detail_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';

import 'package:maxpay/view/transfer_detail/wallet_trnasfer.dart';

class TransferdetailFilter extends StatelessWidget {
  final TransferFilterType? selectedFilter;
  final ValueChanged<TransferFilterType?> onFilterChanged;
  final ValueChanged<String>? onSearchChanged;

  TransferdetailFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    this.onSearchChanged,
  });

  final WalletTrnasferDetailController controller =
      Get.find<WalletTrnasferDetailController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          DropdownButtonFormField<TransferFilterType>(
            initialValue: selectedFilter,

            hint: const Text(
              "Transfer Type",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            isExpanded: true,

            icon: const Icon(Icons.keyboard_arrow_down, size: 30),

            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? AppColors.darkplceholder : Colors.white,

              contentPadding: const EdgeInsets.symmetric(horizontal: 18),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),
            ),

            items: TransferFilterType.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.label,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
                .toList(),

            onChanged: (value) {
              if (value == null) return;

              onFilterChanged(value);

              controller.selectedFilter.value = value;

              controller.transactionType.value = value.label;

              // API CALL IMMEDIATELY
              controller.getWalletTransferDetail(
                search: controller.search.value,
                startDate: controller.fromDate,
                endDate: controller.toDate,
                transferType: controller.transactionType.value,
              );
            },
          ),
          const SizedBox(height: 14),

          /// DATE RANGE
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectFromDate(context),
                  child: AbsorbPointer(
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: controller.fromDateController,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "DD.MM.YYYY",
                          hintStyle: TextStyle(
                            color: isDark
                                ? AppColors.textclr
                                : theme.colorScheme.onSurfaceVariant,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: isDark
                              ? AppColors.darkplceholder
                              : Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: isDark
                                  ? AppColors.darkFilterBorder
                                  : AppColors.totalborde2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: isDark
                                  ? AppColors.darkFilterBorder
                                  : AppColors.totalborde2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(Icons.arrow_forward, color: AppColors.clrPrimary),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectToDate(context),
                  child: AbsorbPointer(
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: controller.toDateController,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "DD.MM.YYYY",
                          hintStyle: TextStyle(
                            color: isDark
                                ? AppColors.textclr
                                : theme.colorScheme.onSurfaceVariant,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: isDark
                              ? AppColors.darkplceholder
                              : Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: isDark
                                  ? AppColors.darkFilterBorder
                                  : AppColors.totalborde2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// TRANSACTION TYPE
          const SizedBox(height: 14),

          /// SEARCH BOX
          TextField(
            onChanged: (value) {
              controller.search.value = value;

              if (onSearchChanged != null) {
                onSearchChanged!(value);
              }
            },
            decoration: InputDecoration(
              hintText: "Search",

              hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),

              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  AssetImages.search,
                  width: 12,
                  height: 12,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              filled: true,
              fillColor: isDark ? AppColors.darkplceholder : Colors.white,

              contentPadding: const EdgeInsets.symmetric(horizontal: 16),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isDark
                      ? AppColors.darkFilterBorder
                      : AppColors.totalborde2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
