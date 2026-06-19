import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/earning_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/my_earning/widget/earning_filter.dart';

import 'package:maxpay/view/my_earning/widget/my_earning_widget.dart';

class MyEarningsScreen extends GetView<EarningController> {
  const MyEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      

      appBar: const CommonAppBar(
        title: "My Earnings",
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Obx(
          () {

            // Loading
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: [

                const EarningFilter(),

                const SizedBox(height: 16),
               Divider(
  color: Theme.of(context).brightness == Brightness.light
      ? Colors.black12
      : Colors.white24,
),

                const SizedBox(height: 12),
                // Total Earnings Container
               Container(
  width: double.infinity,
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: AppColors.clrPrimary,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: isDark
          ? AppColors.darkFilterBorder
          : AppColors.totalborde2.withValues(alpha: 0.1),
    ),
  ),
  child: Column(
    children: [
      const Text(
        "Total Earnings",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'poppins',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        "₹ ${controller.earningsData.value?.data?.totalEarnings ?? 0}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),

                const SizedBox(height: 16),

                // Dummy List
               Expanded(
  child: Obx(() {
    final list =
        controller.searchData.value?.data?.list ?? [];

    if (list.isEmpty) {
      return const Center(
        child: Text("No Earnings Found"),
      );
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return EarningsCard(
          item: list[index],
        );
      },
    );
  }),
),
              ],
            );
          },
        ),
      ),
    );
  }
}