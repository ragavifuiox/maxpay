import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maxpay/core/utils/asset_images.dart';
import 'package:maxpay/core/utils/colors.dart';
import 'package:maxpay/core/utils/routes_path.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context);
    return Scaffold(
      backgroundColor: colorScheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: TextButton.icon(
              onPressed: () => context.go(AppRoutes.welcome),
              iconAlignment: IconAlignment.end,
              icon: Icon(
                Icons.skip_next,
                color: AppColors.clrSecondary,
                size: 24.sp,
              ),
              label: Text(
                'Skip',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppColors.clrSecondary,
                  letterSpacing: -0.41,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: introData.length,
              itemBuilder: (context, index) {
                final data = introData[index];
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.h),
                        Center(
                          child: Image.asset(
                            data['image'],
                            height: 280.h,
                            width: 300.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: introData.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: AppColors.clrPrimary,
                              dotColor: Colors.grey.withValues(alpha: 0.3),
                              dotHeight: 6.h,
                              dotWidth: 8.w,
                              expansionFactor: 4,
                              spacing: 6.w,
                            ),
                          ),
                        ),
                        SizedBox(height: 60.h),
                        Text(
                          data['title'],
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 22.sp,
                            color: colorScheme.textTheme.bodyLarge!.color,
                            letterSpacing: .01,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          data['description'],
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: AppColors.clrTextgrey,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _currentPage > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  child: Text(
                    'Back',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,

                      fontSize: 16.sp,
                      color: _currentPage > 0
                          ? Colors.black
                          : Colors.transparent,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  text: 'Next',
                  width: 160.w,
                  height: 54.h,
                  onPressed: () {
                    if (_currentPage < introData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.go(AppRoutes.welcome);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

final List<Map<String, dynamic>> introData = [
  {
    "title": "Instant Credit Top-Up",
    "image": AssetImages.splash1,
    "description":
        "Instant credit top-up—fast, secure, and hassle-free with Max Pay!",
  },
  {
    "title": "Grow Your Revenue",
    "image": AssetImages.splash2,
    "description":
        "Boost your earnings effortlessly with fast and secure payments!",
  },
  {
    "title": "Secure & Smart E-Wallet",
    "image": AssetImages.splash3,
    "description":
        "Experience safe, fast, and hassle-free digital transactions with Max Pay!",
  },
];
