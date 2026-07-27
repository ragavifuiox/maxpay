import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/view/transaction_screens/widget/transaction_card.dart';

enum TransactionStatus { success, pending, failed }

class TransactionScreen extends StatefulWidget {
  final TransactionStatus status;

  const TransactionScreen({super.key, required this.status});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool isFavorite = false;
  final Set<int> _favoriteCards = <int>{};
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  Future<void> selectDate(
      BuildContext context,
      TextEditingController controller,
      ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isSuccess = widget.status == TransactionStatus.success;
    final bool isPending = widget.status == TransactionStatus.pending;

    Color bgColor;
    String title;

    if (isSuccess) {
      bgColor = isDark ? const Color(0xFFE2F8E9) : const Color(0xFFE2F8E9);

      title = "Transaction Success";
    } else if (isPending) {
      bgColor = isDark ? const Color(0xFFFFF1DD) : const Color(0xFFFFF1DD);

      title = "Transaction Pending";
    } else {
      bgColor = isDark ? const Color(0xFFFFE4E6) : const Color(0xFFFFE4E6);

      title = "Transaction Failed";
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.onSurface,
              size: 18,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(14),

        child: Column(
          children: [
            /// FILTER CONTAINER
            // Container(
            //   padding: const EdgeInsets.all(12),
            //
            //   decoration: BoxDecoration(
            //     color: theme.brightness == Brightness.light
            //         ? AppColors.border
            //         : theme.colorScheme.surfaceContainer,
            //
            //     borderRadius: BorderRadius.circular(10),
            //
            //     border: Border.all(
            //       color: theme.brightness == Brightness.light
            //           ? AppColors.totalborde2.withValues(alpha: 0.1)
            //           : theme.colorScheme.outline,
            //     ),
            //   ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? const Color(0xFFE3F0FB)
                    : AppColors.darkplceholder,
                borderRadius: BorderRadius.circular(10),
                border: theme.brightness == Brightness.light
                    ? Border.all(color: const Color(0xFFB5D4F4))
                    : null,
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
                          : AppColors.darkplceholder,

                      borderRadius: BorderRadius.circular(8),

                      border: Border.all(
                        color: theme.brightness == Brightness.light
                            ? const Color(0xFFD6D6D6)
                            : const Color.fromARGB(255, 159, 159, 159),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          "Select Product",

                          style: TextHelper.max1
                        ),

                        Icon(
                          Icons.chevron_right,
                          color: theme.colorScheme.onSurface,
                          size: 18,
                        ),
                      ],
                    )
                  ),

                  const SizedBox(height: 10),

                  /// DATE FIELD
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => selectDate(context, fromDateController),
                          child: AbsorbPointer(
                            child: customField(
                              context,
                              hint: "DD/MM/YYYY",
                              controller: fromDateController,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.arrow_forward,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      Expanded(
                        child: GestureDetector(
                          onTap: () => selectDate(context, toDateController),
                          child: AbsorbPointer(
                            child: customField(
                              context,
                              hint: "DD/MM/YYYY",
                              controller: toDateController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// SEARCH FIELD
                  customField(
                    context,
                    hint: "Search",
                    prefixWidget: SvgPicture.asset(
                      AssetImages.search,
                      colorFilter: const ColorFilter.mode(
                        AppColors.darktextclr,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// TRANSACTION LIST
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TransactionCard(
                    bgColor: bgColor,
                    status: widget.status,
                    isFavorite: _favoriteCards.contains(index),
                    onFavoriteTap: () {
                      setState(() {
                        if (!_favoriteCards.add(index)) {
                          _favoriteCards.remove(index);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//   Widget customField(
//     BuildContext context, {
//     required String hint,
//     Widget? prefixWidget,
//   }) {
//     final theme = Theme.of(context);
//
//     return Container(
//       height: 45,
//
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//
//       decoration: BoxDecoration(
//         color: theme.brightness == Brightness.light
//             ? Colors.white
//             : theme.colorScheme.surface,
//
//         borderRadius: BorderRadius.circular(8),
//
//         border: Border.all(
//           color: theme.brightness == Brightness.light
//               ? AppColors.darktextclr.withValues(alpha: 0.3)
//               : theme.colorScheme.outline,
//         ),
//       ),
//
//       child: Row(
//         children: [
//           if (prefixWidget != null) ...[
//             SizedBox(width: 18, height: 18, child: prefixWidget),
//
//             const SizedBox(width: 8),
//           ],
//
//           Expanded(
//             child: Text(
//               hint,
//
//               style: TextHelper.max1.copyWith(
//                 color: theme.colorScheme.onSurfaceVariant,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
  Widget customField(
      BuildContext context, {
        required String hint,
        IconData? prefix,
        TextEditingController? controller,
        ValueChanged<String>? onChanged,
        bool readOnly = false,
        VoidCallback? onTap,
        Widget? prefixWidget,
      }) {
    final theme = Theme.of(context);

    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? Colors.white
            : AppColors.darkplceholder,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? const Color(0xFFD6D6D6)
              : const Color.fromARGB(255, 159, 159, 159),
        ),
      ),
      child: Row(
        children: [
          if (prefix != null) ...[
            Icon(prefix, size: 18, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              readOnly: readOnly,
              onTap: onTap,
              style: TextHelper.max1.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextHelper.max1.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

