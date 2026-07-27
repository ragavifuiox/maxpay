import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class CommonFilterBox extends StatelessWidget {
  const CommonFilterBox({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
    ? AppColors.border
    : AppColors.darkbgBlack,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
         color: theme.brightness == Brightness.light
    ? Colors.grey.withValues(alpha: 0.1)
    : AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              DateField(
                hint: "DD.MM.YYYY",
                style: TextHelper.max1.copyWith(
                  color:AppColors.darktextclr
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.arrow_forward,
                size: 18,
                color: theme.colorScheme.primary,
              ),

              const SizedBox(width: 8),

              DateField(
                hint: "DD.MM.YYYY",
                style: TextHelper.max1.copyWith(
                  color:AppColors.darktextclr
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const SearchBox(),
        ],
      ),
    );
  }
}

class DateField extends StatelessWidget {
  final String hint;
  final TextStyle? style;

  const DateField({
    super.key,
    required this.hint,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
               color: theme.brightness == Brightness.light
    ? AppColors.totalborde2
    : AppColors.totalborde2,
          ),
        ),
        child: Text(
          hint,
          style:
              style ??
              TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 13,
              ),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      style: TextStyle(
       color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            AssetImages.search,
            colorFilter: const ColorFilter.mode(
              AppColors.darktextclr,
              BlendMode.srcIn,
            ),
          ),
        ),

        hintText: "Search",

        hintStyle:TextHelper.max1.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),

        filled: true,
        fillColor: theme.colorScheme.surface,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
             color: theme.brightness == Brightness.light
    ? AppColors.totalborde2
    : AppColors.totalborde2,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
           color: theme.brightness == Brightness.light
    ? AppColors.totalborde2
    : AppColors.totalborde2,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
        ),
      ),
    );
  }
}