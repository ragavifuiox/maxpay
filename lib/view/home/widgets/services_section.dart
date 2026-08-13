import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:maxpay/controllers/banner_controller.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/menu_controlller.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';

import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/constants/extension.dart';

import 'package:maxpay/view/broadband/broad_band_page.dart';
import 'package:maxpay/view/cabletv/cable_tv_page.dart';
import 'package:maxpay/view/electricity_bill/electricity_bill_page.dart';
import 'package:maxpay/view/fastag_recharge/fastag_recharge_page.dart';
import 'package:maxpay/view/gas_bill/gas_bill_page.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/view/landline/landline_bill_page.dart';
import 'package:maxpay/view/postpaid/postpaid_page.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';
import 'package:maxpay/view/water/watter_bill.dart';

import '../../../core/data/model/advertisement_model.dart' hide Data;
import '../../../core/data/model/product_type.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  // ============================================================
  // CONTROLLERS
  // ============================================================

  final ServiceController controller = Get.put(
    ServiceController(
      productTypeUseCase: sl(),
      todayTrnsactionUsecase: sl(),
    ),
  );

  final HomePageController homeController =
      Get.find<HomePageController>();

  final BannerController bannerController = Get.put(
    BannerController(
      bannerUsecase: sl(),
      advusecase: sl(),
    ),
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

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> _refreshPage() async {
    await Future.wait([
      controller.fetchProductTypes(),
    ]);
  }

  // ============================================================
  // IMAGE URL
  // ============================================================

  String _toImageUrl(String? path) {
    if (path == null || path.trim().isEmpty) {
      return "";
    }

    final formattedPath = path.trim().replaceAll(' ', '%20');

    if (formattedPath.startsWith("http://") ||
        formattedPath.startsWith("https://")) {
      return formattedPath;
    }

    return formattedPath.addToBase();
  }

  // ============================================================
  // CHECK VALID AD
  // ============================================================

  bool _hasValidAd(Advertisements ad) {
    final displayImage = ad.displayImage?.trim() ?? "";
    final adImage = ad.adImage?.trim() ?? "";

    return displayImage.isNotEmpty || adImage.isNotEmpty;
  }

  // ============================================================
  // BUILD
  // ============================================================

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
          // ======================================================
          // PRODUCT LOADING
          // ======================================================

          if (controller.isProductLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final productList =
              controller.productTypeData.value?.data ?? [];

          return RefreshIndicator(
            onRefresh: _refreshPage,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // ==================================================
                  // HEADER
                  // ==================================================

                  const HomeHeaderSection(),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==================================================
                        // WALLET
                        // ==================================================

                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 18.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.clrPrimary,
                            borderRadius:
                                BorderRadius.circular(14.r),
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
                                  balance
                                          ?.data
                                          ?.balance
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

                        // ==================================================
                        // TOP BANNER
                        // ==================================================

                        Obx(() {
                          final list =
                              bannerController
                                      .bannerData
                                      .value
                                      ?.data ??
                                  [];

                          if (bannerController.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (list.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return SizedBox(
                            height: 150.h,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Obx(() {
                                  final currentIndex =
                                      bannerController
                                          .currentIndex
                                          .value;

                                  final currentList =
                                      bannerController
                                              .bannerData
                                              .value
                                              ?.data ??
                                          [];

                                  if (currentList.isEmpty) {
                                    return const SizedBox.shrink();
                                  }

                                  if (currentIndex >=
                                      currentList.length) {
                                    return const SizedBox.shrink();
                                  }

                                  final imageUrl = _toImageUrl(
                                    currentList[currentIndex].image,
                                  );

                                  if (imageUrl.isEmpty) {
                                    return const SizedBox.shrink();
                                  }

                                  return AnimatedSwitcher(
                                    duration: const Duration(
                                      milliseconds: 600,
                                    ),
                                    child: ClipRRect(
                                      key: ValueKey(currentIndex),
                                      borderRadius:
                                          BorderRadius.circular(16.r),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150.h,
                                        errorBuilder:
                                            (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                  );
                                }),

                                PageView.builder(
                                  controller: bannerController
                                      .pageController,
                                  itemCount: list.length,
                                  onPageChanged: (index) {
                                    bannerController
                                        .currentIndex
                                        .value = index;

                                    bannerController.startAutoSlide();
                                  },
                                  itemBuilder: (
                                    context,
                                    index,
                                  ) {
                                    return const SizedBox.expand();
                                  },
                                ),
                              ],
                            ),
                          );
                        }),

                        SizedBox(height: 10.h),

                        // ==================================================
                        // TRANSACTION TITLE
                        // ==================================================

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.clrPrimary,
                                thickness: 1.2,
                              ),
                            ),
                            SizedBox(width: 8.w),
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

                        // ==================================================
                        // TRANSACTION CARDS
                        // ==================================================

                        Obx(() {
                          final transaction =
                              controller.todaytrans.value?.data;

                          return Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => const TransactionScreen(
                                        status:
                                            TransactionStatus.success,
                                      ),
                                    );
                                  },
                                  child: _statusCard(
                                    image:
                                        AssetImages.successIcon,
                                    value:
                                        "${transaction?.successCount ?? 0}",
                                    bgColor:
                                        const Color(0xffC0FFDF),
                                    textColor:
                                        const Color(0xff22C55E),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => const TransactionScreen(
                                        status:
                                            TransactionStatus.pending,
                                      ),
                                    );
                                  },
                                  child: _statusCard(
                                    image:
                                        AssetImages.processIcon,
                                    value:
                                        "${transaction?.processingCount ?? 0}",
                                    bgColor:
                                        const Color(0xffFFE1B4),
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
                                        status:
                                            TransactionStatus.failed,
                                      ),
                                    );
                                  },
                                  child: _statusCard(
                                    image:
                                        AssetImages.failedIcon,
                                    value:
                                        "${transaction?.failedCount ?? 0}",
                                    bgColor:
                                        const Color(0xffFFCCD3),
                                    textColor: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),

                        SizedBox(height: 18.h),

                        // ==================================================
                        // SERVICES TITLE
                        // ==================================================

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

                        // ==================================================
                        // ADVERTISEMENT + SERVICES
                        // ==================================================

                        Obx(() {
                          final allAds =
                              bannerController
                                      .advdata
                                      .value
                                      ?.data
                                      ?.advertisements ??
                                  [];

                          log("================================");
                          log("ADVERTISEMENT DATA");
                          log("TOTAL ADS : ${allAds.length}");

                          for (final ad in allAds) {
                            log("--------------------------------");
                            log(
                              "imageScreen : ${ad.imageScreen}",
                            );
                            log(
                              "displayImage : ${ad.displayImage}",
                            );
                            log("adImage : ${ad.adImage}");
                          }

                          // ==================================================
                          // FILTER VALID ADS
                          // ==================================================

                          final validAds =
                              allAds.where(_hasValidAd).toList();

                          // ==================================================
                          // IMPORTANT:
                          // KEEP ALL UP ADS
                          // KEEP ALL DOWN ADS
                          // ==================================================

                          final List<Advertisements> upAds = [];

                          final List<Advertisements> downAds = [];

                          for (final ad in validAds) {
                            final screen =
                                (ad.imageScreen ?? "")
                                    .trim()
                                    .toLowerCase();

                            if (screen == "up") {
                              upAds.add(ad);
                            }

                            if (screen == "down") {
                              downAds.add(ad);
                            }
                          }

                          log(
                            "TOTAL UP ADS : ${upAds.length}",
                          );

                          log(
                            "TOTAL DOWN ADS : ${downAds.length}",
                          );

                          // ==================================================
                          // BUILD SERVICES
                          // ==================================================

                          return _buildServicesWithAdSlots(
                            context,
                            productList,
                            upAds,
                            downAds,
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

  // ============================================================
  // SERVICES + AD SLOTS
  // ============================================================

  Widget _buildServicesWithAdSlots(
    BuildContext context,
    List<Data> productList,
    List<Advertisements> upAds,
    List<Advertisements> downAds,
  ) {
    return Column(
      children: [
        // ========================================================
        // FIRST 4 SERVICES
        // ========================================================

        _buildFirstFourServices(
          context,
          productList,
        ),

        SizedBox(height: 18.h),

        // ========================================================
        // UP SLOT
        //
        // SERVICE LEFT
        // AD RIGHT
        // ========================================================

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                if (productList.length > 4)
                  _dynamicServiceItem(
                    context,
                    productList[4],
                    4,
                  ),

                if (productList.length > 5)
                  _dynamicServiceItem(
                    context,
                    productList[5],
                    5,
                  ),
              ],
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: upAds.isNotEmpty
                  ? _buildAdCarousel(
                      context,
                      upAds,
                      "UP",
                    )
                  : _buildPlaceholderCard(),
            ),
          ],
        ),

        SizedBox(height: 18.h),

        // ========================================================
        // NEXT 4 SERVICES
        // ========================================================

        _buildFourServicesAt(
          context,
          productList,
          6,
        ),

        SizedBox(height: 18.h),

        // ========================================================
        // DOWN SLOT
        //
        // AD LEFT
        // SERVICE RIGHT
        //
        // IMPORTANT:
        // DON'T HIDE THE SLOT WHEN PRODUCT 10/11 IS MISSING
        // ========================================================

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: downAds.isNotEmpty
                  ? _buildAdCarousel(
                      context,
                      downAds,
                      "DOWN",
                    )
                  : _buildPlaceholderCard(),
            ),

            SizedBox(width: 12.w),

            Column(
              children: [
                if (productList.length > 10)
                  _dynamicServiceItem(
                    context,
                    productList[10],
                    10,
                  ),

                if (productList.length > 11)
                  _dynamicServiceItem(
                    context,
                    productList[11],
                    11,
                  ),
              ],
            ),
          ],
        ),

        SizedBox(height: 18.h),

        // ========================================================
        // REMAINING SERVICES
        // ========================================================

        _buildRemainingServices(
          context,
          productList,
          12,
        ),
      ],
    );
  }

  // ============================================================
  // AD CAROUSEL
  //
  // ALL BACKEND ADS WILL BE SHOWN HERE
  //
  // USER CAN SWIPE LEFT / RIGHT
  //
  // DISPLAY IMAGE IS SHOWN
  //
  // CLICK DISPLAY IMAGE
  // -> OPEN CORRESPONDING AD IMAGE
  // ============================================================

  Widget _buildAdCarousel(
    BuildContext context,
    List<Advertisements> ads,
    String position,
  ) {
    if (ads.isEmpty) {
      return _buildPlaceholderCard();
    }

    return SizedBox(
      height: 160.h,
      width: double.infinity,
      child: Stack(
        children: [
          // ======================================================
          // PAGE VIEW
          // ======================================================

          PageView.builder(
            itemCount: ads.length,

            // ==================================================
            // HORIZONTAL SWIPE
            // ==================================================

            scrollDirection: Axis.horizontal,

            itemBuilder: (
              context,
              index,
            ) {
              final ad = ads[index];

              final displayImage =
                  (ad.displayImage ?? "").trim();

              final adImage =
                  (ad.adImage ?? "").trim();

              // ==================================================
              // DISPLAY IMAGE PRIORITY
              //
              // displayImage first
              // if empty use adImage
              // ==================================================

              final image = displayImage.isNotEmpty
                  ? displayImage
                  : adImage;

              if (image.isEmpty) {
                return _buildPlaceholderCard();
              }

              final imageUrl = _toImageUrl(image);

              if (imageUrl.isEmpty) {
                return _buildPlaceholderCard();
              }

              log(
                "$position AD [$index] DISPLAY : $imageUrl",
              );

              return InkWell(
                borderRadius:
                    BorderRadius.circular(8.r),

                // ==================================================
                // CLICK CURRENT AD
                // ==================================================

                onTap: () {
                  // ================================================
                  // OPEN CURRENT AD'S adImage
                  // ================================================

                  if (adImage.isEmpty) {
                    log(
                      "$position AD [$index] has no adImage",
                    );
                    return;
                  }

                  final fullImageUrl =
                      _toImageUrl(adImage);

                  if (fullImageUrl.isEmpty) {
                    return;
                  }

                  log(
                    "$position AD [$index] OPEN : $fullImageUrl",
                  );

                  _showFullImage(
                    context,
                    [fullImageUrl],
                    0,
                  );
                },

                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8.r),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 160.h,
                    fit: BoxFit.cover,

                    // ==================================================
                    // IMAGE ERROR
                    // ==================================================

                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      log(
                        "$position AD [$index] ERROR : $error",
                      );

                      return _buildPlaceholderCard();
                    },
                  ),
                ),
              );
            },
          ),
        if (ads.length > 1)
            Positioned(
              bottom: 8.h,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: List.generate(
                    ads.length,
                    (index) {
                      return Container(
                        width: 6.w,
                        height: 6.w,
                        margin: EdgeInsets.symmetric(
                          horizontal: 3.w,
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }

  // ============================================================
  // PLACEHOLDER
  // ============================================================

  Widget _buildPlaceholderCard() {
    return Container(
      height: 160.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.clrPrimary,
        borderRadius:
            BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your AD Here",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Please Contact",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FIRST 4 SERVICES
  // ============================================================

  Widget _buildFirstFourServices(
    BuildContext context,
    List<Data> productList,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        if (productList.length > 0)
          _dynamicServiceItem(
            context,
            productList[0],
            0,
          ),
        if (productList.length > 1)
          _dynamicServiceItem(
            context,
            productList[1],
            1,
          ),
        if (productList.length > 2)
          _dynamicServiceItem(
            context,
            productList[2],
            2,
          ),
        if (productList.length > 3)
          _dynamicServiceItem(
            context,
            productList[3],
            3,
          ),
      ],
    );
  }

  // ============================================================
  // FOUR SERVICES
  // ============================================================

  Widget _buildFourServicesAt(
    BuildContext context,
    List<Data> productList,
    int startIndex,
  ) {
    if (productList.length <= startIndex) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        for (
          int i = startIndex;
          i < startIndex + 4 &&
              i < productList.length;
          i++
        )
          _dynamicServiceItem(
            context,
            productList[i],
            i,
          ),
      ],
    );
  }

  // ============================================================
  // REMAINING SERVICES
  // ============================================================

  Widget _buildRemainingServices(
    BuildContext context,
    List<Data> productList,
    int startIndex,
  ) {
    if (productList.length <= startIndex) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemCount:
          productList.length - startIndex,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (
        context,
        index,
      ) {
        final actualIndex =
            startIndex + index;

        return _dynamicServiceItem(
          context,
          productList[actualIndex],
          actualIndex,
        );
      },
    );
  }

  // ============================================================
  // FULL IMAGE
  // ============================================================

  void _showFullImage(
    BuildContext context,
    List<String> imageUrls,
    int initialIndex,
  ) {
    final pageController =
        PageController(
      initialPage: initialIndex,
    );

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
                  controller:
                      pageController,
                  itemCount:
                      imageUrls.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return InteractiveViewer(
                      child: Center(
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),

                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
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

  // ============================================================
  // SERVICE ITEM
  // ============================================================

  Widget _dynamicServiceItem(
    BuildContext context,
    Data item, [
    int index = 0,
  ]) {
    return _serviceItem(
      context,
      item.name ?? "",
      _getImage(item.name ?? ""),
      [
        AppColors.box1,
        AppColors.box2,
        AppColors.box3,
        AppColors.box4,
      ][index % 4],
      onTap: () {
        _handleNavigation(item);
      },
    );
  }

  // ============================================================
  // SERVICE UI
  // ============================================================

  Widget _serviceItem(
    BuildContext context,
    String title,
    String image,
    Color bgColor, {
    VoidCallback? onTap,
  }) {
    final theme =
        Theme.of(context);

    String displayTitle = title;

    if (title.toLowerCase() ==
        "payment status") {
      displayTitle =
          "Payment\nStatus";
    } else if (title.toLowerCase() ==
        "bbps") {
      displayTitle = "BBPS";
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(14.r),
        onTap: onTap,
        child: Padding(
          padding:
              EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                padding: EdgeInsets.all(
                  displayTitle == "BBPS"
                      ? 12.w
                      : 4.w,
                ),
                decoration:
                    BoxDecoration(
                  color: bgColor,
                  borderRadius:
                      BorderRadius.circular(
                    14.r,
                  ),
                ),
                child: Center(
                  child: image
                          .toLowerCase()
                          .endsWith(
                            '.svg',
                          )
                      ? SvgPicture.asset(
                          image,
                          fit: BoxFit.contain,
                        )
                      : Image.asset(
                          image,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              SizedBox(height: 4.h),
              SizedBox(
                width: 70.w,
                child: Text(
                  displayTitle,
                  textAlign:
                      TextAlign.center,
                  maxLines: 2,
                  overflow:
                      TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight:
                        FontWeight.w500,
                    color: theme
                        .colorScheme
                        .onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NORMALIZE
  // ============================================================

  String _normalize(
    String name,
  ) {
    return name
        .toLowerCase()
        .replaceAll(
          RegExp(r'[\s\-]+'),
          '',
        );
  }

  // ============================================================
  // SERVICE IMAGE
  // ============================================================

  String _getImage(
    String name,
  ) {
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

      case 'cabletv':
        return AssetImages.cable;

      case 'paymentstatus':
      case 'pstatus':
        return AssetImages.paymentStatus;

      case 'bbps':
        return AssetImages.bbps;

      default:
        return AssetImages.prepaid;
    }
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _handleNavigation(
    Data item,
  ) {
    final key =
        _normalize(item.name ?? "");

    switch (key) {
      case 'prepaid':
        Get.toNamed(
          AppRoutes.prepaid,
          arguments: {
            "productId":
                item.id.toString(),
            "productName":
                item.name ?? "",
          },
        );
        break;

      case 'dth':
        Get.toNamed(
          AppRoutes.dth,
          arguments: {
            "productId":
                item.id.toString(),
            "productName":
                item.name ?? "",
          },
        );
        break;

      case 'paymentstatus':
        Get.toNamed(
          AppRoutes.paymentstatus,
          arguments: {
            "productId":
                item.id.toString(),
            "productName":
                item.name ?? "",
          },
        );
        break;

      case 'fastag':
        Get.to(
          () =>
              const FastagRechargePage(),
        );
        break;

      case 'water':
        Get.to(
          () => const WatterBill(),
        );
        break;

      case 'gas':
        Get.to(
          () => const GasBillPage(),
        );
        break;

      case 'electricity':
        Get.to(
          () =>
              const ElectricityBillPage(),
        );
        break;

      case 'broadband':
        Get.to(
          () =>
              const BroadBandPage(),
        );
        break;

      case 'cabletv':
        Get.to(
          () => const CableTvPage(),
        );
        break;

      case 'postpaid':
        Get.to(
          () => const PostpaidPage(),
        );
        break;

      case 'bbps':
        break;

      case 'landline':
        Get.to(
          () =>
              const LandlineBillPage(),
        );
        break;

      default:
        log(
          "No navigation mapped for product: ${item.name}",
        );
        break;
    }
  }

  // ============================================================
  // STATUS CARD
  // ============================================================

  Widget _statusCard({
    required String image,
    required String value,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      height: 52.h,
      decoration:
          BoxDecoration(
        color: bgColor,
        borderRadius:
            BorderRadius.circular(
          12.r,
        ),
        border: Border.all(
          color:
              AppColors.clrPrimary,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(width: 8.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight:
                  FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}