import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/cash_back_controller.dart';
import 'package:maxpay/core/data/model/product_type.dart';
import 'package:maxpay/core/constants/colors.dart';

import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class CashbackScreen extends GetView<CashbackController> {
  const CashbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(
        title: "Cash Back",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            
           Container(
  margin: const EdgeInsets.only(bottom: 12),
  padding: const EdgeInsets.all(14),
  decoration: BoxDecoration(
    color: theme.brightness == Brightness.light
        ? AppColors.background
        : const Color(0xFF2F3349),
    borderRadius: BorderRadius.circular(12),
    border: theme.brightness == Brightness.dark
        ? Border.all(
            color: const Color(0xFF3C3F52),
          )
        : null,
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          "Product",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),

      const SizedBox(height: 8),

      Container(
        height: 52,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light
              ? Colors.white
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.brightness == Brightness.light
                ? Colors.black12
                : const Color(0xFF3C3F52),
          ),
        ),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<Data>(
              isExpanded: true,
              hint: Text(
                controller.selectedProductName.value.isEmpty
                    ? "Select "
                    : controller.selectedProductName.value,
                style: TextHelper.max2.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: theme.colorScheme.onSurface,
              ),
              items: controller.allPlan.value?.data?.map(
                    (item) => DropdownMenuItem<Data>(
                      value: item,
                      child: Text(item.name ?? ''),
                    ),
                  ).toList() ??
                  [],
              onChanged: (value) {
                if (value == null) return;

                controller.selectedProductName.value =
                    value.name ?? '';

                controller.selectedProductType.value =
                    value.name ?? '';

                controller.selectedProductId.value =
                    value.id.toString();

                controller.fetchCashback(
                  value.id.toString(),
                );
              },
            ),
          ),
        ),
      ),
    ],
  ),
),
            

            const SizedBox(height: 22),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                final cashbackList =
                    controller.cashBack.value?.code ??
                        [];

                if (cashbackList.isEmpty) {
                  return const Center(
                    child: Text(
                      "Select Product Type",
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: cashbackList.length,
                  separatorBuilder:
                      (_, _) =>
                          const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item =
                        cashbackList[index];

                    final commission =
                        double.tryParse(
                              item.debitCommission ??
                                  '0',
                            ) ??
                            0;

                    return CashbackTile(
                      name: item.name ?? '',
                      logo: item.logo ?? '',
                      cashback:
                          item.debitCommission ??
                              '0',
                      cashbackColor:
                          commission >= 0
                              ? Colors.green
                              : Colors.red,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class CashbackTile extends StatelessWidget {
  final String name;
  final String logo;
  final String cashback;
  final Color cashbackColor;

  const CashbackTile({
    super.key,
    required this.name,
    required this.logo,
    required this.cashback,
    required this.cashbackColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.background
            : theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: theme.brightness == Brightness.dark
            ? Border.all(
                color: const Color(0xFF3C3F52),
              )
            : null,
      ),
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              // shape: BoxShape.circle,
            ),
            child: Image.network(
              logo,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, _, _) => const Icon(
                    Icons.image,
                  ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                "Cashback",
                style: TextHelper.max2.copyWith(
                  color: theme.brightness ==
                          Brightness.light
                      ? AppColors.darktextclr
                      : Colors.white,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                cashback,
                style: TextStyle(
                  color: cashbackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}