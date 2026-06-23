import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:maxpay/controllers/login_history_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/data/model/login_history_model.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/login_history/widget/login_filter.dart';

class LoginHistoryScreen extends GetView<LoginHistoryController> {
  const LoginHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Login History",
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            const SizedBox(height: 10),

            /// FILTER BOX
           LoginFilterwidget(),
            const SizedBox(height: 16),

            Divider(
              color:
                  theme.colorScheme.outline,
            ),

            const SizedBox(height: 16),

            /// CARD LIST
           Expanded(
  child: Obx(() {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.loghistory.isEmpty) {
      return const Center(
        child: Text("No Login History Found"),
      );
    }

    return ListView.separated(
      itemCount: controller.loghistory.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return _LoginHistoryCard(
          item: controller.loghistory[index],
        );
      },
    );
  }),
)
          ],
        ),
      ),
    );
  }
}

/// DATE FIELD

// class _DateField extends StatelessWidget {
//   final String hint;

//   const _DateField({
//     required this.hint,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Expanded(
//       child: Container(
//         padding:
//             const EdgeInsets.symmetric(
//           horizontal: 10,
//           vertical: 10,
//         ),

//         decoration: BoxDecoration(
//           color: theme.brightness ==
//                   Brightness.light
//               ? Colors.white
//               : theme.colorScheme.surface,

//           borderRadius:
//               BorderRadius.circular(7),

//           border: Border.all(
//             color:
//                 theme.colorScheme.outline,
//           ),
//         ),

//         child: Text(
//           hint,

//           style: TextStyle(
//             fontSize: 12,
//             color: theme.colorScheme
//                 .onSurfaceVariant,
//           ),
//         ),
//       ),
//     );
//   }
// }

/// LOGIN HISTORY CARD
class _LoginHistoryCard extends StatelessWidget {
  final LogHistoryData item;

  const _LoginHistoryCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color:
            theme.brightness ==
                    Brightness.light
                ? AppColors.background
                : theme.colorScheme
                    .surfaceContainer,

        borderRadius:
            BorderRadius.circular(12),

        border: Border.all(
          color:
              theme.colorScheme.outline,
        ),
      ),

      child: Column(
        children: [
          /// TOP ROW
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.lightGreen,
                    size: 18,
                  ),

                  const SizedBox(width: 4),

                  Text(item.city ?? "-",
                    style:
                        TextHelper.max1
                            .copyWith(
                      color: theme
                          .colorScheme
                          .onSurface,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,

                children: [
                  Text(
                    "Date & Time:",

                    style:
                        TextHelper.max1
                            .copyWith(
                      color: theme
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(item.loginTime ?? "-",

                    style:
                        TextHelper.max1
                            .copyWith(
                      color: theme
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 13),

          /// BOTTOM ROW
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    "Network",

                    style:
                        TextHelper.max6
                            .copyWith(
                      color: theme
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "IP Address",

                    style:
                        TextHelper.max6
                            .copyWith(
                      color: theme
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,

                children: [
                  Text(item.network ?? "-",

                    style:
                        TextHelper.max7
                            .copyWith(
                      color: theme.brightness == Brightness.light
              ? AppColors.blueColor
              : AppColors.blueColor
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "16.25.20.0.2.0000.54",

                    style:
                        TextHelper.max7
                            .copyWith(
                       color: theme.brightness == Brightness.light
              ? AppColors.blueColor
              : AppColors.blueColor
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}