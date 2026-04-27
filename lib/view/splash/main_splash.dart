import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:maxpay/core/utils/asset_images.dart';

import 'package:maxpay/core/utils/routes_path.dart';

class MainSplashScreen extends ConsumerStatefulWidget {
  const MainSplashScreen({super.key});

  @override
  ConsumerState<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends ConsumerState<MainSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(AppRoutes.intro);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SvgPicture.asset(
          isDark ? AssetImages.splashLogoDark : AssetImages.splashLogo,
          width: 240.w,
        ),
      ),
    );
  }
}
