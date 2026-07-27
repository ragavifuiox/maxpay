import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/view/home/widgets/earnings_chart.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/view/home/widgets/news_ticker.dart';
import 'package:maxpay/view/home/widgets/stat_card.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';
import 'package:maxpay/controllers/home/wallet_controller.dart';
import 'package:maxpay/injection_container.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletController = Get.put(
      WalletController(getWalletBalanceUseCase: sl()),
    );
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 PREMIUM HEADER
              const HomeHeaderSection(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 THE EARNINGS CHART
                    const EarningsChart(),

                    /// 🔹 NEWS TICKER
                    const NewsTicker(),

                    /// 🔹 DASHBOARD GRID
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      padding: EdgeInsets.all(4.w),
                      childAspectRatio: 0.9,
                      children: [
                        StatCard(
                          onTap: () {
                            Get.toNamed(AppRoutes.addwallet);
                          },
                          title: 'Add Wallet',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          borderColor: AppColors.card4,
                          imageWidget: SvgPicture.asset(
                            AssetImages.addWallet,
                            height: 32.h,
                          ),
                        ),
                        Obx(() {
                          final balance =
                              walletController
                                  .walletData
                                  .value
                                  ?.data
                                  ?.balance ??
                              0;
                          final currencySymbol =
                              walletController
                                  .walletData
                                  .value
                                  ?.data
                                  ?.currencySymbol ??
                              '₹';
                          return StatCard(
                            onTap: () {
                              Get.toNamed(AppRoutes.walletBalance);
                            },
                            title: 'Wallet Balance',
                            bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                            value: '$currencySymbol$balance',
                            textColor: const Color(0xff636363),
                            borderColor: AppColors.card4,
                            imageWidget: SvgPicture.asset(
                              AssetImages.walletBalance,
                              height: 32.h,
                            ),
                          );
                        }),
                        BlinkingZoomCard(
                          child: Container(
                            padding: EdgeInsets.all(3), // Border thickness
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: StatCard(
                              onTap: () =>
                                  Get.find<NavbarController>().openMenu(),
                              title: 'Transactions',
                              bgColor: AppColors.clrPrimary,
                              textColor: Colors.white,

                              borderColor:
                                  Colors.transparent, // Hide StatCard border
                              imageWidget: SvgPicture.asset(
                                AssetImages.transactions,
                                height: 32.h,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                        StatCard(
                          title: 'Todays Credit',
                          value: '₹2500.00',
                          textColor: const Color(0xff636363),
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          borderColor: isDark
                              ? AppColors.clrPrimary
                              : Color(0x66495BFF),
                          imageWidget: SvgPicture.asset(
                            AssetImages.todaysCredit,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          title: 'Refunded',
                          value: '₹2500.00',
                          textColor: const Color(0xff636363),
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          borderColor: AppColors.card4,
                          imageWidget: SvgPicture.asset(
                            AssetImages.refunded,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          title: 'Complaints',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          value: '300',
                          borderColor: AppColors.card4,
                          imageWidget: SvgPicture.asset(
                            AssetImages.complaints,
                            height: 32.h,
                          ),
                        ),

                        // Obx(() {
                        //   // final success =
                        //   //     controller.transactionData.value?.data?.success;

                        //   // final amount = (success?.amount ?? 0).toDouble();
                        //   // final count = success?.count ?? 0;

                        //   return StatCard(
                        //     bgColor: AppColors.success,
                        //     onTap: () {
                        //       Get.toNamed(
                        //         AppRoutes.transaction,
                        //         arguments: TransactionStatus.success,
                        //       );
                        //     },
                        //     title: 'Success',
                        //     value: '${'2000'} /\n10 Nos',
                        //     imageWidget: SvgPicture.asset(
                        //       AssetImages.success,
                        //       height: 24.h,
                        //       width: 24.w,
                        //     ),
                        //     valueColor: Colors.black,
                        //     borderColor: Colors.transparent,
                        //     textColor: Colors.green,
                        //   );
                        // }),
                        StatCard(
                          bgColor: AppColors.success,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.transaction,
                              arguments: TransactionStatus.success,
                            );
                          },
                          title: 'Success',
                          value: '${'2000'.currencyIndian} /\n10 Nos',
                          imageWidget: SvgPicture.asset(
                            AssetImages.successIcon,
                            height: 24.h,
                            width: 24.w,
                          ),
                          valueColor: Colors.black,
                          borderColor: AppColors.clrPrimary,
                          textColor: Colors.green,
                        ),

                        // Obx(() {
                        //   // final processing = controller
                        //   //     .transactionData
                        //   //     .value
                        //   //     ?.data
                        //   //     ?.processing;

                        //   // final amount = (processing?.amount ?? 0).toDouble();
                        //   // final count = processing?.count ?? 0;

                        //   return StatCard(
                        //     bgColor: AppColors.pending,
                        //     onTap: () {
                        //       // final controller = Get.put<TransReportController>(
                        //       //   TransReportController(
                        //       //     transreportUsecase: sl(),
                        //       //     producttypeUseCase: sl(),
                        //       //     submitDisputeUsecase: sl(),
                        //       //     cashbackTypeUsecase: sl(),
                        //       //   ),
                        //       // );

                        //       // controller.clearFilters();

                        //       Get.toNamed(
                        //         AppRoutes.transaction,
                        //         arguments: TransactionStatus.pending,
                        //       );
                        //     },
                        //     title: 'Processing',
                        //     value: '${'2000'} /\n10 Nos',
                        //     needSpacingbwImage: false,
                        //     imageWidget: SvgPicture.asset(
                        //       AssetImages.processing,
                        //       height: 24.h,
                        //       width: 24.w,
                        //     ),
                        //     valueColor: Colors.black,
                        //     textColor: Colors.orange,
                        //     borderColor: Colors.transparent,
                        //   );
                        // }),
                        StatCard(
                          bgColor: AppColors.pending,
                          onTap: () {
                            // final controller = Get.put<TransReportController>(
                            //   TransReportController(
                            //     transreportUsecase: sl(),
                            //     producttypeUseCase: sl(),
                            //     submitDisputeUsecase: sl(),
                            //     cashbackTypeUsecase: sl(),
                            //   ),
                            // );

                            // controller.clearFilters();

                            Get.toNamed(
                              AppRoutes.transaction,
                              arguments: TransactionStatus.pending,
                            );
                          },
                          title: 'Processing',
                          value: '${'2000'.currencyIndian} /\n10 Nos',
                          needSpacingbwImage: false,
                          imageWidget: SvgPicture.asset(
                            AssetImages.processIcon,
                            height: 24.h,
                            width: 24.w,
                          ),
                          valueColor: Colors.black,
                          textColor: Colors.orange,
                          borderColor: AppColors.clrPrimary,
                        ),
                        // Obx(() {
                        // // final failed =
                        // //     controller.transactionData.value?.data?.failed;

                        // final amount = (failed?.amount ?? 0).toDouble();
                        // final count = failed?.count ?? 0;

                        //   return StatCard(
                        //     bgColor: AppColors.failed,
                        //     onTap: () {
                        //       Get.toNamed(
                        //         AppRoutes.transaction,
                        //         arguments: TransactionStatus.failed,
                        //       );
                        //     },
                        //     title: 'Failed',
                        //     value: '${'2000'} /\n10 Nos',
                        //     needSpacingbwImage: false,
                        //     imageWidget: SvgPicture.asset(
                        //       AssetImages.failedAll,
                        //       height: 24.h,
                        //       width: 24.w,
                        //     ),
                        //     valueColor: Colors.black,
                        //     textColor: Colors.red,
                        //     borderColor: Colors.transparent,
                        //   );
                        // }),
                        StatCard(
                          bgColor: AppColors.failed,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.transaction,
                              arguments: TransactionStatus.failed,
                            );
                          },
                          title: 'Failed',
                          value: '${'2000'.currencyIndian} /\n10 Nos',
                          needSpacingbwImage: false,
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedIcon,
                            height: 24.h,
                            width: 24.w,
                          ),
                          valueColor: Colors.black,
                          textColor: Colors.red,
                          borderColor: AppColors.clrPrimary,
                        ),
                        StatCard(
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          title: 'Upgrade Package',
                          borderColor: isDark
                              ? AppColors.clrPrimary
                              : Color(0x66495BFF),
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedAll,
                            height: 45.h,
                          ),
                        ),
                        StatCard(
                          title: 'Business Group',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          borderColor: isDark
                              ? AppColors.clrPrimary
                              : Color(0x66495BFF),
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedAll,
                            height: 45.h,
                          ),
                        ),
                        StatCard(
                          title: 'Referral Link',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          borderColor: isDark
                              ? AppColors.clrPrimary
                              : Color(0x66495BFF),
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedAll,
                            height: 45.h,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    /// 🔹 SERVICES SECTION
                    // const Services
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
