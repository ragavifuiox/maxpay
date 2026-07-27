import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/global_widget/custom_app.dart';

import 'package:maxpay/controllers/home/wallet_controller.dart';
import 'package:maxpay/injection_container.dart';

class WalletBalanceScreen extends StatefulWidget {
  const WalletBalanceScreen({super.key});

  @override
  State<WalletBalanceScreen> createState() => _WalletBalanceScreenState();
}

class _WalletBalanceScreenState extends State<WalletBalanceScreen> {
  bool _showBalance = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Wallet Balance"),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 22, 26, 0),
          child: _BalanceCard(
            showBalance: _showBalance,
            onToggleVisibility: () {
              setState(() {
                _showBalance = !_showBalance;
              });
            },
          ),
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final bool showBalance;
  final VoidCallback onToggleVisibility;

  const _BalanceCard({
    required this.showBalance,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final walletController = Get.isRegistered<WalletController>()
        ? Get.find<WalletController>()
        : Get.put(WalletController(getWalletBalanceUseCase: sl()));

    return Container(
      width: double.infinity,
      height: 111,
      decoration: BoxDecoration(
        color: AppColors.clrPrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: (13.6).sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onToggleVisibility,
                child: Icon(
                  showBalance
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Obx(() {
            final balance =
                walletController.walletData.value?.data?.balance ?? 0;
            final currencySymbol =
                walletController.walletData.value?.data?.currencySymbol ?? '₹';
            return Text(
              showBalance
                  ? balance.toString().currencyIndian
                  : '$currencySymbol******',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 40,

                fontWeight: FontWeight.w700,
                letterSpacing: 0,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class GlobalWalletBalanceCard extends StatelessWidget {
  final bool showBalance;
  final VoidCallback onToggleVisibility;

  const GlobalWalletBalanceCard({
    required this.showBalance,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final walletController = Get.isRegistered<WalletController>()
        ? Get.find<WalletController>()
        : Get.put(WalletController(getWalletBalanceUseCase: sl()));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.clrPrimary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            'Wallet Balance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 5.h),

          Obx(() {
            final balance =
                walletController.walletData.value?.data?.balance ?? 0;

            return Text(
              balance.toString().currencyIndian,
              style:
                  theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                  ) ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                  ),
            );
          }),
        ],
      ),
    );
  }
}
