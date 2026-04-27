import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maxpay/core/utils/asset_images.dart';
import 'package:maxpay/core/utils/colors.dart';
import 'package:maxpay/view/home/widgets/earnings_chart.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/view/home/widgets/news_ticker.dart';
import 'package:maxpay/view/home/widgets/services_section.dart';
import 'package:maxpay/view/home/widgets/stat_card.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);


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
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.h),

                    /// 🔹 TEAL WALLET BALANCE CARD
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
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
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '₹ 245005.23',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

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
                      childAspectRatio: 0.9,
                      padding: EdgeInsets.all(4.w),
                      children: [
                        StatCard(
                          title: 'Add Wallet',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          imageWidget: SvgPicture.asset(
                            AssetImages.addWallet,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          title: 'Wallet Balance',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          value: '₹25500.00',
                          textColor: const Color(0xff636363),
                          imageWidget: SvgPicture.asset(
                            AssetImages.walletBalance,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          title: 'Transactions',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          imageWidget: SvgPicture.asset(
                            AssetImages.transactions,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          title: 'Todays Credit',
                          value: '₹2500.00',
                          textColor: const Color(0xff636363),
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
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
                          imageWidget: SvgPicture.asset(
                            AssetImages.refunded,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          title: 'Complaints',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          value: '300',
                          imageWidget: SvgPicture.asset(
                            AssetImages.complaints,
                            height: 32.h,
                          ),
                        ),

                        /// Status Row
                        StatCard(
                          title: 'Success',
                          value: '₹5,000 / 20 Nos',
                          imageWidget: SvgPicture.asset(
                            AssetImages.success,
                            height: 45.h,
                          ),
                          bgColor: const Color(0xFFE8FAF0),
                          textColor: Colors.green,
                        ),
                        StatCard(
                          title: 'Processing',
                          value: '₹5,000 / 20 Nos',
                          imageWidget: SvgPicture.asset(
                            AssetImages.processing,
                            height: 45.h,
                          ),
                          bgColor: const Color(0xFFFFF4E6),
                          textColor: Colors.orange,
                        ),
                        StatCard(
                          title: 'Failed',
                          value: '₹5,000 / 20 Nos',
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedAll,
                            height: 45.h,
                          ),
                          bgColor: const Color(0xFFFFEBEB),
                          textColor: Colors.red,
                        ),

                        StatCard(
                          title: 'Upgrade Package',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedAll,
                            height: 45.h,
                          ),
                        ),
                        StatCard(
                          title: 'Business Group',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedAll,
                            height: 45.h,
                          ),
                        ),
                        StatCard(
                          title: 'Referral Link',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          imageWidget: SvgPicture.asset(
                            AssetImages.failedAll,
                            height: 45.h,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    /// 🔹 SERVICES SECTION
                    const ServicesSection(),

                    SizedBox(height: 100.h), // Space for Nav Bar
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
