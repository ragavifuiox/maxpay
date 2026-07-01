import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/login_history_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class LoginFilterwidget extends GetView<LoginHistoryController> {
  const LoginFilterwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GetBuilder<LoginHistoryController>(
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
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          controller.selectFromDate(context),
                      child: _dateField(
                        context,
                        controller.fromDate.isEmpty
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
                      child: _dateField(
                        context,
                        controller.toDate.isEmpty
                            ? "End Date"
                            : controller.toDate,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

//              TextField(
//   keyboardType: TextInputType.number,
//   style: TextStyle(
//     color: theme.colorScheme.onSurface,
//   ),
//   onChanged: (value) {
//     controller.search = value;

//     if (controller.fromDate.isNotEmpty &&
//         controller.toDate.isNotEmpty) {
//       controller.loghistory();
//     }
//   },
//   decoration: InputDecoration(
//     prefixIcon: Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: SvgPicture.asset(
//         AssetImages.search,
//         colorFilter: ColorFilter.mode(
//           isDark
//               ? AppColors.textclr
//               : theme.colorScheme.onSurfaceVariant,
//           BlendMode.srcIn,
//         ),
//       ),
//     ),
//     hintText: "Enter Mobile Number",
//     hintStyle: TextHelper.max1.copyWith(
//       color: isDark
//           ? AppColors.textclr
//           : AppColors.clrTextgrey,
//     ),
//     filled: true,
//     fillColor:
//         isDark ? AppColors.darkplceholder : Colors.white,
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(7),
//       borderSide: BorderSide(
//         color: isDark
//             ? AppColors.darkFilterBorder
//             : AppColors.totalborde2,
//       ),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(7),
//       borderSide: BorderSide(
//         color: isDark
//             ? AppColors.darkFilterBorder
//             : AppColors.totalborde2,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(7),
//       borderSide: BorderSide(
//         color: theme.colorScheme.primary,
//       ),
//     ),
//     contentPadding: const EdgeInsets.symmetric(
//       vertical: 0,
//     ),
//   ),
// )


TextField(
  keyboardType: TextInputType.text,
  style: TextStyle(
    color: theme.colorScheme.onSurface,
  ),
  onChanged: (value) {
    controller.search = value;

    if (controller.fromDate.isNotEmpty &&
        controller.toDate.isNotEmpty) {
      controller.LoginHistory();
    }
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
    hintText: "Search (Mobile / City / IP Address / Network)",
    hintStyle: TextHelper.max1.copyWith(
      color: isDark
          ? AppColors.textclr
          : AppColors.clrTextgrey,
    ),
    filled: true,
    fillColor:
        isDark ? AppColors.darkplceholder : Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(
        color: theme.colorScheme.primary,
      ),
    ),
  ),
)
            ],
          ),
        );
      },
    );
  }

  Widget _dateField(
    BuildContext context,
    String text,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color:
            isDark ? AppColors.darkplceholder : Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2,
        ),
      ),
      child: Text(
        text,
        style: TextHelper.max1.copyWith(
          color: isDark
              ? AppColors.textclr
              : theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}