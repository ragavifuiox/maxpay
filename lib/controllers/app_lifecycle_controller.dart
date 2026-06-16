import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class AppLifecycleController extends GetxController with WidgetsBindingObserver {
  static const String _keyLastActive = "last_active_time";
  static const Duration inactivityThreshold = Duration(minutes: 5);

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    AppLogger.logError("AppLifecycleState changed to: $state");

    final storage = LocalStorageService();
    await storage.init();

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // Save last active time when the app goes into the background
      await storage.saveString(_keyLastActive, DateTime.now().toIso8601String());
      AppLogger.logError("Saved last active time: ${DateTime.now().toIso8601String()}");
    } else if (state == AppLifecycleState.resumed) {
      // Check if threshold is exceeded when resuming
      final token = storage.getString("auth_token");
      final isPin = storage.getInt("is_pin") ?? 0;
      final isFingerPrint = storage.getInt("is_fingerprint") ?? 0;

      if (token != null && token.isNotEmpty && isPin == 1) {
        final lastActiveStr = storage.getString(_keyLastActive);
        if (lastActiveStr != null) {
          final lastActive = DateTime.tryParse(lastActiveStr);
          if (lastActive != null) {
            final elapsed = DateTime.now().difference(lastActive);
            AppLogger.logError("Elapsed time since last active: ${elapsed.inSeconds}s (Threshold: ${inactivityThreshold.inSeconds}s)");

            if (elapsed >= inactivityThreshold) {
              final currentRoute = Get.currentRoute;
              final authRoutes = [
                AppRoutes.splash,
                AppRoutes.intro,
                AppRoutes.welcome,
                AppRoutes.loginPhoneName,
                AppRoutes.otpVerification,
                AppRoutes.biometricsIntro,
                AppRoutes.biometricsScanning,
                AppRoutes.pinCodeCreation,
                AppRoutes.enterPin,
                AppRoutes.veirfypin,
              ];

              if (!authRoutes.contains(currentRoute)) {
                AppLogger.logError("Threshold exceeded. Navigating to PIN/Biometric verification screen.");
                if (isFingerPrint == 1) {
                  Get.offAllNamed(AppRoutes.veirfypin);
                } else {
                  Get.offAllNamed(AppRoutes.enterPin);
                }
              }
            }
          }
        }
      }
    }
  }
}
