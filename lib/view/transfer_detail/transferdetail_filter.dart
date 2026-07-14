import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

import 'package:maxpay/view/transfer_detail/wallet_trnasfer.dart';

class TransferdetailFilter extends StatelessWidget {
 
  final TransferFilterType? selectedFilter;

 
  final ValueChanged<TransferFilterType?> onFilterChanged;


  final ValueChanged<String>? onSearchChanged;

  const TransferdetailFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    this.onSearchChanged,
  });

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
              : AppColors.totalborde2.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),

          /// DATE FIELD
          Row(
            children: [
              _DateField(hint: "DD.MM.YYYY", style: TextHelper.max1),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              _DateField(hint: "DD.MM.YYYY", style: TextHelper.max1),
            ],
          ),

          const SizedBox(height: 8),

          /// SEARCH FIELD
          TextField(
            style: TextStyle(color: theme.colorScheme.onSurface),
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
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

          const SizedBox(height: 8),

          /// FILTER TYPE DROPDOWN ("Reverse" / "Wallet Transfer")
          /// This replaces the old static "Select" row with a real,
          /// working dropdown wired back to the parent via onFilterChanged.
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<TransferFilterType>(
              value: selectedFilter,
              isExpanded: true,
              icon: Icon(
                Icons.chevron_right,
                color: isDark
                    ? AppColors.textclr
                    : theme.colorScheme.onSurfaceVariant,
                size: 18,
              ),
              style: TextHelper.max1.copyWith(
                color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
              ),
              dropdownColor: isDark ? AppColors.darkplceholder : Colors.white,
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? AppColors.darkplceholder : Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
              ),
              hint: Text(
                "Select",
                style: TextHelper.max1.copyWith(
                  color: isDark ? AppColors.textclr : AppColors.clrTextgrey,
                ),
              ),
              items: TransferFilterType.values
                  .map(
                    (type) => DropdownMenuItem<TransferFilterType>(
                      value: type,
                      child: Text(type.label),
                    ),
                  )
                  .toList(),
              onChanged: onFilterChanged,
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

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      ),
    );
  }
}