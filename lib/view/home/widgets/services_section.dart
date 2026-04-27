import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/utils/asset_images.dart';
import 'package:maxpay/core/utils/colors.dart';
import 'package:maxpay/view/mobile_recharge/mobile_recharge_page.dart';
import 'package:maxpay/view/dth_recharge/dth_recharge_page.dart';
import 'package:maxpay/view/fastag_recharge/fastag_recharge_page.dart';
import 'package:maxpay/view/electricity_bill/electricity_bill_page.dart';
import 'package:maxpay/view/gas_bill/gas_bill_page.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// WALLET BALANCE CONTAINER
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.r),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.clrPrimary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20.r,
                offset: Offset(0, 4.r),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Wallet Balance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),

              Text(
                '₹ 245005.23',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Lufga',
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        /// 🔹 MOSQUE BANNER
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: CachedNetworkImage(
            imageUrl:
                "https://5.imimg.com/data5/SELLER/Default/2023/11/363705672/UZ/QW/KG/54384979/online-electricity-bill-payment-services.jpg",
            width: double.infinity,
            height: 160.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20.h),

        /// 🔹 SERVICES HEADER
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.clrPrimary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            'Services',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(height: 20.h),

        /// 🔹 SERVICES GRID - ROW 1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ServiceItem(
              title: 'Prepaid',
              icon: AssetImages.prepaid,
              bgColor: const Color(0xFFE8FAF0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MobileRechargePage(),
                  ),
                );
              },
            ),
            _ServiceItem(
              title: 'DTH',
              icon: AssetImages.dth,
              bgColor: const Color(0xFFFFEBEB),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DTHRechargePage(),
                  ),
                );
              },
            ),
            _ServiceItem(
              title: 'FASTag',
              icon: AssetImages.fastag,
              bgColor: const Color(0xFFE8FAF0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FastagRechargePage(),
                  ),
                );
              },
            ),
            _ServiceItem(
              title: 'Gas',
              icon: AssetImages.gas,
              bgColor: const Color(0xFFFFF4E6),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GasBillPage()),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 20.h),

        /// 🔹 SERVICES GRID - ROW 2 (Postpaid + Banner)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const _ServiceItem(
                  title: 'Postpaid',
                  icon: AssetImages.mobilePostpaid,
                  bgColor: Color(0xFFE6F0FF),
                ),
                SizedBox(height: 20.h),
                _ServiceItem(
                  title: 'Electricity',
                  icon: AssetImages.promoFrame, // elec.svg
                  bgColor: const Color(0xFFFFF4E6),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ElectricityBillPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://img.freepik.com/free-vector/5g-instagram-horizontal-banner-template_23-2148949265.jpg",
                  height: 165.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        /// 🔹 SERVICES GRID - ROW 3 (Water, Landline, Broadband, Statement)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _ServiceItem(
              title: 'Water',
              icon: AssetImages.water,
              bgColor: Color(0xFFFFEBEB),
            ),
            const _ServiceItem(
              title: 'Landline',
              icon: AssetImages.landline,
              bgColor: Color(0xFFE8FAF0),
            ),
            const _ServiceItem(
              title: 'Broadband',
              icon: AssetImages.broadband,
              bgColor: Color(0xFFE6F0FF),
            ),
            const _ServiceItem(
              title: 'Statement',
              icon: AssetImages.statement,
              bgColor: Color(0xFFFFF4E6),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        /// 🔹 SERVICES GRID - ROW 4 (Promo Banner + Others)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 140.h,
                decoration: BoxDecoration(
                  color: AppColors.clrPrimary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://5.imimg.com/data5/SELLER/Default/2024/5/422226820/OB/XS/YX/221288867/electricity-bill-payment-service.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              children: [
                const _ServiceItem(
                  title: 'Favorite',
                  icon: AssetImages.favorite,
                  bgColor: Color(0xFFE6F0FF),
                ),
                SizedBox(height: 20.h),
                const _ServiceItem(
                  title: 'DTH Refresh',
                  icon: AssetImages.dthRefresh,
                  bgColor: Color(0xFFFFEBEB),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}

class _ServiceItem extends ConsumerWidget {
  final String title;
  final String icon;
  final Color bgColor;
  final VoidCallback? onTap;

  const _ServiceItem({
    required this.title,
    required this.icon,
    required this.bgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 75.w,
        child: Column(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(icon, fit: BoxFit.contain),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
