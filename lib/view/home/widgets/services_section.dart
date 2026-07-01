import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxpay/controllers/banner_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/menu_controlller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/core/constants/extension.dart';
import '../../../core/data/model/product_type.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final ServiceController controller = Get.put(
    ServiceController(productTypeUseCase: sl()),
  );
  final HomePageController homeController = Get.find<HomePageController>();
  final BannerController bannerController = Get.put(
    BannerController(bannerUsecase: sl(), advusecase: sl()),
  );

  /// ✅ SAFE URL HELPER — handles both full URLs and relative paths
  String _toImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";
    if (path.startsWith("http://") || path.startsWith("https://")) {
      return path; // Already full URL, return as-is
    }
    return path.addToBase(); // Relative path, add base
  }

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
                              final balance =
                                  Get.find<HomePageController>()
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
                      Obx(() {
                        final list =
                            bannerController.bannerData.value?.data ?? [];

                        if (bannerController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (list.isEmpty) return const SizedBox.shrink();

                        return Column(
                          children: [
                            SizedBox(
                              height: 150.h,
                              child: PageView.builder(
                                controller: bannerController.pageController,
                                itemCount: list.length,
                                onPageChanged: (index) {
                                  bannerController.currentIndex.value = index;
                                },
                                itemBuilder: (context, index) {
                                  /// ✅ FIXED: using _toImageUrl
                                  final imageUrl =
                                      _toImageUrl(list[index].image);
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, _, _) => Container(
                                        color: Colors.grey.shade300,
                                        child: const Icon(Icons.broken_image),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Obx(() {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    List.generate(list.length, (index) {
                                  final isActive =
                                      bannerController.currentIndex.value ==
                                          index;
                                  return AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 300),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    height: 6.w,
                                    width: isActive ? 18.w : 6.w,
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? AppColors.clrPrimary
                                          : Colors.grey.shade400,
                                      borderRadius:
                                          BorderRadius.circular(20.r),
                                    ),
                                  );
                                }),
                              );
                            }),
                          ],
                        );
                      }),

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

                      /// ✅ SMART LAYOUT: Ad = Image1, No Ad = Image2
                      Obx(() {
                        final advList = bannerController
                                .advdata.value?.data?.advertisements ??
                            [];
                        final hasAdImage = advList.isNotEmpty &&
                            (advList.first.adImage ?? "").isNotEmpty;

                        if (hasAdImage) {
                          return _buildLayoutWithAds(
                              context, productList, advList);
                        } else {
                          return _buildCleanGrid(context, productList);
                        }
                      }),

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

  /// ✅ IMAGE 1 LAYOUT — with ad banners between icons
  Widget _buildLayoutWithAds(
      BuildContext context, List<Data> productList, List advList) {
    /// ✅ FIXED: using _toImageUrl instead of .addToBase()
    final adImageUrl = _toImageUrl(advList.first.adImage);

    return Column(
      children: [
        /// ROW 1: icons 0,1,2,3
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

        /// ROW 2: icons 4,5 + CENTER AD
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                if (productList.length > 4)
                  _dynamicServiceItem(context, productList[4], 4),
                if (productList.length > 5)
                  _dynamicServiceItem(context, productList[5], 5),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SizedBox(
                height: 160.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    adImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 10.h),

        /// ROW 3: icons 6,7,8,9
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

        /// ROW 4: LEFT AD + icons 11,10
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _showFullImage(context, adImageUrl),
                child: SizedBox(
                  height: 160.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      adImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (productList.length > 11)
                  _dynamicServiceItem(context, productList[11], 11),
                if (productList.length > 10)
                  _dynamicServiceItem(
                    context,
                    productList[10]..name = 'Refresh',
                    10,
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// ✅ IMAGE 2 LAYOUT — clean 4-column grid
  Widget _buildCleanGrid(BuildContext context, List<Data> productList) {
    if (productList.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Text(
            "No services found",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return _dynamicServiceItem(context, productList[index], index);
      },
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (_) {
        return GestureDetector(
          onTap: () => Get.back(),
          child: Center(
            child: Hero(
              tag: imageUrl,
              child: InteractiveViewer(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dynamicServiceItem(BuildContext context, Data item,
      [int index = 0]) {
    return _serviceItem(
      context,
      item.name ?? "",
      _getImage(item.name ?? ""),
      [AppColors.box1, AppColors.box2, AppColors.box3, AppColors.box4][index % 4],
      onTap: () => _handleNavigation(item),
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
      case 'cabletv':
        return AssetImages.cable;
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
        break;

      default:
        break;
    }
  }
}