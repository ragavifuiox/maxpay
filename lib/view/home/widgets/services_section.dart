import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/menu_controlller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';

import '../../../core/data/model/product_type.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final ServiceController controller = Get.put(
    ServiceController(productTypeUseCase: sl()),
  );
  final HomePageController homeController = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.fetchpopupmessage("Dashboard");
    });

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final productList = controller.productTypeData.value?.data ?? [];

          return SingleChildScrollView(
            child: Column(
              children: [
                const HomeHeaderSection(),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// WALLET CARD
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        decoration: BoxDecoration(
                          color: AppColors.clrPrimary,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Wallet Balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 6.h),

                            Obx(() {
                              final balance = Get.find<HomePageController>()
                                  .walletBalance
                                  .value;

                              return Text(
                                "₹ ${balance?.data?.balance ?? "0.00"}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ],
                        ),
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
                          if (productList.isNotEmpty)
                            _dynamicServiceItem(context, productList[0], 0),

                          if (productList.length > 1)
                            _dynamicServiceItem(context, productList[1], 1),

                          if (productList.length > 2)
                            _dynamicServiceItem(context, productList[2], 2),

                          if (productList.length > 3)
                            _dynamicServiceItem(context, productList[3], 3),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              if (productList.length > 4)
                                _dynamicServiceItem(context, productList[4], 4),

                              // SizedBox(height: 18.h),
                              if (productList.length > 5)
                                _dynamicServiceItem(context, productList[5], 5),
                            ],
                          ),

                          SizedBox(width: 12.w),

                          /// CENTER BANNER
                          Expanded(
                            child: SizedBox(
                              height: 160.h,
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

                      SizedBox(height: 10.h),

                      /// THIRD ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (productList.length > 6)
                            _dynamicServiceItem(context, productList[6], 6),

                          if (productList.length > 7)
                            _dynamicServiceItem(context, productList[7], 7),

                          if (productList.length > 8)
                            _dynamicServiceItem(context, productList[8], 8),

                          if (productList.length > 9)
                            _dynamicServiceItem(context, productList[9], 9),
                        ],
                      ),

                      SizedBox(height: 18.h),

                      /// BOTTOM SECTION
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// LEFT BANNER
                          SizedBox(width: 2.w),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _showFullImage(context, AssetImages.banner2);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: Image.asset(
                                  AssetImages.banner2,
                                  height: 160.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 12.w),

                          Column(
                            crossAxisAlignment: .start,

                            children: [
                              if (productList.length > 11)
                                _dynamicServiceItem(
                                  context,
                                  productList[11],
                                  11, // Payment Status
                                ),

                              // SizedBox(height: 20.h),
                              if (productList.length > 10)
                                _dynamicServiceItem(
                                  context,
                                  productList[10]..name = 'Refresh',
                                  10, // DTH Refresh
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
          );
        }),
      ),
    );
  }

  void _showFullImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (_) {
        return GestureDetector(
          onTap: () => Get.back(),
          child: Center(
            child: Hero(
              tag: imagePath,
              child: Image.asset(
                imagePath, // ✅ FIX HERE
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  /// DYNAMIC ITEM
  Widget _dynamicServiceItem(BuildContext context, Data item, [int index = 0]) {
    return _serviceItem(
      context,
      item.name ?? "",
      _getImage(item.name ?? ""),
      // _getBgColor(item.name ?? ""),
      [AppColors.box1, AppColors.box2, AppColors.box3, AppColors.box4][index %
          4],
      onTap: () {
        _handleNavigation(item);
      },
    );
  }

  /// COMMON SERVICE ITEM
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
            spacing: 4,
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
                    mainAxisSize: .min,
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

  /// IMAGE MAP
  String _getImage(String name) {
    switch (name.toLowerCase()) {
      case 'prepaid':
        return AssetImages.prepaid;

      case 'postpaid':
        return AssetImages.prepaid;

      case 'dth':
        return AssetImages.dth;

      case 'fastag':
        return AssetImages.fastag;

      case 'gas':
        return AssetImages.gas;

      case 'electricity':
        return AssetImages.promoFrame;

      case 'water':
        return AssetImages.water;

      case 'landline':
        return AssetImages.landline;

      case 'broadband':
        return AssetImages.broadband;

      case 'cabletv': // API returns CableTV
        return AssetImages.statement;

      case 'payment status':
        return AssetImages.paymentStatus;
      case 'p - status':
        return AssetImages.paymentStatus;

      case 'refresh':
        return AssetImages.dthRefresh;

      case 'dth refresh':
        return AssetImages.dthRefresh;

      default:
        return AssetImages.prepaid;
    }
  }

  /// COLOR MAP
  Color _getBgColor(String name) {
    switch (name.toLowerCase()) {
      case 'prepaid':
        return AppColors.box1;

      case 'postpaid':
        return AppColors.box1;

      case 'dth':
        return AppColors.box2;

      case 'fastag':
        return AppColors.box3;

      case 'gas':
        return AppColors.box4;

      case 'electricity':
        return AppColors.box3;

      case 'water':
        return AppColors.box4;

      case 'landline':
        return AppColors.box3;

      case 'broadband':
        return AppColors.box2;

      case 'cable tv':
        return AppColors.box1;
      case 'refresh':
        return AppColors.box3;

      default:
        return AppColors.box1;
    }
  }

  /// NAVIGATION
  void _handleNavigation(Data item) {
    switch (item.name?.toLowerCase()) {
      case 'prepaid':
        Get.toNamed(
          AppRoutes.prepaid,

          arguments: {
            "productId": item.id.toString(),
            "productName": item.name ?? "",
          },
        );

        break;

      // case 'postpaid':

      //   Get.to(
      //     () => MobileRechargePage(
      //       productId: item.id.toString(),
      //       productName: item.name ?? "",
      //     ),
      //   );

      //   break;

      case 'dth':
       print("MENU SCREEN ID = ${item.id}");

        Get.toNamed(
          
          AppRoutes.dth,

        arguments: {
          "productId": item.id.toString(),
          "productName": item.name ?? "",
        },
      );


      break;
       case 'payment status':

        Get.toNamed(
        AppRoutes.paymentstatus,

        arguments: {
          "productId": item.id.toString(),
          "productName": item.name ?? "",
        },
      );


      default:
        break;
    }
  }
}
