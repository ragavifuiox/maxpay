import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart'
    show GetNavigation;
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({super.key});

  
  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
  final storage = LocalStorageService();
  await storage.init();

  final token = storage.getString("auth_token");
  final isPin = storage.getInt("is_pin") ?? 0;
  final isFingerPrint = storage.getInt("is_fingerprint") ?? 0;

  AppLogger.logError("TOKEN : $token");
  AppLogger.logError("IS PIN : $isPin");
  AppLogger.logError("IS FINGERPRINT : $isFingerPrint");

  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return;

  /// Not Logged In
  if (token == null || token.isEmpty) {
    Get.offAllNamed(AppRoutes.intro);
    return;
  }

  /// Old User -> PIN Created
  if (isPin == 1) {
    if (isFingerPrint == 1) {
      Get.offAllNamed(AppRoutes.veirfypin);
    } else {
      Get.offAllNamed(AppRoutes.enterPin);
    }
    return;
  }

  /// User Logged In But No PIN
  Get.offAllNamed(AppRoutes.pinCodeCreation);
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
