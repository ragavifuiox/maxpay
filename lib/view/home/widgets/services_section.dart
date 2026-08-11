import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxpay/controllers/banner_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/menu_controlller.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/view/broadband/broad_band_page.dart';
import 'package:maxpay/view/cabletv/cable_tv_page.dart';
import 'package:maxpay/view/dth_refresh/dth_refresh_page.dart';
import 'package:maxpay/view/electricity_bill/electricity_bill_page.dart';
import 'package:maxpay/view/fastag_recharge/fastag_recharge_page.dart';
import 'package:maxpay/view/gas_bill/gas_bill_page.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/core/constants/extension.dart';
import 'package:maxpay/view/landline/landline_bill_page.dart';
import 'package:maxpay/view/postpaid/postpaid_page.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';
import 'package:maxpay/view/water/watter_bill.dart';
import '../../../core/data/model/product_type.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final ServiceController controller = Get.put(
    ServiceController(productTypeUseCase: sl(), todayTrnsactionUsecase: sl()),
  );
  final HomePageController homeController = Get.find<HomePageController>();
  final BannerController bannerController = Get.put(
    BannerController(bannerUsecase: sl(), advusecase: sl()),
  );
  final TransReportController transReportController = Get.put(
    TransReportController(
      cashbackTypeUsecase: sl(),
      transreportUsecase: sl(),
      producttypeUseCase: sl(),
      submitDisputeUsecase: sl(),

      totalTransactionUsecase: sl(),
    ),
  );

  Future<void> _refreshPage() async {
    await Future.wait([
      controller.fetchProductTypes(),
      controller.fetchtodaytrnas(),
      homeController.fetchWalletBalance(),
      bannerController.fetchbanner(),
      bannerController.fetchadv(),
    ]);
  }


  String _toImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";

    
    String formattedPath = path.replaceAll(' ', '%20');

    if (formattedPath.startsWith("http://") ||
        formattedPath.startsWith("https://")) {
      return formattedPath; 
    }
    return formattedPath.addToBase(); 
  }


  Widget _imageLoadingPlaceholder({
    double? height,
    double? width,
    BorderRadius? borderRadius,
  }) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: AppColors.clrPrimary,
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Image Loading ...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16.w),
           
              SvgPicture.asset(
                AssetImages.loadingImage,
                width: 34.w,
                height: 34.w,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ PLACEHOLDER — shown when there is no advertisement/display image
  Widget _adPlaceholder({
    double? height,
    double? width,
    BorderRadius? borderRadius,
  }) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: AppColors.clrPrimary,
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your AD Here",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Please Contact",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              // ✅ SVG "no ad" icon — replace AssetImages.adPlaceholderImage
              // with your actual svg asset key/path (also add it in
              // AssetImages and register it under `assets:` in pubspec.yaml).
              SvgPicture.asset(
                AssetImages.loadingImage,
                width: 34.w,
                height: 34.w,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Wraps Image.network with a loading placeholder + graceful fallback
  /// to the "Your Ad Here" placeholder if the url is empty or fails to load.
  Widget _networkImageWithStates({
    required String imageUrl,
    required double height,
    BorderRadius? borderRadius,
    bool isAdSlot = false,
  }) {
    if (imageUrl.isEmpty) {
      return isAdSlot
          ? _adPlaceholder(height: height, borderRadius: borderRadius)
          : _imageLoadingPlaceholder(
              height: height,
              borderRadius: borderRadius,
            );
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _imageLoadingPlaceholder(
          height: height,
          borderRadius: borderRadius,
        );
      },
      errorBuilder: (_, __, ___) => isAdSlot
          ? _adPlaceholder(height: height, borderRadius: borderRadius)
          : Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: borderRadius ?? BorderRadius.circular(16.r),
              ),
              child: const Icon(Icons.broken_image),
            ),
    );
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
          if (controller.isProductLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final productList = controller.productTypeData.value?.data ?? [];

          return RefreshIndicator(
            onRefresh: _refreshPage,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                                  balance?.data?.balance
                                          ?.toString()
                                          .currencyIndian ??
                                      '0.00',
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
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (list.isEmpty) return const SizedBox.shrink();

                          return Column(
                            children: [
                              SizedBox(
                                height: 150.h,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    // 1. VISUAL LAYER (Fading Animation)
                                    Obx(() {
                                      final currentIndex =
                                          bannerController.currentIndex.value;
                                      final list =
                                          bannerController
                                              .bannerData
                                              .value
                                              ?.data ??
                                          [];

                                      if (list.isEmpty)
                                        return const SizedBox.shrink();

                                      final imageUrl = _toImageUrl(
                                        list[currentIndex].image,
                                      );

                                      return AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 600,
                                        ),
                                        transitionBuilder: (child, animation) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                        child: ClipRRect(
                                          key: ValueKey<int>(currentIndex),
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                          child: _networkImageWithStates(
                                            imageUrl: imageUrl,
                                            height: 150.h,
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),

                                    // 2. GESTURE LAYER (Native PageView)
                                    // This intercepts swipe gestures correctly without interfering with vertical scroll
                                    PageView.builder(
                                      controller:
                                          bannerController.pageController,
                                      itemCount: list.length,
                                      onPageChanged: (index) {
                                        bannerController.currentIndex.value =
                                            index;
                                        bannerController
                                            .startAutoSlide(); // Reset timer on manual swipe
                                      },
                                      itemBuilder: (context, index) {
                                        // Invisible widget to capture gestures
                                        return const SizedBox.expand();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),

                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.clrPrimary,
                                thickness: 1.2,
                              ),
                            ),
                            Text(
                              "No of Today Transations",
                              style: TextStyle(
                                color: AppColors.clrPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],
                        ),

                        const SizedBox(height: 12),

                        /// STATUS CARDS
                        Obx(() {
                          final transaction = controller.todaytrans.value?.data;

                          return Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => const TransactionScreen(
                                        status: TransactionStatus.success,
                                      ),
                                    );
                                  },
                                  child: _statusCard(
                                    image: AssetImages.successIcon,
                                    value: "${transaction?.successCount ?? 0}",
                                    bgColor: const Color(0xffC0FFDF),
                                    textColor: const Color(0xff22C55E),
                                  ),
                                ),
                              ),

                              SizedBox(width: 12.w),

                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => const TransactionScreen(
                                        status: TransactionStatus.pending,
                                      ),
                                    );
                                  },
                                  child: _statusCard(
                                    image: AssetImages.processIcon,
                                    value:
                                        "${transaction?.processingCount ?? 0}",
                                    bgColor: const Color(0xffFFE1B4),
                                    textColor: Colors.orange,
                                  ),
                                ),
                              ),

                              SizedBox(width: 12.w),

                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => const TransactionScreen(
                                        status: TransactionStatus.failed,
                                      ),
                                    );
                                  },
                                  child: _statusCard(
                                    image: AssetImages.failedIcon,
                                    value: "${transaction?.failedCount ?? 0}",
                                    bgColor: const Color(0xffFFCCD3),
                                    textColor: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),

                        SizedBox(height: 18.h),

                        /// SERVICES TITLE
                        Row(
                          children: [
                            Text(
                              "Services",
                              style: TextStyle(
                                color: AppColors.clrPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Divider(
                                color: AppColors.clrPrimary,
                                thickness: 1.2,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        /// ✅ LAYOUT: icon rows + 2 ad slots.
                        /// Ad slots always occupy the same position — when the
                        /// backend returns no ad/display image, the slot shows
                        /// the "Your Ad Here" placeholder instead of an image.
                        Obx(() {
                          final advList =
                              bannerController
                                  .advdata
                                  .value
                                  ?.data
                                  ?.advertisements ??
                              [];

                          return _buildLayoutWithAds(
                            context,
                            productList,
                            advList,
                            bannerController.currentAdvIndex.value,
                          );
                        }),

                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLayoutWithAds(
    BuildContext context,
    List<Data> productList,
    List advList,
    int currentIndex,
  ) {
    // ✅ No early return here anymore — the icon grid + ad slots must render
    // even when advList is empty. The two slots below just fall back to the
    // "Your Ad Here" placeholder when there's no data/image for them.
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

    // Use current index to animate ads. Ad 1 gets current index, Ad 2 gets the prior index
    // so they are usually different if there's more than 1 ad.
    final ad1Index = advList.isEmpty ? 0 : currentIndex % advList.length;
    final ad2Index = advList.isEmpty ? 0 : (currentIndex + 1) % advList.length;

    final adImageUrl1 = advList.isEmpty
        ? ""
        : _toImageUrl(advList[ad1Index].displayImage);
    final adImageUrl2 = advList.isEmpty
        ? ""
        : _toImageUrl(advList[ad2Index].adImage);

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
              child: InkWell(
                onTap: adImageUrl1.isEmpty
                    ? null
                    : () {
                        final urls = advList
                            .map((e) => _toImageUrl(e.displayImage))
                            .toList();
                        _showFullImage(context, urls, ad1Index);
                      },
                child: SizedBox(
                  height: 160.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: KeyedSubtree(
                        key: ValueKey<String>(adImageUrl1),
                        child: _networkImageWithStates(
                          imageUrl: adImageUrl1,
                          height: 160.h,
                          borderRadius: BorderRadius.circular(16.r),
                          isAdSlot: true,
                        ),
                      ),
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
                onTap: adImageUrl2.isEmpty
                    ? null
                    : () {
                        final urls = advList
                            .map((e) => _toImageUrl(e.adImage))
                            .toList();
                        _showFullImage(context, urls, ad2Index);
                      },
                child: SizedBox(
                  height: 160.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: KeyedSubtree(
                        key: ValueKey<String>(adImageUrl2),
                        child: _networkImageWithStates(
                          imageUrl: adImageUrl2,
                          height: 160.h,
                          borderRadius: BorderRadius.circular(16.r),
                          isAdSlot: true,
                        ),
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

  void _showFullImage(
    BuildContext context,
    List<String> imageUrls,
    int initialIndex,
  ) {
    final PageController controller = PageController(initialPage: initialIndex);

    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    final imageUrl = imageUrls[index];

                    return InteractiveViewer(
                      child: Center(
                        child: Image.network(imageUrl, fit: BoxFit.contain),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dynamicServiceItem(BuildContext context, Data item, [int index = 0]) {
    return _serviceItem(
      context,
      item.name ?? "",
      _getImage(item.name ?? ""),
      _getBgColor(item.name ?? ""),
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

  /// ✅ Normalizes product names so matching is consistent everywhere
  /// (strips spaces/dashes, lowercases) — "Cable TV", "CableTV", "cable-tv"
  /// all become "cabletv".
  String _normalize(String name) =>
      name.toLowerCase().replaceAll(RegExp(r'[\s\-]+'), '');
  String _getImage(String name) {
    switch (_normalize(name)) {
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
      case 'cabletv': // now matches "Cable TV" too
        return AssetImages.cable;
      case 'paymentstatus':
      case 'pstatus':
        return AssetImages.paymentStatus;
      case 'refresh':
      case 'dthrefresh':
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
        return AppColors.box3;
      case 'dth':
        return AppColors.box2;
      case 'fastag':
        return AppColors.box2;
      case 'gas':
        return const Color.fromRGBO(255, 225, 180, 1);
      case 'electricity':
        return AppColors.box4;
      case 'water':
        return AppColors.box3;
      case 'landline':
        return AppColors.box2;
      case 'broadband':
        return AppColors.box3;
      case 'cable tv':
        return AppColors.box4;
      case 'refresh':
        return AppColors.box3;
      default:
        return AppColors.box1;
    }
  }

  void _handleNavigation(Data item) {
    final key = _normalize(item.name ?? "");

    switch (key) {
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
        Get.toNamed(
          AppRoutes.dth,
          arguments: {
            "productId": item.id.toString(),
            "productName": item.name ?? "",
          },
        );
        break;

      case 'paymentstatus':
        Get.toNamed(
          AppRoutes.paymentstatus,
          arguments: {
            "productId": item.id.toString(),
            "productName": item.name ?? "",
          },
        );
        break;

      case 'fastag':
        Get.to(() => const FastagRechargePage());
        break;

      case 'water':
        Get.to(() => const WatterBill());
        break;
      case '':
        Get.to(() => const WatterBill());
        break;

      case 'gas':
        Get.to(() => const GasBillPage());
        break;

      case 'electricity':
        Get.to(() => const ElectricityBillPage());
        break;

      case 'broadband':
        Get.to(() => const BroadBandPage());
        break;

      case 'cabletv': // ✅ fixed — was 'cable tv'
        Get.to(() => const CableTvPage());
        break;

      case 'postpaid': // ✅ fixed — was 'cable tv'
        Get.to(() => const PostpaidPage());
        break;
      case 'refresh':
      case 'dthrefresh': // ✅ fixed — now catches both spellings
        Get.to(() => const DthRefreshScreen());
        break;

      case 'landline': // ✅ fixed — now catches both spellings
        Get.to(() => const LandlineBillPage());
        break;
      default:
        log("No navigation mapped for product: ${item.name}");
        break;
    }
  }

  Widget _statusCard({
    required String image,
    required String value,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.clrPrimary, // Same border color for all cards
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image, width: 24.w, height: 24.h),
          SizedBox(width: 8.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
