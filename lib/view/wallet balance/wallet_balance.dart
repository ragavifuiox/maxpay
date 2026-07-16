import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/controllers/add_wallet_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/add_wallet/add_wallet_screen.dart';
import 'package:maxpay/view/wallet%20balance/wallet_history_card.dart';

class WalletBalanceScreen extends GetView<AddWalletController> {
  const WalletBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomePageController>();
    return Scaffold(
      appBar: CommonAppBar(title: "Wallet Balance"),
      body: Obx(() {
        final historyList = controller.walletQrHistory.value.code ?? [];
        final latestFive = historyList
            .take(3)
            .toList(); // API already latest-first

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Balance Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 111,
                decoration: BoxDecoration(
                  color: const Color(0xff18A9C4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Total Balance",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => Text(
                          homeController.walletBalance.value?.data?.balance
                                  ?.toString()
                                  .currencyIndian ??
                              '0.00',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,

                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const AddWalletScreen());
                      },
                      child: const Text("View All"),
                    ),
                  ],
                ),
              ),

              latestFive.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("No Transaction History"),
                    )
                  : Column(
                      children: latestFive.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          child: walletcard(
                            context: context,
                            status: item.status ?? '',
                            statusColor: item.status?.toLowerCase() == 'success'
                                ? Colors.green
                                : Colors.orange,
                            amount: item.requestAmount ?? '0',
                            txnId: item.txnId ?? '',
                            dateTime: item.createdAt == null
                                ? ''
                                : DateFormat(
                                    'dd-MM-yyyy hh:mm a',
                                  ).format(item.createdAt!),
                          ),
                        );
                      }).toList(),
                    ),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
