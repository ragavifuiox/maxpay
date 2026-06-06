import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/home/widgets/earnings_chart.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/view/home/widgets/news_ticker.dart';
import 'package:maxpay/view/home/widgets/stat_card.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';

class HomePageScreen extends GetView<HomePageController> {
  const HomePageScreen({super.key});

  @override
Widget build(BuildContext context) {

  // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   controller.fetchpopupmessage("Home");
  // });

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
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 30.h),
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
                      childAspectRatio: 0.9,
                      padding: EdgeInsets.all(4.w),
                      children: [
                        StatCard(
                          onTap: (){
                            Get.toNamed(AppRoutes.addwallet);
                          },
                          title: 'Add Wallet',
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          imageWidget: SvgPicture.asset(
                            AssetImages.addWallet,
                            height: 32.h,
                          ),
                        ),
                     Obx(() {

  final balance =
      controller.walletBalance.value?.data?.balance ?? 0.0;

  return StatCard(
    title: 'Wallet Balance',
 onTap: () {
    Get.toNamed(AppRoutes.walletbal);
    },
    value: '₹${balance.toStringAsFixed(2)}',
  textColor: Theme.of(context).brightness == Brightness.dark
    ? Color.fromARGB(255, 171, 171, 171)
    : AppColors.darktextclr,
    imageWidget: SvgPicture.asset(
      AssetImages.walletBalance,
    ),
  );
}),
          
BlinkingZoomCard(
  child: StatCard(
    onTap: () {
    Get.toNamed(AppRoutes.menu);
    },
    title: 'Transactions',
    bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
    imageWidget: SvgPicture.asset(
      AssetImages.transactions,
      height: 32.h,
    ),
  ),
),
                        StatCard(
                          title: 'Todays Credit',
                          value: '₹2500.00',
                         textColor: Theme.of(context).brightness == Brightness.dark
    ? Color.fromARGB(255, 171, 171, 171)
    : AppColors.darktextclr,
    
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          imageWidget: SvgPicture.asset(
                            AssetImages.todaysCredit,
                            height: 32.h,
                          ),
                        ),
                        StatCard(
                          title: 'Refunded',
                          value: '₹2500.00',
                            textColor: Theme.of(context).brightness == Brightness.dark
    ?  Color.fromARGB(255, 171, 171, 171)
    : AppColors.darktextclr,
                          bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                          imageWidget: SvgPicture.asset(
                            AssetImages.refunded,
                            height: 32.h,
                          ),
                        ),



                         Obx(() {

  final complaintCount =
      controller.complaints.value?.data?.complaintCount ?? 0;

  return StatCard(

    title: 'Complaints',

    value: complaintCount.toString(),

    imageWidget: SvgPicture.asset(
      AssetImages.complaints,
    ),
  textColor: Theme.of(context).brightness == Brightness.dark
    ? Color.fromARGB(255, 171, 171, 171)
    : AppColors.darktextclr,
    bgColor: AppColors.darkBlue.withValues(
      alpha: 0.04,
    ),
  );
}),
                        // StatCard(
                        //   title: 'Complaints',
                        //   textColor: const Color(0xff636363),
                        //   bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                        //   value: '300',
                        //   imageWidget: SvgPicture.asset(
                        //     AssetImages.complaints,
                        //     height: 32.h,
                        //   ),
                        // ),

                      
                       Obx(() {
  final success =
      controller.transactionData.value?.data?.success;

  return StatCard(
    bgColor: AppColors.success,
    onTap: () {
      Get.toNamed(
        AppRoutes.transaction,
        arguments: TransactionStatus.success,
      );
    },
    title: 'Success',

    value:
        '₹${success?.amount ?? 0} / ${success?.count ?? 0} Nos',

    imageWidget: SvgPicture.asset(
      AssetImages.success,
      height: 45.h,
    ),
valueColor: Theme.of(context).brightness == Brightness.dark
    ? Colors.black
    : Colors.black,
    textColor: Colors.green,
  );
}),
                       Obx(() {
  final processing =
      controller.transactionData.value?.data?.processing;

  return StatCard(
    bgColor: AppColors.pending,
    onTap: () {
      Get.toNamed(
        AppRoutes.transaction,
        arguments: TransactionStatus.pending,
      );
    },
    title: 'Processing',

    value:
        '₹${processing?.amount ?? 0} / ${processing?.count ?? 0} Nos',

    imageWidget: SvgPicture.asset(
      AssetImages.processing,
      height: 45.h,
    ),
valueColor: Theme.of(context).brightness == Brightness.dark
    ? Colors.black
    : Colors.black,
    textColor: Colors.orange,
  );
}),
                        Obx(() {
  final failed =
      controller.transactionData.value?.data?.failed;

  return StatCard(
    bgColor: AppColors.failed,
    onTap: () {
      Get.toNamed(
        AppRoutes.transaction,
        arguments: TransactionStatus.failed,
      );
    },
    title: 'Failed',

    value:
        '₹${failed?.amount ?? 0} / ${failed?.count ?? 0} Nos',

    imageWidget: SvgPicture.asset(
      AssetImages.failedAll,
      height: 45.h,
    ),
valueColor: Theme.of(context).brightness == Brightness.dark
    ? Colors.black
    : Colors.black,
    textColor: Colors.red,
  );
}),

                       
                        
                       
                      ],
                    ),

                    SizedBox(height: 20.h),

                 

                    SizedBox(height: 9.h), // Space for Nav Bar
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
