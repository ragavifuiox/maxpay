import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class NewsTicker extends StatefulWidget {
  const NewsTicker({super.key});

  @override
  State<NewsTicker> createState() => _NewsTickerState();
}

class _NewsTickerState extends State<NewsTicker>
    with SingleTickerProviderStateMixin {
  final HomePageController controller = Get.find<HomePageController>();

  late ScrollController scrollController;
  late Ticker _ticker;
  double _lastElapsed = 0.0;
  String _lastNewsText = "";

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    _ticker = createTicker((elapsed) {
      if (!scrollController.hasClients) return;

      final elapsedSecs = elapsed.inMicroseconds / 1000000.0;
      final deltaSecs = elapsedSecs - _lastElapsed;
      _lastElapsed = elapsedSecs;

      // Constant speed of 45 pixels per second
      final deltaPx = deltaSecs * 45.0;

      // Infinite horizontal scroll
      scrollController.jumpTo(scrollController.offset + deltaPx);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ticker.start();
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    AppLogger.debugPrint("🔥 NewsTicker Build Called");
    AppLogger.debugPrint("🔥 Controller Hash: ${controller.hashCode}");

    return Obx(() {
      final newsResponse = controller.news.value;

      String newsText = "No News Available";

      if (newsResponse != null &&
          newsResponse.data != null &&
          newsResponse.data!.isNotEmpty) {
        newsText = newsResponse.data!.first.message ?? "";
      }

      if (_lastNewsText != newsText) {
        _lastNewsText = newsText;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!scrollController.hasClients) return;
          scrollController.jumpTo(0);
        });
      }

      return RepaintBoundary(
        child: Container(
          height: 50.h,
          margin: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isDark ? colorScheme.surface : Colors.white,
            border: Border.all(
              color: theme.brightness == Brightness.light
                  ? AppColors.clrPrimary
                  : AppColors.green,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3.r),
            child: Row(
              children: [
                /// NEWS LABEL
                ClipPath(
                  clipper: NewsClipper(),
                  child: Container(
                    width: 100.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: 15.w),
                    color: theme.brightness == Brightness.light
                        ? AppColors.clrPrimary
                        : AppColors.green,
                    child: Text(
                      'NEWS',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                /// SCROLLING NEWS
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => showNewsPopup(newsText),
                    child: IgnorePointer(
                      child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // Infinite looping items
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0 ? 12.w : 0,
                                ),
                                child: Text(
                                  newsText,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              SizedBox(width: 50.w),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

void showNewsPopup(String newsText) {
  final isDark = Get.isDarkMode;

  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            margin: EdgeInsets.only(top: 15.h, right: 15.w),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.clrPrimary, width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    // text: 'Title : ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    children: [
                      TextSpan(
                        text: 'Latest News',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(color: Colors.grey.shade400, thickness: 1),
                SizedBox(height: 10.h),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      newsText,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: isDark ? Colors.white70 : Colors.black87,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? Colors.grey[900]! : Colors.white,
                    width: 2.5,
                  ),
                ),
                child: Icon(Icons.close, color: Colors.white, size: 20.sp),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class NewsClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
