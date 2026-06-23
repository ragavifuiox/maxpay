import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WalletBalanceScreen extends GetView<HomePageController> {
  const WalletBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    controller.fetchWalletBalance();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Wallet Balance"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Container(
          height: 164.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.clrPrimary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: .center,
            spacing: 9,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Balance",
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: (13.6).sp,
                      height: 0,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.visibility_off_outlined,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 22,
                  ),
                ],
              ),

              Obx(() {
                final balance =
                    Get.find<HomePageController>().walletBalance.value;

                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "₹",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,

                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text:
                            " ${(balance?.data?.balance)?.toStringAsFixed(2) ?? "0.00"}",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: (33.2).sp,
                          fontWeight: FontWeight.w700,

                          height: 0,
                        ),
                      ),
                    ],
                  ),

                  // style: TextStyle(
                  //   color: Colors.white,
                  //   fontSize: 24.sp,
                  //   fontWeight: FontWeight.w700,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
