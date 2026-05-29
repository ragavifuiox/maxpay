import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/earning_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/common_filter_box.dart';
import 'package:maxpay/global_widget/custom_app.dart';

import 'package:maxpay/view/my_earning/widget/my_earning_widget.dart';

class MyEarningsScreen extends GetView<EarningController> {
  const MyEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

                const CommonFilterBox(),

                const SizedBox(height: 16),

                // Total Earnings Container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    borderRadius: BorderRadius.circular(10),
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
                  child: ListView(
                    children: const [

                      EarningsCard(),

                      SizedBox(height: 10),

                      EarningsCard(),

                      SizedBox(height: 10),

                      EarningsCard(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}