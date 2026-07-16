import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/view/home/widgets/earnings_chart.dart';
import 'package:maxpay/view/home/widgets/home_header.dart';
import 'package:maxpay/view/home/widgets/news_ticker.dart';
import 'package:maxpay/view/home/widgets/stat_card.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';

class AnimatedBorderDotCard extends StatefulWidget {
  final Widget child;
  final bool isDark;
  const AnimatedBorderDotCard({
    super.key,
    required this.child,
    required this.isDark,
  });

  @override
  State<AnimatedBorderDotCard> createState() => _AnimatedBorderDotCardState();
}

class _AnimatedBorderDotCardState extends State<AnimatedBorderDotCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _BorderDotPainter(
            progress: _controller.value,
            isDark: widget.isDark,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _BorderDotPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _BorderDotPainter({required this.progress, required this.isDark});

  static const double _radius = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(_radius),
    );

    // 1. Faint dashed full border
    _drawDashedRRect(
      canvas,
      rrect,
      Paint()
        ..color = Colors.blue.withValues(alpha: 0.20)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
      dashLength: 6,
      gapLength: 4,
    );

    // 2. Thick trail from 0 → progress using PathMetric
    final Path fullPath = Path()..addRRect(rrect);
    final PathMetric metric = fullPath.computeMetrics().first;
    final double totalLen = metric.length;
    final double trailLen = progress * totalLen;

    if (trailLen > 0) {
      canvas.drawPath(
        metric.extractPath(0, trailLen),
        Paint()
          // ..color = const Color(0xFF2563EB).withOpacity(0.90)
          ..color = isDark ? Colors.white : AppColors.clrPrimary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }

    // 3. Dot at leading edge
    final Tangent? tangent = metric.getTangentForOffset(trailLen);
    if (tangent != null) {
      final Offset dot = tangent.position;

      // Glow
      canvas.drawCircle(
        dot,
        11,
        Paint()
          ..shader = RadialGradient(
            colors: [
              const Color(0xFF3B82F6).withValues(alpha: 0.50),
              const Color(0xFF3B82F6).withValues(alpha: 0.00),
            ],
          ).createShader(Rect.fromCircle(center: dot, radius: 11))
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );

      // White core
      canvas.drawCircle(
        dot,
        5,
        Paint()..color = isDark ? Colors.white : AppColors.clrPrimary,
      );

      // Blue ring
      canvas.drawCircle(
        dot,
        5,
        Paint()
          ..color = isDark ? Colors.white : AppColors.clrPrimary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
    }
  }

  void _drawDashedRRect(
    Canvas canvas,
    RRect rrect,
    Paint paint, {
    required double dashLength,
    required double gapLength,
  }) {
    final PathMetrics metrics = (Path()..addRRect(rrect)).computeMetrics();
    for (final PathMetric m in metrics) {
      double d = 0;
      bool draw = true;
      while (d < m.length) {
        final double len = draw ? dashLength : gapLength;
        if (draw) canvas.drawPath(m.extractPath(d, d + len), paint);
        d += len;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(_BorderDotPainter old) => old.progress != progress;
}

// ─────────────────────────────────────────────
// HOME PAGE SCREEN
// ─────────────────────────────────────────────
class HomePageScreen extends GetView<HomePageController> {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchpopupmessage("Home");
    });

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeaderSection(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EarningsChart(),
                    SizedBox(height: 8.h),

                    const NewsTicker(),
                    SizedBox(height: 2.h),

                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        clipBehavior: .none,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 8.h,
                        crossAxisSpacing: 8.w,
                        childAspectRatio: 1.05,
                        padding: EdgeInsets.zero,
                        children: [
                          StatCard(
                            onTap: () => Get.toNamed(AppRoutes.addwallet),
                            title: 'Add Wallet',
                            borderColor: isDark
                                ? AppColors.clrPrimary
                                : Color.fromRGBO(73, 91, 255, 0.4),

                            bgColor: AppColors.darkBlue.withValues(alpha: 0.04),
                            imageWidget: SvgPicture.asset(
                              AssetImages.addWallet,
                              height: 32.h,
                            ),
                          ),

                          Obx(() {
                            final balance =
                                controller.walletBalance.value?.data?.balance ??
                                0.0;
                            return StatCard(
                              title: 'Wallet Balance',
                              borderColor: isDark
                                  ? AppColors.clrPrimary
                                  : Color(0x66495BFF),
                              onTap: () => Get.toNamed(AppRoutes.walletbal),
                              value: '₹${balance.toStringAsFixed(2)}',
                              bgColor: AppColors.darkBlue.withValues(
                                alpha: 0.04,
                              ),
                              imageWidget: SvgPicture.asset(
                                AssetImages.walletBalance,
                              ),
                            );
                          }),

                          // ✅ TRANSACTIONS — animated border dot + zoom
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
                                valueColor: Colors.white,
                                borderColor:
                                    Colors.transparent, // Hide StatCard border
                                imageWidget: SvgPicture.asset(
                                  AssetImages.transactions,
                                  height: 32.h,
                                ),
                              ),
                            ),
                          ),

                          Obx(() {
                            final amount =
                                controller
                                    .todaycredit
                                    .value
                                    ?.code
                                    ?.todayCreditAmount ??
                                0;

                            return StatCard(
                              title: 'Todays Credit',
                              value: amount.toString().currencyIndian,
                              borderColor: isDark
                                  ? AppColors.clrPrimary
                                  : Color(0x66495BFF),
                              textColor:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const Color.fromARGB(255, 171, 171, 171)
                                  : AppColors.darktextclr,
                              bgColor: AppColors.darkBlue.withValues(
                                alpha: 0.04,
                              ),
                              imageWidget: SvgPicture.asset(
                                AssetImages.todaysCredit,
                                height: 32.h,
                              ),
                            );
                          }),

                         Obx(() {
  final refund = controller.refundcount.value?.code;

  final refundAmount = refund?.refundAmount ?? 0;
  final count = refund?.count ?? 0;

  return StatCard(
    title: 'Refunded',
    value: '${refundAmount.toString().currencyIndian}/\n$count No',
    borderColor: isDark
        ? AppColors.clrPrimary
        : const Color(0x66495BFF),
    imageWidget: SvgPicture.asset(
      AssetImages.refunded,
      height: 32.h,
    ),
    bgColor: AppColors.darkBlue.withValues(
      alpha: 0.04,
    ),
  );
}),

                          Obx(() {
                            final complaintCount =
                                controller
                                    .complaints
                                    .value
                                    ?.data
                                    ?.complaintCount ??
                                0;
                            return StatCard(
                              title: 'Complaints',
                              value: complaintCount.toString(),
                              borderColor: isDark
                                  ? AppColors.clrPrimary
                                  : Color(0x66495BFF),
                              imageWidget: SvgPicture.asset(
                                AssetImages.complaints,
                              ),
                              textColor:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const Color.fromARGB(255, 171, 171, 171)
                                  : AppColors.darktextclr,
                              bgColor: AppColors.darkBlue.withValues(
                                alpha: 0.04,
                              ),
                            );
                          }),

                          Obx(() {
                            final success =
                                controller.transactionData.value?.data?.success;

                            final amount = (success?.amount ?? 0).toDouble();
                            final count = success?.count ?? 0;

                            return StatCard(
                              bgColor: AppColors.success,
                              onTap: () {
                                final controller = Get.put(
                                  TransReportController(
                                    transreportUsecase: sl(),
                                    producttypeUseCase: sl(),
                                    submitDisputeUsecase: sl(), cashbackTypeUsecase: sl(),
                                    
                                  ),
                                );
                                controller.clearFilters();

                                Get.toNamed(
                                  AppRoutes.transaction,
                                  arguments: TransactionStatus.success,
                                );
                              },
                              title: 'Success',
                              value:
                                  '${amount.toString().currencyIndian} /\n$count Nos',
                              imageWidget: SvgPicture.asset(
                                AssetImages.successIcon,
                                 height: 24.h,
                                width: 24.w,
                              ),
                              valueColor: Colors.black,
                              borderColor: Colors.transparent,
                              textColor: Colors.green,
                            );
                          }),

                          Obx(() {
                            final processing = controller
                                .transactionData
                                .value
                                ?.data
                                ?.processing;

                            final amount = (processing?.amount ?? 0).toDouble();
                            final count = processing?.count ?? 0;

                            return StatCard(
                              bgColor: AppColors.pending,
                              onTap: () {
                                final controller =
                                    Get.put<TransReportController>(
                                      TransReportController(
                                        transreportUsecase: sl(),
                                        producttypeUseCase: sl(),
                                        submitDisputeUsecase: sl(),
                                        cashbackTypeUsecase: sl()
                                      ),
                                    );

                                controller.clearFilters();

                                Get.toNamed(
                                  AppRoutes.transaction,
                                  arguments: TransactionStatus.pending,
                                );
                              },
                              title: 'Processing',
                              value:
                                  '${amount.toString().currencyIndian} /\n$count Nos',
                              needSpacingbwImage: false,
                              imageWidget: SvgPicture.asset(
                                AssetImages.processIcon,
                                 height: 24.h,
                                width: 24.w,
                              ),
                              valueColor: Colors.black,
                              textColor: Colors.orange,
                              borderColor: Colors.transparent,
                            );
                          }),

                          Obx(() {
                            final failed =
                                controller.transactionData.value?.data?.failed;

                            final amount = (failed?.amount ?? 0).toDouble();
                            final count = failed?.count ?? 0;

                            return StatCard(
                              bgColor: AppColors.failed,
                              onTap: () {
                                final controller =
                                    Get.put<TransReportController>(
                                      TransReportController(
                                        transreportUsecase: sl(),
                                        producttypeUseCase: sl(),
                                        submitDisputeUsecase: sl(),
                                        cashbackTypeUsecase: sl()
                                      ),
                                    );
                                controller.clearFilters();

                                Get.toNamed(
                                  AppRoutes.transaction,
                                  arguments: TransactionStatus.failed,
                                );
                              },
                              title: 'Failed',
                              value:
                                  '${amount.toString().currencyIndian} /\n$count Nos',
                              needSpacingbwImage: false,
                              imageWidget: SvgPicture.asset(
                                AssetImages.failedIcon,
                                height: 24.h,
                                width: 24.w,
                              ),
                              valueColor: Colors.black,
                              textColor: Colors.red,
                              borderColor: Colors.transparent,
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
