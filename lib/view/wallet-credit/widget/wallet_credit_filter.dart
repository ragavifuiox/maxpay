import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class WalletCreditFilterWidget extends StatelessWidget {
  const WalletCreditFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return 
    Container(
      padding: const EdgeInsets.all(12),
     decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.lightbg2
            : theme.colorScheme.surfaceContainer,

        borderRadius: BorderRadius.circular(10),

        border: Border.all(
          color: AppColors.totalborde2.withValues(alpha: 0.1),
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
                  : theme.colorScheme.surface,

              borderRadius: BorderRadius.circular(8),

              border: Border.all(
                color: AppColors.totalborde2,
              ),
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  "Select Credit Type",

                  style: TextHelper.max1
                ),

                Icon(
                  Icons.chevron_right,
                  color:
                      theme.colorScheme.onSurfaceVariant,
                  size: 18,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          /// DATE FIELD
          Row(
            children: [
              _DateField(
                hint: "DD.MM.YYYY",
                style: TextHelper.max1,
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.arrow_forward,
                size: 16,
                color: theme.colorScheme.primary,
              ),

              const SizedBox(width: 8),

              _DateField(
                hint: "DD.MM.YYYY",
                style: TextHelper.max1,
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// SEARCH FIELD
          TextField(
            style: TextStyle(
              color: theme.colorScheme.onSurface,
            ),

            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  AssetImages.search,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              hintText: "Search",

              hintStyle: TextHelper.max1,
              filled: true,

              fillColor:
                  theme.brightness == Brightness.light
                      ? Colors.white
                      : theme.colorScheme.surface,

              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(7),

                borderSide: BorderSide(
                  color: AppColors.totalborde2,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(7),

                borderSide: BorderSide(
                  color: AppColors.totalborde2,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(7),

                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                ),
              ),

              contentPadding:
                  const EdgeInsets.symmetric(
                vertical: 0,
              ),
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

  const _DateField({
    required this.hint,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light
              ? Colors.white
              : theme.colorScheme.surface,

          borderRadius: BorderRadius.circular(7),

          border: Border.all(
            color: AppColors.totalborde2,
          ),
        ),

        child: Text(
          hint,

          style: style?.copyWith(
                color: theme
                    .colorScheme.onSurfaceVariant,
              ) ??
              TextStyle(
                fontSize: 12,
                color: theme
                    .colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}