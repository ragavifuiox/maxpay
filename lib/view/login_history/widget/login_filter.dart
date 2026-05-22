import 'package:flutter/material.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class LoginFilterwidget extends StatelessWidget {
  const LoginFilterwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return 
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
              : theme.colorScheme.outline,
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
                color: theme.brightness == Brightness.light
                    ? const Color(0xFFB5D4F4)
                    : theme.colorScheme.outline,
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
              prefixIcon: Icon(
                Icons.search,
                color:
                    theme.colorScheme.onSurfaceVariant,
                size: 18,
              ),

              hintText: "Search",

              hintStyle: TextHelper.max1.copyWith(
                color:
                    theme.colorScheme.onSurfaceVariant,
              ),

              filled: true,

              fillColor:
                  theme.brightness == Brightness.light
                      ? Colors.white
                      : theme.colorScheme.surface,

              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(7),

                borderSide: BorderSide(
                  color:
                      theme.brightness ==
                              Brightness.light
                          ? const Color(0xFFB5D4F4)
                          : theme.colorScheme.outline,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(7),

                borderSide: BorderSide(
                  color:
                      theme.brightness ==
                              Brightness.light
                          ? const Color(0xFFB5D4F4)
                          : theme.colorScheme.outline,
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
            color: theme.brightness ==
                    Brightness.light
                ? const Color(0xFFB5D4F4)
                : theme.colorScheme.outline,
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