import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/balance/wallet.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER
              const HomeHeaderSection(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// WALLET CARD
                    GlobalWalletBalanceCard(
                      showBalance: true,
                      onToggleVisibility: () {},
                    ),
                    SizedBox(height: 16.h),

                    /// TOP BANNER
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        "https://images.unsplash.com/photo-1548013146-72479768bada?q=80&w=1000",
                        height: 150.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 18.h),

                    /// SERVICES TITLE
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.clrPrimary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "Services",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// FIRST ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _serviceItem(
                          context,
                          "Prepaid",
                          AssetImages.prepaid,
                          AppColors.box1,
                          onTap: () {
                            Get.toNamed(AppRoutes.prepaid);
                          },
                        ),

                        _serviceItem(
                          context,
                          "DTH",
                          AssetImages.dth,
                          AppColors.box2,
                          onTap: () {
                            Get.toNamed(AppRoutes.dth);
                          },
                        ),

                        _serviceItem(
                          context,
                          "FASTag",
                          AssetImages.fastag,
                          AppColors.box3,
                        ),

                        _serviceItem(
                          context,
                          "Gas",
                          AssetImages.gas,
                          AppColors.box4,
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    /// SECOND ROW
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// LEFT SIDE
                        Column(
                          spacing: 10,
                          children: [
                            _serviceItem(
                              context,
                              "Postpaid",
                              AssetImages.transactions1,
                              AppColors.box1,
                              onTap: () {
                                Get.to({});
                              },
                            ),

                            _serviceItem(
                              context,
                              "Electricity",
                              AssetImages.promoFrame,
                              AppColors.box3,
                            ),
                          ],
                        ),

                        SizedBox(width: 8.w),

                        /// CENTER BANNER
                        Expanded(
                          child: SizedBox(
                            height: 170.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.asset(
                                AssetImages.banner1,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),

                    /// THIRD ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _serviceItem(
                          context,
                          "Water",
                          AssetImages.water,
                          AppColors.box4,
                        ),

                        _serviceItem(
                          context,
                          "Landline",
                          AssetImages.landline,
                          AppColors.box3,
                        ),

                        _serviceItem(
                          context,
                          "Broadband",
                          AssetImages.broadband,
                          AppColors.box2,
                        ),

                        _serviceItem(
                          context,
                          "Cable TV",
                          AssetImages.cable,
                          AppColors.box1,
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),

                    /// BOTTOM SECTION
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// LEFT BANNER
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(
                              AssetImages.banner2,
                              height: 150.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        /// RIGHT SIDE
                        Column(
                          children: [
                            _serviceItem(
                              context,
                              "Favorite",
                              AssetImages.paymentStatus,
                              AppColors.box2,
                              onTap: () {
                                Get.toNamed(AppRoutes.favorite);
                              },
                            ),

                            _serviceItem(
                              context,
                              "Refresh",
                              AssetImages.dthRefresh,
                              AppColors.box1,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceItem(
    BuildContext context,
    String title,
    String image,
    Color bgColor, {
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    String displayTitle = title;
    if (title.toLowerCase() == "payment status") {
      displayTitle = "Payment\nStatus";
    } else if (title.toLowerCase() == "dth refresh") {
      displayTitle = "DTH\nRefresh";
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(image, fit: BoxFit.contain),
                      if (title.toLowerCase() == "refresh")
                        Text(
                          "DTH",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              SizedBox(
                width: 70.w,
                child: Text(
                  displayTitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
